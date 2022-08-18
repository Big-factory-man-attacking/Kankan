#include "netizenproxy.h"
#include "netizenbroker.h"
#include "netizen.h"
#include <iostream>

using json = nlohmann::json;

NetizenProxy::NetizenProxy(std::string id) :
    m_id{id}, m_netizen{}
{

}

NetizenProxy::~NetizenProxy()
{

}

nlohmann::json NetizenProxy::getInfo(const std::string& id)
{
    if (m_netizen == nullptr)
        m_netizen = NetizenBroker::getInstance()->findNetizenById(id);
    return m_netizen->getInfo();
}
