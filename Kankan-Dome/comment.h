#ifndef COMMENT_H
#define COMMENT_H

#include <string>
#include "commentinterface.h"

class Comment : public CommentInterface
{
public:
    Comment(std::string id, std::string text);
    ~Comment();

    std::string getText(){ return m_text; };
private:
    std::string m_id;       //评论id,利用时间生成
    //与网民进行关联，加载稿件
    std::string m_text;     //评论正文
};

#endif // COMMENT_H
