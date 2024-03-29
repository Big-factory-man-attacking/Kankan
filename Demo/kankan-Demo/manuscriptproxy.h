#ifndef MANUSCRIPTPROXY_H
#define MANUSCRIPTPROXY_H

#include <memory>
#include "manuscriptinterface.h"
#include <vector>
#include "json.hpp"

class Manuscript;

class ManuscriptProxy : public ManuscriptInterface
{
public:
    ManuscriptProxy(std::string id);

    //获取稿件的相关信息(发布时间、封面、视频时长、标题)
    //id：稿件id
    nlohmann::json getManuscriptInfo(const std::string& id);


    // 修改稿件的信息
    // newManuscriptInfo：新的稿件信息
    void modifyManuscriptInfo(const nlohmann::json& newManuscriptInfo);

    // 删除稿件
    // manuscriptId：稿件id
    void deleteManuscript(const std::string& manuscriptId);

    ~ManuscriptProxy();
private:
    std::string m_id;
    std::shared_ptr<Manuscript> m_manuscript;
};

#endif // MANUSCRIPTPROXY_H
