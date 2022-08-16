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
    nlohmann::json getManuscriptInfo(const std::string& id);
    //获取稿件的相关信息(发布时间、封面、视频时长、标题)
    //id：稿件id

    ~ManuscriptProxy();
private:
    std::string m_id;
    std::shared_ptr<Manuscript> m_manuscript;
};

#endif // MANUSCRIPTPROXY_H
