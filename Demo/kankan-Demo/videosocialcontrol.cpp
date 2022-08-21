#include "videosocialcontrol.h"
#include "netizen.h"
#include "netizenbroker.h"
#include <iostream>
#include <utility>
#include <time.h>
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include "manuscriptbroker.h"

extern "C" {
#include <libavutil/timestamp.h>
#include <libavformat/avformat.h>
}

using json = nlohmann::json;

VideoSocialControl::VideoSocialControl()
{

}

//注册
void VideoSocialControl::registerAccount(QString password, QString nickname)
{
    //利用boost/uuid库生成uuid
    boost::uuids::random_generator gen;
    boost::uuids::uuid  uid = gen();

    std::string id = to_string(uid);

    std::cout << id << std::endl;

    //注册成功后直接登录
    //初始用户数据库无数据,无需进行用户数据的init
    std::shared_ptr<NetizenProxy> netizenProxy = std::make_shared<NetizenProxy>(id);

    netizenProxy->addNetizen(id, password.toStdString(), nickname.toStdString());
}

QJsonObject VideoSocialControl::transition(nlohmann::json json)
{
    std::string info = json.dump();
    const char *ch=info.data();

    QByteArray byte_array;
    QJsonParseError json_error;
    QJsonObject rootObj;   //最后转换出来的json 对象
    QJsonDocument parse_doucment = QJsonDocument::fromJson(byte_array.append(ch), &json_error);
    if(json_error.error == QJsonParseError::NoError) {
           if(parse_doucment.isObject())
           {
               rootObj = parse_doucment.object();
           }
    } else {
        qDebug()<<json_error.errorString();
    }
    return rootObj;
}

//登录
QJsonObject VideoSocialControl::login(QString id, QString key)
{
    nlohmann::json info;
    if (NetizenBroker::getInstance()->qualifyNetizenId(id.toStdString())) {
        std::cout << "用户id存在" << std::endl;
        if (NetizenBroker::getInstance()->qualifyNetizenPassword(id.toStdString(), key.toStdString())) {
            std::cout << "密码正确" << std::endl;

            auto netizen = NetizenBroker::getInstance()->findNetizenById(id.toStdString());

            info = netizen->init();//初始化稿件（含视频）、粉丝列表、关注列表初始化
            std::cout << info.dump(4);
            return transition(info);
        } else {
            std::cout << "密码错误" << std::endl;
            return transition(info);
        }
    } else {
        std::cout << "用户id不存在" << std::endl;
        return transition(info);
    }
}

QJsonObject VideoSocialControl::getSomeVideos()
{
    //获取一些稿件的id
    std::map<std::string, std::string> manuscriptIds;
    manuscriptIds = ManuscriptBroker::getInstance()->getManuscripts();

    //创建稿件的proxy
    std::unordered_map<std::string, ManuscriptProxy> _manuscripts;
    for (auto& id : manuscriptIds)
        _manuscripts.insert(std::make_pair(id.first, ManuscriptProxy(id.first)));

    //创建网民的proxy
    std::unordered_multimap<std::string, NetizenProxy> _netizens;
    for (auto& id : manuscriptIds)
        _netizens.insert(std::make_pair(id.second, NetizenProxy(id.second)));


    //获取稿件、对应创作者的摘要信息
    json manuscirptInfos;

    for (auto& manuscript : _manuscripts) {
        json manuscriptInfo = manuscript.second.getManuscriptInfo(manuscript.first);
        manuscirptInfos["manuscriptInfo"].push_back(manuscriptInfo);
    }

    for (auto& netizen : _netizens) {
        json netizenInfo = netizen.second.getInfo(netizen.first);
        manuscirptInfos["netizenInfo"].push_back(netizenInfo);
    }
    std::cout << manuscirptInfos.dump(4) << std::endl;
    return transition(manuscirptInfos);
}

nlohmann::json VideoSocialControl::loadVideo(std::string id)
{
    //首先找到对应的稿件
    auto manuscript = ManuscriptBroker::getInstance()->getManuscript(id);

    //读取稿件的数据
    json manuscriptInfo = manuscript->getManuscriptInfo();

    return manuscriptInfo;
}

std::pair<std::string, std::string> VideoSocialControl::mergeVideoFiles(std::vector<std::string> videoFiles)
{
/*
    //合并视频，保存一个本地的合并后的视频文件地址
    qDebug() << "正在进行合并";
    //处理导入文件的路径
    QList<QString> filelist;
    for(int i = 0; i < fileList.length(); i++)
    {
        filelist.push_back(fileList[i].right(fileList[i].length()-7));
        qDebug()<<"filelist[i] = "<<filelist[i];
    }

    //生成临时文件名
    QList<QString> outpathNames;
    for (int i = 0;i < filelist.length();i++)
    {
        QString fileName = "out" + QString::number(i,10) + ".mp4";
        outpathNames.push_back(fileName);
        qDebug()<<fileName;
    }

    //获取第一个视频的宽高
    QString temp = filelist[0];
    AVFormatContext *fmtCtx = nullptr;
    int width, height;
    std::string tr;
    QString fileFormat;
    tr= temp.toStdString();
    const char *in_filename = tr.data();
    int ret = avformat_open_input(&fmtCtx, in_filename, NULL, NULL);
    if(ret) {
        qDebug()<<"open input failed";
    }
    ret = avformat_find_stream_info(fmtCtx, NULL);
    int videoIndex = av_find_best_stream(fmtCtx,  AVMEDIA_TYPE_VIDEO, -1, -1, nullptr, 0);
    width = fmtCtx->streams[videoIndex]->codec->width;
    height = fmtCtx->streams[videoIndex]->codec->height;
    fileFormat = fmtCtx->streams[videoIndex]->codecpar->format;

    //存储临时文件
    QString width1 = QString::number(width, 10);
    QString height1 = QString::number(height, 10);

    //在转换之前将之前out1,ou2,...文件给删掉 第一次执行不会删
    for(int del = 0; del < filelist.length(); del++)
    {
        QString file = "rm ./out" + QString::number(del, 10) + ".mp4";
        const char *rmFile = file.toStdString().c_str();
        system(rmFile);
    }

    //进行格式转换，存储为临时文件
    for(int i = 0; i < filelist.length();i++)
    {
        std::string cmd = "ffmpeg -i " + (filelist[i]).toStdString() + "  -vf scale="+ (width1).toStdString()+ ":" + (height1).toStdString() + " ./" + (outpathNames[i]).toStdString();
        const char* cmd1 = cmd.c_str();
        system(cmd1);
    }

    QFile file("in.txt");

    if(!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        return -1;
    }
    QTextStream stream(&file);

    for(int i = 0; i < outpathNames.length(); i++)
    {
        stream << "file \'" <<"./"<< outpathNames[i] << "\'"<< "\n";
        qDebug()<<"file \'" <<"./"<< outpathNames[i] << "\'";
    }


    cmd = "ffmpeg -f concat -safe 0 -i ./in.txt -c copy  ./新视频1.mp4 -y" ;
    char* ch;
    QByteArray ba = cmd.toLatin1(); // must
    ch=ba.data();
    QProcess *process = new QProcess;
    connect(process, SIGNAL(finished(int, QProcess::ExitStatus)), this, SLOT(domove(int, QProcess::ExitStatus)));
    qDebug()<<"cmd is "<< cmd;
    if(process-> state() != process->NotRunning)
    {
        process->waitForFinished();
    }

    process->start(cmd);

    return 0;

*/
    //生成一个新的VideoFile的id

    //返回视频id
}

std::pair<std::string, std::string> VideoSocialControl::changeVideoFile(std::vector<std::string> videoFiles)
{
    mergeVideoFiles(videoFiles);

    //清理上次生成的视频
}



void VideoSocialControl::createVideo(std::string description, std::string title, std::string label,
                                     std::string subarea, bool isOriginal, std::string cover, std::string date,
                                     std::vector<std::string> commentIds, std::string videoFileId)
{
    //生成Video的id

    //构造Video对象

    //将video对象上传到服务器

    //相关写数据库操作
}

void VideoSocialControl::focusOn(QString fanId, QString followerId, QString followerNickname)
{
    auto fanProxy = std::make_shared<NetizenProxy>(fanId.toStdString());

    fanProxy->focusOn(followerId.toStdString(), followerNickname.toStdString());

}

void VideoSocialControl::takeOff(QString fanId, QString followerId)
{
    auto fanProxy = std::make_shared<NetizenProxy>(fanId.toStdString());

    fanProxy->takeOff(followerId.toStdString());
}


void VideoSocialControl::modifyHeadportrait(const QString &netizenId, const QString &newHeadportrait)
{
    auto netizenProxy = std::make_shared<NetizenProxy>(netizenId.toStdString());
    netizenProxy->modifyHeadportrait(newHeadportrait.toStdString());
}

void VideoSocialControl::modifyNickname(const QString &netizenId, const QString &newNickname)
{
    auto netizenProxy = std::make_shared<NetizenProxy>(netizenId.toStdString());
    netizenProxy->modifyNickname(newNickname.toStdString());
}

bool VideoSocialControl::modifyPassword(const QString &netizenId, const QString &oldPassword, const QString &newPassword)
{
    auto netizenProxy = std::make_shared<NetizenProxy>(netizenId.toStdString());
    return netizenProxy->modifyPassword(oldPassword.toStdString(), newPassword.toStdString());
}

nlohmann::json VideoSocialControl::getJsonFromJsonObject(QJsonObject qjson)
{
    QString str = QString(QJsonDocument(qjson).toJson());
    std::string strjson = str.toStdString();
    nlohmann::json json = nlohmann::json::parse(strjson);
    return json;
}

void VideoSocialControl::modifyManuscriptInfo(const QString &netizenId, QJsonObject newManuscriptInfo)
{
    auto netizenProxy = std::make_shared<NetizenProxy>(netizenId.toStdString());
    std::cout << getJsonFromJsonObject(newManuscriptInfo) << std::endl;
    netizenProxy->modifyManuscriptInfo(getJsonFromJsonObject(newManuscriptInfo));

}

void VideoSocialControl::deleteManuscript(const QString &netizenId, const QString &manuscriptId)
{
    auto netizenProxy = std::make_shared<NetizenProxy>(netizenId.toStdString());
    netizenProxy->deleteManuscript(manuscriptId.toStdString());
}


