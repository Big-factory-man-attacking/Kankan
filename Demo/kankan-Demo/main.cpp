#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <videosocialcontrol.h>
#include <QDebug>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Kankan-Dome/qml/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    //    VideoSocialControl control;
    //    control.login("ce20e992-2530-4d7f-abc0-801879c5d3cb","zhuyoucheng");
    return app.exec();
}
