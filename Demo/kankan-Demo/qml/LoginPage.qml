import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    color: "white"
    property int count: 0

    ColumnLayout {
        id: accountColumn
        width: parent.width/3*2
        anchors.centerIn: parent
        spacing: 20
        Text {
            text: qsTr("Kankan")
            font.family: "Courier"
            font.pixelSize: 18
        }
        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: parent.width
            radius: 50
            border.width: 1
            border.color: "#707070"
            RowLayout {
                width: parent.width-30
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6
                Text {
                    id: accountText
                    text: qsTr("账 号:")
                    font.pixelSize: 16
                }
                TextField {
                    id: accountEditText
                    Layout.preferredHeight: parent.height-10
                    Layout.preferredWidth: parent.width-accountText.width-accountBut.width-12
                    background: Rectangle{
                        color: "white"
                    }
                }
                Button {
                    id: accountBut
                    visible: accountEditText.length === 0 ? false : true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    icon.source: "qrc:clear.png"
                    icon.height: 22
                    icon.width: 22
                    background: Rectangle {
                        color: "white"
                    }
                    onClicked: {
                        accountEditText.clear()
                    }
                }
            }
        }
        Rectangle {
            Layout.preferredHeight: 40
            Layout.preferredWidth: parent.width
            radius: 50
            border.width: 1
            border.color: "#707070"
            RowLayout {
                width: parent.width-30
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 6
                Text {
                    id: passwordText
                    text: qsTr("密 码:")
                    font.pixelSize: 16
                }
                TextField {
                    id: passwordEditText
                    Layout.preferredHeight: parent.height-10
                    Layout.preferredWidth: parent.width-passwordText.width-passwordBut.width-12

                    background: Rectangle{
                        color: "white"
                    }
                    echoMode: TextInput.Password
                }
                Button {
                    id: passwordBut
                    visible: passwordEditText.length === 0 ? false : true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    background: Rectangle {
                        color: "white"
                    }
                    Button {
                        id: passwordButHit
                        anchors.fill: parent
                        visible: true
                        icon.source: "qrc:eye_hide.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            passwordButHit.visible = false
                            passwordButVis.visible = true
                            passwordEditText.echoMode = TextInput.Normal
                        }
                    }
                    Button {
                        id: passwordButVis
                        visible: false
                        anchors.fill: parent
                        icon.source: "qrc:eye_visible.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            passwordButVis.visible = false
                            passwordButHit.visible = true
                            passwordEditText.echoMode = TextInput.Password
                        }
                    }
                }
            }
        }
        RoundButton {
            id: roundBut
            Layout.preferredWidth: parent.width/6
            Layout.preferredHeight: parent.width/6
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 30
            radius: width/2
            icon.source: "qrc:to_right.png"
            icon.width: 30
            icon.height: 30
            background: Rectangle {
                radius: width/2
                rotation: 0
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#66ffff" }
                    GradientStop { position: 1.0; color: "blue" }
                }
            }
            onClicked: {
                //调用login()登陆函数
                mainPage.personalPage.netizen = videoSocialControl.login(accountEditText.text, passwordEditText.text)
                if (JSON.stringify(mainPage.personalPage.netizen) === "{}") {
                    errorText.visible = true
                    passwordTimer.running = true
                } else {
                    mainPage.homePage.manuscripts = videoSocialControl.getSomeVideos()
                    mainPage.personalPage.headPortrait = mainPage.personalPage.netizen["headportrait"]
                    mainPage.homePage.getVideoInfo()
                    mainPage.visible = true
                    loginPage.visible = false
                }
            }
        }
    }

    RowLayout {
        height: 50
        width: parent.width
        anchors.bottom: parent.bottom
        spacing: 10
        Text {
            Layout.preferredWidth: (parent.width-22)/2
            text: qsTr("新用户注册")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignRight
            Layout.alignment: Qt.AlignVCenter
            TapHandler {
                onTapped: {
                    loginPage.visible = false
                    registerPage.visible = true
                }
            }
        }
        ToolSeparator {
            Layout.preferredHeight: 15
            Layout.preferredWidth: 2
            Layout.alignment: Qt.AlignVCenter
            contentItem: Rectangle{
                anchors.fill: parent
                color: "#cccccc"
            }
        }
        Text {
            Layout.preferredWidth: (parent.width-22)/2
            text: qsTr("找回密码")
            font.pixelSize: 14
            horizontalAlignment: Text.AlignLeft
            Layout.alignment: Qt.AlignVCenter
        }
    }
    Timer {
        id: timer
        interval: 35
        running: loginPage.visible
        repeat: true
        onTriggered: {
            count++
            roundBut.background.rotation = count%360
        }
    }
    Text {
        id: errorText
        visible: false
        text: qsTr("帐号与密码不匹配！")
        color: "red"
        font.pixelSize: 16
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height/2+30
    }
    Timer {
        id: passwordTimer
        interval: 2000
        running: false
        repeat: false
        onTriggered: {
            errorText.visible = false
        }
    }  
}
