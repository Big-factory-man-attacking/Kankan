#include "manuscript.h"
#include "videoproxy.h"
#include <utility>
#include <iostream>
#include "json.hpp"

using json = nlohmann::json;

Manuscript::Manuscript(std::string id, std::string description, std::string title, std::string label,
             std::string subarea, bool isOriginal, std::string cover, std::string date,
             std::vector<std::string> commentIds, std::string videoId) :
    m_id{id}, m_description{description}, m_title{title},
    m_label{label}, m_subarea{subarea}, m_isOriginal{isOriginal},
    m_cover{cover}, m_date{date}, m_video(std::make_pair(videoId, VideoProxy(videoId)))
{
    for (auto commentId : commentIds)
        _comments.insert(std::make_pair(commentId, CommentProxy(commentId)));
}

Manuscript::~Manuscript()
{

}

nlohmann::json Manuscript::getManuscriptInfo()
{
    std::cout << "--------------------------------------------" << std::endl;

    json info;

    info["title"] = m_title;
    info["cover"] = m_cover;
    info["date"] = m_date;
    info["duration"] = m_video.second.getVideoInfo(m_video.first);

    //测试
//    std::cout << info.dump(4) << std::endl;

    return info;
}

void Manuscript::init(std::string id)
{
    std::cout << "视频时长" << m_video.second.getVideoInfo(id) << std::endl;

    for (auto &comment : _comments)
        std::cout << "评论正文： " << comment.second.getCommentInfo(comment.first) << std::endl;
}
