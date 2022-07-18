#ifndef NETIZENPROXY_H
#define NETIZENPROXY_H

#include <memory>
#include "netizeninterface.h"
#include <vector>

class Netizen;

class NetizenProxy : public NetizenInterface
{
public:
    NetizenProxy(std::string id);
    ~NetizenProxy();

    std::vector<std::string> getInfo(std::string id);
private:
    std::string m_id;
    std::shared_ptr<Netizen> m_netizen;
};

#endif // NETIZENPROXY_H
