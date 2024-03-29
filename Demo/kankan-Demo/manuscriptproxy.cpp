#include "manuscriptproxy.h"
#include <vector>
#include "manuscriptbroker.h"
#include <iostream>

ManuscriptProxy::ManuscriptProxy(std::string id) :
    m_id{id}, m_manuscript{}
{

}

nlohmann::json ManuscriptProxy::getManuscriptInfo(const std::string& id)
{
    // 实例化Manuscript对象
    if (m_manuscript == nullptr)
        m_manuscript = ManuscriptBroker::getInstance()->getManuscript(id);

    //获取video对象的数据概要
    return m_manuscript->getManuscriptInfo();
}

void ManuscriptProxy::modifyManuscriptInfo(const nlohmann::json &newManuscriptInfo)
{
    if (m_manuscript == nullptr)
        m_manuscript = ManuscriptBroker::getInstance()->getManuscript(m_id);

    // 将json里面的数据读取出来
    std::string manuscriptId = newManuscriptInfo["id"].get<std::string>();
    std::string description = newManuscriptInfo["description"].get<std::string>();
    std::string title = newManuscriptInfo["title"].get<std::string>();
    std::string label = newManuscriptInfo["label"].get<std::string>();
    std::string subarea = newManuscriptInfo["subarea"].get<std::string>();
    std::string isOri = newManuscriptInfo["isOriginal"].get<std::string>();
    bool isOriginal;
    std::istringstream(isOri) >> std::boolalpha >> isOriginal;
    std::string cover = newManuscriptInfo["cover"].get<std::string>();
    std::string date = newManuscriptInfo["date"].get<std::string>();

    // 修改稿件实体
    m_manuscript->modifyManuscriptInfo(description, title, label,
                                       subarea, isOriginal, cover, date);
    // 修改数据库数据
    ManuscriptBroker::getInstance()->modifyManuscriptInfo(m_id, description, title, label,
                                                          subarea, isOri, cover, date);
}

void ManuscriptProxy::deleteManuscript(const std::string &manuscriptId)
{
    ManuscriptBroker::getInstance()->deleteManuscript(manuscriptId);
}

ManuscriptProxy::~ManuscriptProxy()
{

}
