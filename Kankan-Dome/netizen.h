#ifndef NETIZEN_H
#define NETIZEN_H

#include <string>
#include <unordered_map>
#include <utility>
#include "manuscriptproxy.h"
#include "netizenproxy.h"
#include "netizeninterface.h"
#include <vector>
#include "json.hpp"

class Netizen : public NetizenInterface
{
public:
    Netizen(std::string id, std::string password, std::string nickname);
    ~Netizen();

    //创造insert的sql语句
    std::string insertSql();

    //获取用户id,昵称，所有的稿件id，粉丝的id，关注者的id
    //id:用户id
    //nickname:用户昵称
    //manuscriptsId:稿件的id
    //fansId:粉丝的id
    //followersId:关注者的id
    Netizen(std::string id, std::string nickname, std::string headPortrait, std::vector<std::string> manuscriptsId,
            std::vector<std::string> fansId, std::vector<std::string> followersId);

    //登录后进行信息初始化
    nlohmann::json init();

    //返回网民的昵称和头像
    nlohmann::json getInfo();

    //修改网民的头像
    void modifyHeadportrait(const std::string& newHeadportrait);

    //修改网民的昵称
    void modifyNickname(const std::string& newNickname);

    //修改密码
    bool modifyPassword(const std::string& oldPassword, const std::string& newPassword);

    //修改稿件信息
    void modifyManuscriptInfo(nlohmann::json newManuscriptInfo);

private:
    std::string m_id;                                               //用户id
    std::string m_headPortrait;                                     //用户头像
    std::string m_password;                                         //用户密码
    std::string m_nickname;                                         //用户昵称
    std::unordered_map<std::string, ManuscriptProxy> _manuscripts;         //稿件(稿件id，代理)
    std::unordered_map<std::string, NetizenProxy> _fans;                   //粉丝(粉丝id，代理)
    std::unordered_map<std::string, NetizenProxy> _followers;              //关注者(关注者id, 代理)
};

#endif // NETIZEN_H
