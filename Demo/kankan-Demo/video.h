#ifndef VIDEO_H
#define VIDEO_H

#include <string>
#include <vector>
#include "videointerface.h"

class Video : public VideoInterface
{
public:
    Video(std::string id, std::string address);
    ~Video();

    // 获取视频的地址
    std::string getVideoInfo() {return m_address;};

private:
    std::string m_id;           //
    std::string m_address;      //
};

#endif // VIDEO_H
