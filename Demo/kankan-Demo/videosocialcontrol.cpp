#include "videosocialcontrol.h"
#include "netizen.h"
#include "netizenbroker.h"
#include <iostream>
#include <utility>
#include <time.h>

VideoSocialControl::VideoSocialControl()
{

}

//注册
void VideoSocialControl::login(std::string password)
{
    std::string id;

    //添加新的用户记录
    NetizenBroker::getInstance()->insertNewNetizen(std::make_shared<Netizen>(id, password));

    //注册成功后直接登录
    //初始用户数据库无数据
    login(id, password);
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
    //合并视频，保存一个本地的合并后的视频文件地址

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


