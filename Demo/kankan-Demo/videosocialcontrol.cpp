#include "videosocialcontrol.h"
#include "netizen.h"
#include "netizenbroker.h"
#include <iostream>
#include <utility>
#include <time.h>
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>

extern "C" {
#include <libavutil/timestamp.h>
#include <libavformat/avformat.h>
}

VideoSocialControl::VideoSocialControl()
{

}

//注册
void VideoSocialControl::login(std::string password)
{
    //利用boost/uuid库生成uuid
    boost::uuids::random_generator gen;
    boost::uuids::uuid  uid = gen();

    std::string id = to_string(uid);

    std::cout << id << std::endl;

    //注册成功后直接登录
    //初始用户数据库无数据,无需进行用户数据的init
    std::shared_ptr<Netizen> netizen = std::make_shared<Netizen>(id, password);

    //添加新的用户记录
    NetizenBroker::getInstance()->insertNewNetizen(netizen);
}

//登录
void VideoSocialControl::login(std::string id, std::string key)
{
    if (NetizenBroker::getInstance()->qualifyNetizenId(id)) {
        std::cout << "用户id存在" << std::endl;
        if (NetizenBroker::getInstance()->qualifyNetizenKey(id, key)) {
            std::cout << "密码正确" << std::endl;

            auto netizen = NetizenBroker::getInstance()->findNetizenById(id);

            netizen->init();//初始化稿件（含视频）、粉丝列表、关注列表初始化

        } else {
            std::cout << "密码错误" << std::endl;
        }
    } else {
        std::cout << "用户id不存在" << std::endl;
    }


}

void VideoSocialControl::getSomeVideos(std::vector<std::string> ids)
{
    std::unordered_map<std::string, VideoProxy> _videos;
    for (auto id : ids)
        _videos.insert(std::make_pair(id, VideoProxy(id)));

    //通过数据库检索找到对应稿件的netizen


    //获取稿件的摘要信息
    for (auto video : _videos)
        video.second.getVideoInfo(video.first);

    //整合网民信息与稿件的摘要信息

}

void VideoSocialControl::loadVideo(std::string id)
{

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

void VideoSocialControl::focusOn()
{

}

void VideoSocialControl::takeOff()
{

}


