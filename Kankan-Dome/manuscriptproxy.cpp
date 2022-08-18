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

    if (m_manuscript == nullptr)
        m_manuscript = ManuscriptBroker::getInstance()->getManuscript(id);
        //实例化Manuscript对象
    return m_manuscript->getManuscriptInfo();//获取video对象的数据概要
}

ManuscriptProxy::~ManuscriptProxy()
{

}
