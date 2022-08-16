#ifndef VIDEOPROXY_H
#define VIDEOPROXY_H

#include <memory>
#include "videointerface.h"
#include <vector>

class Video;

class VideoProxy : public VideoInterface
{
public:
    VideoProxy(std::string& id);
    ~VideoProxy();

    std::string getVideoInfo(std::string id);
private:
    std::string m_id;
    std::shared_ptr<Video> m_video;
};

#endif // VIDEOPROXY_H
