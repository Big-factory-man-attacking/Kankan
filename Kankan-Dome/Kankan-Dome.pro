QT += quick
CONFIG += qmltypes
QML_IMPORT_NAME = mycompany.module
QML_IMPORT_MAJOR_VERSION = 1

LIBS += -lmariadbcpp

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

resources.files = qml/main.qml\
    qml/MainPage.qml\
    qml/HomePage.qml\
    qml/PersonalPage.qml\
    qml/PublishPage.qml\
    qml/TimeDialog.qml\
    qml/MyFriend.qml\
    qml/ManuscriptPage.qml\
    qml/EditManuscript.qml\
    qml/CommentManger.qml\
    qml/SettingPage.qml\
    qml/AccountInformation.qml\
    qml/LoginPage.qml\
    qml/RegisterPage.qml\
    qml/WatchVideo.qml\
    qml/FullScreen.qml\
    qml/QmlBusyIndicator.qml\
    qml/ChangePassword.qml\
    qml/ChangeNickname.qml\
    qml/Dialogs.qml

resources.prefix = /$${TARGET}
RESOURCES += resources \
    image/image.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    qml/AccountInformation.qml \
    qml/ChangeNickname.qml \
    qml/ChangePassword.qml \
    qml/CommentManger.qml \
    qml/Dialogs.qml \
    qml/EditManuscript.qml \
    qml/FullScreen.qml \
    qml/HomePage.qml \
    qml/LoginPage.qml \
    qml/MainPage.qml \
    qml/ManuscriptPage.qml \
    qml/MyFriend.qml \
    qml/PersonalPage.qml \
    qml/PublishPage.qml \
    qml/QmlBusyIndicator.qml \
    qml/RegisterPage.qml \
    qml/SettingPage.qml \
    qml/TimeDialog.qml \
    qml/WatchVideo.qml

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
