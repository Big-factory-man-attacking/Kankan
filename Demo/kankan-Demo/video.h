#ifndef VIDEO_H
#define VIDEO_H

#include <string>
#include <vector>
#include "videointerface.h"

class Video : public VideoInterface
{
public:
    Video(std::string id, std::string duration, std::string address);
    ~Video();
    std::string getDuration(){ return m_duration; };
    //返回视频的时长

private:
    std::string m_id;           //
    std::string m_duration = "20ms";     //视频时长
    std::string m_address;      //
};

#endif // VIDEO_H
