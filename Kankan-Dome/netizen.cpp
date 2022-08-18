#include "netizen.h"
#include <string>
#include <iostream>
#include "netizenbroker.h"

using json = nlohmann::json;

Netizen::Netizen(std::string id, std::string password, std::string nickname) :
    m_id{id}, m_password{password}, m_nickname{nickname}
{
}

Netizen::~Netizen()
{

}

std::string Netizen::insertSql()
{
    return "insert into user values( '" + m_id + "', '" + m_password + "', '" + m_nickname + "');";
}

Netizen::Netizen(std::string id, std::string nickname, std::string headPortrait, std::vector<std::string> manuscriptsId,
                 std::vector<std::string> fansId, std::vector<std::string> followersId) :
    m_id{id}, m_headPortrait{headPortrait}, m_password{" "}, m_nickname{nickname}
{
    for (auto vId : manuscriptsId) {
        _manuscripts.insert(std::make_pair(vId, ManuscriptProxy(vId)));
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

nlohmann::json Netizen::init()
{
    //粉丝及关注者数据读取简化处理
    //getManuscriptInfo如何存储返回的数据
    nlohmann::json netizenInfo;
    netizenInfo["id"] = m_id;
    netizenInfo["nickname"] = m_nickname;
    netizenInfo["headPortrait"] = m_headPortrait;
    for (auto& manuscript : _manuscripts){
        nlohmann::json v = manuscript.second.getManuscriptInfo(manuscript.first);
        netizenInfo["videos"].push_back(v);
    }
    if (_manuscripts.size() == 0) netizenInfo["videos"] = "";

    for (auto& fan : _fans) {
        nlohmann::json f = fan.second.getInfo(fan.first);
        netizenInfo["fans"].push_back(f);
    }
    if (_fans.size() == 0) netizenInfo["fans"] = "";

    for (auto& follower : _followers) {
        nlohmann::json f = follower.second.getInfo(follower.first);
        netizenInfo["followers"].push_back(f);
    }
    if (_followers.size() == 0) netizenInfo["followers"] = "";


    return netizenInfo;
}

nlohmann::json Netizen::getInfo()
{
    json results;
    results["headPortrait"] = m_headPortrait;
    results["nickname"] = m_nickname;

    //测试
//    std::cout << "NetizenInfo: " ;
//    std::cout << results.dump(4) << std::endl;

    return results;
}

void Netizen::modifyHeadportrait(const std::string &newHeadportrait)
{
    m_headPortrait = newHeadportrait;

    NetizenBroker::getInstance()->modifyHeadportrait(m_id, m_headPortrait);
}

void Netizen::modifyNickname(const std::string &newNickname)
{
    m_nickname = newNickname;

    NetizenBroker::getInstance()->modifyNickname(m_id, m_nickname);
}

bool Netizen::modifyPassword(const std::string &oldPassword, const std::string &newPassword)
{
    //验证旧密码
    if (!NetizenBroker::getInstance()->qualifyNetizenPassword(m_id, oldPassword))
        return false;

    //更换新密码
    m_password = newPassword;
    NetizenBroker::getInstance()->modifyPassword(m_id, m_password);
    return true;
}

void Netizen::modifyManuscriptInfo(nlohmann::json newManuscriptInfo)
{
    //首先：将json里面的数据读取出来
    std::string manuscriptId = newManuscriptInfo["manuscriptId"].get<std::string>();
    std::string description = newManuscriptInfo["description"].get<std::string>();
    std::string title = newManuscriptInfo["title"].get<std::string>();
    std::string label = newManuscriptInfo["label"].get<std::string>();
    std::string subarea = newManuscriptInfo["subarea"].get<std::string>();
    std::string isOri = newManuscriptInfo["isOriginal"].get<std::string>();

    bool isOriginal;
    std::istringstream(isOri) >> std::boolalpha >> isOriginal;

    std::string cover = newManuscriptInfo["cover"].get<std::string>();
    std::string date = newManuscriptInfo["date"].get<std::string>();

    //修改_manuscripts中对应的那个manucriptproxy对象中的manscript实体的信息；
    //利用proxy中的broker再修改对应的数据库信息
}
