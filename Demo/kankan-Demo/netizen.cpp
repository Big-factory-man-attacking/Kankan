#include "netizen.h"
#include <string>
#include <iostream>

using json = nlohmann::json;

Netizen::Netizen(std::string id, std::string password) :
    m_id{id}, m_password{password}
{
        m_nickname = "kk_" + id;     //生成默认用户名
}

Netizen::~Netizen()
{

}

std::string Netizen::insertSql()
{
    return "insert into user values( '" + m_id + "', '" + m_password + "', '" + m_nickname + "');";
}

Netizen::Netizen(std::string id, std::string nickname, std::string headPortrait, std::vector<std::string> videosId,
                 std::vector<std::string> fansId, std::vector<std::string> followersId) :
    m_id{id}, m_headPortrait{headPortrait}, m_password{" "}, m_nickname{nickname}
{
    for (auto vId : videosId) {
        _videos.insert(std::make_pair(vId, VideoProxy(vId)));
        std::cout << "稿件id：" ;
        std::cout << vId << std::endl;
    }

    for (auto fanId : fansId) {
        _fans.insert(std::make_pair(fanId, NetizenProxy(fanId)));
        std::cout << "粉丝id：" ;
        std::cout << fanId << std::endl;
    }

    for (auto followerId : followersId) {
        _followers.insert(std::make_pair(followerId, NetizenProxy(followerId)));
        std::cout << "关注者id：";
        std::cout << followerId << std::endl;
    }
}

void Netizen::init()
{
    //粉丝及关注者数据读取简化处理
    //getVideoInfo如何存储返回的数据
    json videoInfo;
    json fanInfo;
    json followerInfo;

    for (auto &video : _videos){
        videoInfo = video.second.getVideoInfo(video.first);
    }
    for (auto &fan : _fans)
        fanInfo = fan.second.getInfo(fan.first);

    for (auto &follower : _followers)
        followerInfo = follower.second.getInfo(follower.first);
}

nlohmann::json Netizen::getInfo()
{
    json results;
    results["headPortrait"] = m_headPortrait;
    results["nickname"] = m_nickname;

    //测试
    std::cout << "NetizenInfo: " ;
    std::cout << results.dump(4) << std::endl;

    return results;
}
