#ifndef MANUSCRIPTBROKER_H
#define MANUSCRIPTBROKER_H

#include "relationalbroker.h"
#include "manuscript.h"

class ManuscriptBroker : public RelationalBroker
{
public:
    ~ManuscriptBroker();
    static ManuscriptBroker* getInstance();

    std::shared_ptr<Manuscript> getManuscript(const std::string& id);
    //检索缓存以及数据库，返回Manuscript对象
    //id：稿件id

private:
    ManuscriptBroker();
    static ManuscriptBroker* m_manuscriptBroker;
};

#endif // MANUSCRIPTBROKER_H
