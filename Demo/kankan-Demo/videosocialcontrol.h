#ifndef VIDEOSOCIALCONTROL_H
#define VIDEOSOCIALCONTROL_H

#include <string>
#include <memory>
#include <vector>
#include "json.hpp"

class Netizen;

class VideoSocialControl
{
public:
    VideoSocialControl();

    //注册
    //password:用户设置的密码
    void registerAccount(std::string password, std::string nickname);

    //登录
    //id:用户输入的帐号
    //key:用户输入的密码
    nlohmann::json login(std::string id, std::string password);

    //假设服务器记录每次上传视频的id，保存为一个列表，首页总是显示最新的一批视频
    nlohmann::json getSomeVideos();

    //用户选择了某个稿件进行观看，加载稿件的完整信息
    nlohmann::json loadVideo(std::string id);

    //合并视频,返回id、合并后的视频路径
    std::pair<std::string, std::string> mergeVideoFiles(std::vector<std::string> videoFiles);

    //更换视频文件
    std::pair<std::string, std::string> changeVideoFile(std::vector<std::string> videoFiles);

    //生成稿件
    void createVideo(std::string description, std::string title, std::string label,
                     std::string subarea, bool isOriginal, std::string cover, std::string date,
                     std::vector<std::string> commentIds, std::string videoFileId);

    //关注
    void focusOn();

    //取关
    void takeOff();

    //修改用户头像
    void modifyHeadportrait(const std::string& netizenId, const std::string& newHeadportrait);

    //修改用户昵称
    void modifyNickname(const std::string& netizenId, const std::string& newNickname);

    //修改用户密码
    bool modifyPassword(const std::string& netizenId, const std::string& oldPassword, const std::string& newPassword);

    //修改稿件信息
    void modifyManuscriptInfo(const std::string& netizenId, nlohmann::json newManuscriptInfo);

    //删除稿件
    void deleteManuscript(const std::string& netizenId, const std::string& manuscriptId);
};

#endif // VIDEOSOCIALCONTROL_H
