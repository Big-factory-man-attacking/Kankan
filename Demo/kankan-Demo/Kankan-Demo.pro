TEMPLATE = app
CONFIG += console c++17
CONFIG -= app_bundle
CONFIG -= qt

LIBS += -lmariadbcpp

 QT += core

SOURCES += \
        cache.cpp \
        comment.cpp \
        commentbroker.cpp \
        commentproxy.cpp \
        main.cpp \
        manuscript.cpp \
        manuscriptbroker.cpp \
        manuscriptproxy.cpp \
        netizen.cpp \
        netizenbroker.cpp \
        netizenproxy.cpp \
        relationalbroker.cpp \
        video.cpp \
        videobroker.cpp \
        videoproxy.cpp \
        videosocialcontrol.cpp

HEADERS += \
    cache.h \
    comment.h \
    commentbroker.h \
    commentinterface.h \
    commentproxy.h \
    manuscript.h \
    manuscriptbroker.h \
    manuscriptinterface.h \
    manuscriptproxy.h \
    netizen.h \
    netizenbroker.h \
    netizeninterface.h \
    netizenproxy.h \
    relationalbroker.h \
    video.h \
    videobroker.h \
    videointerface.h \
    videoproxy.h \
    videosocialcontrol.h
