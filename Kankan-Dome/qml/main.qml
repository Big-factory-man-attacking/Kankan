import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: main
    width: 400
    height: 700
    visible: true
    color: "white"
    LoginPage {
        id: loginPage
        anchors.fill: parent
        visible: true
    }
    RegisterPage {
        id: registerPage
        anchors.fill: parent
        visible: false
    }

    MainPage {
        id: mainPage
        anchors.fill: parent
        visible: false
    }
    PublishPage {
        id: publishPage
        visible: false
        anchors.fill: parent
    }
    SettingPage {
        id: settingPage
        visible: false
        anchors.fill: parent
    }
}
