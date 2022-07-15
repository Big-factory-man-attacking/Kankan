#include "videosocialcontrol.h"
#include "netizen.h"
#include "netizenbroker.h"
#include <iostream>
#include <utility>
#include <time.h>
#include "commentbroker.h"
#include "videobroker.h"
#include "videofilebroker.h"


VideoSocialControl::VideoSocialControl()
{
    m_timer.start(2000, flush);
}

VideoSocialControl::~VideoSocialControl()
{

}

//注册
void VideoSocialControl::login(std::string key)
{
    //1. 生成帐号
    time_t result = time(NULL);
    long id{0};
    if (result != (time_t)(-1))
        id = result;    //系统根据时间分配id

    //2. 生成netizen对象，并将netizen对象存入缓存
    Netizen netizen(id, key);
    NetizenBroker::getInstance()->addNetizen(id, netizen);

//    //添加新的用户记录
//    NetizenBroker::getInstance()->insertNewNetizen(std::make_shared<Netizen>(id, key));

    //注册成功后自动登录
    login(id, key);
}

//登录
void VideoSocialControl::login(long id, std::string key)
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

std::string VideoSocialControl::mergeVideoFiles(std::vector<std::string> videoFiles)
{
    //合并视频，保存一个本地的合并后的视频文件地址

    //生成一个新的VideoFile的id

    //返回视频id

}

void VideoSocialControl::createVideo(std::string description, std::string title, std::string label, std::string subarea, bool isOriginal, std::string cover, std::string date, long user_id, std::string videoFileId)
{
    //1. 生成Video的id
    std::string id ="1";
    //新创建的稿件没有评论
    std::vector<std::string> comments;
    //2. 构造Video对象
    Video video(id, description, title, label, subarea, isOriginal, cover,
                date, user_id, comments, videoFileId);

    //3. 将video存入缓存
    VideoBroker::getInstance()->addVideo(id, video);

    //4. 将videoFile对象存入缓存
    //在这之前，还是需要一个VideoFile对象
   // VideoFileBroker::getInstance()->addVideoFile(videoFileId, )

    //5. 建立稿件和网民的联系,首先找到对应的网民，然后将稿件交给网民
    auto netizen = NetizenBroker::getInstance()->findNetizenById(user_id);
    netizen->addNewVideo(id);


}

void VideoSocialControl::commentVideo(std::string &content, long netizenId, const std::string videoId)
{
    auto netizen=NetizenBroker::getInstance()->findNetizenById(netizenId);
    netizen->comment(content, videoId);
}

void VideoSocialControl::flush()
{
    NetizenBroker::getInstance()->flush();
    VideoBroker::getInstance()->flush();
    VideoFileBroker::getInstance()->flush();
    CommentBroker::getInstance()->flush();
    std::cout << "执行了一次刷新" << std::endl;
}


