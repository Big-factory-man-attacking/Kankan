#ifndef NETIZENPROXY_H
#define NETIZENPROXY_H

#include <memory>
#include "netizeninterface.h"
#include <vector>
#include "json.hpp"

class Netizen;

class NetizenProxy : public NetizenInterface
{
public:
    NetizenProxy(std::string id);
    ~NetizenProxy();

    nlohmann::json getInfo(const std::string& id);
private:
    std::string m_id;
    std::shared_ptr<Netizen> m_netizen;
};

#endif // NETIZENPROXY_H
