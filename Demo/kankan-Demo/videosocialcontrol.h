#ifndef VIDEOSOCIALCONTROL_H
#define VIDEOSOCIALCONTROL_H

#include <string>
#include <memory>
#include <vector>
#include "json.hpp"
#include <QObject>
#include <QtQml>
#include <QJsonObject>

class Netizen;

class VideoSocialControl : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    VideoSocialControl();

    // 注册
    // password:用户设置的密码
    Q_INVOKABLE void registerAccount(QString password, QString nickname);

    // 登录
    // id:用户输入的帐号
    // key:用户输入的密码
    Q_INVOKABLE QJsonObject login(QString id, QString password);

    // 将nlohmann::json 转换为 QJsonObject
    QJsonObject transition(nlohmann::json json);

    // 假设服务器记录每次上传视频的id，保存为一个列表，首页总是显示最新的一批视频
    Q_INVOKABLE QJsonObject getSomeVideos();

    // 用户选择了某个稿件进行观看，加载稿件的完整信息
    nlohmann::json loadVideo(std::string id);

    // 合并视频,返回id、合并后的视频路径
    std::pair<std::string, std::string> mergeVideoFiles(std::vector<std::string> videoFiles);

    // 更换视频文件
    std::pair<std::string, std::string> changeVideoFile(std::vector<std::string> videoFiles);

    // 生成稿件
    void createVideo(std::string description, std::string title, std::string label,
                     std::string subarea, bool isOriginal, std::string cover, std::string date,
                     std::vector<std::string> commentIds, std::string videoFileId);

    // 关注
    // fanId:当前使用者id
    // followerId:被关注者id
    Q_INVOKABLE void focusOn(QString fanId, QString followerId, QString followerNickname);

    // 取关
    // fanId:当前使用者id
    // followerId:被关注者id
    Q_INVOKABLE void takeOff(QString fanId, QString followerId);

    // 修改用户头像
    Q_INVOKABLE void modifyHeadportrait(const QString& netizenId, const QString& newHeadportrait);

    // 修改用户昵称
    Q_INVOKABLE void modifyNickname(const QString& netizenId, const QString& newNickname);

    // 修改用户密码
    Q_INVOKABLE bool modifyPassword(const QString& netizenId, const QString& oldPassword, const QString& newPassword);

    // 将qml传递的QJsonObject转换为nlohmann::json
    nlohmann::json getJsonFromJsonObject(QJsonObject qjson);

    // 修改稿件信息
    Q_INVOKABLE void modifyManuscriptInfo(const QString& netizenId, QJsonObject newManuscriptInfo);

    // 删除稿件
    Q_INVOKABLE void deleteManuscript(const QString& netizenId, const QString& manuscriptId);
};

#endif // VIDEOSOCIALCONTROL_H
