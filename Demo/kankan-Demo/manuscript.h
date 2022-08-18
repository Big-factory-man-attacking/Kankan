#ifndef MANUSCRIPT_H
#define MANUSCRIPT_H

#include <string>
#include <memory>
#include "manuscriptinterface.h"
#include <vector>
#include <unordered_map>
#include "videoproxy.h"
#include "commentproxy.h"
#include "json.hpp"

class Video;

class Manuscript : public ManuscriptInterface
{
public:
    Manuscript() = delete;
    Manuscript(std::string id, std::string description, std::string title, std::string label,
          std::string subarea, bool isOriginal, std::string cover, std::string date,
          std::vector<std::string> commentIds, std::string videoId);
    ~Manuscript();

    nlohmann::json getManuscriptInfo();
    //获取稿件的数据（标题、发布时间、稿件时长[通过m_video对象去获取时长]、封面）
    //后续可考虑替换为json传输

    void init(std::string id);
    //通过代理实例化video对象

    void modifyManuscriptInfo(std::string description, std::string title, std::string label, std::string subarea,
                         bool isOriginal, std::string cover, std::string date);
private:
    std::string m_id;           //稿件id
    std::string m_description;  //简介
    std::string m_title;        //标题
    std::string m_label;        //标签
    std::string m_subarea;      //分区
    bool m_isOriginal;          //是否是转载
    std::string m_cover;        //封面（存文件路径）
    std::string m_date;         //发布时间(后期需考虑是否使用date)

    std::unordered_map<std::string, CommentProxy> _comments;
    std::pair<std::string, VideoProxy> m_video;
};

#endif // MANUSCRIPT_H
