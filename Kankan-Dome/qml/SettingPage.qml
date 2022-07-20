import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    anchors.fill: parent
    color: "#f2f2f2"
    ColumnLayout {
        width: parent.width
        spacing: 10
        Rectangle {
            id: titleRec
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 50
            color: "white"
            Button {
                id: to_leftButton
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "qrc:to_left.png"
                icon.width: 35
                icon.height: 30
                background: Rectangle {
                    color: "white"
                }
                onClicked: {
                    mainPage.bar.currentIndex = 2
                    mainPage.visible = true
                    settingPage.visible = false
                }
            }
            Text {
                text: qsTr("设置")
                font.pixelSize: 16
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: to_leftButton.right
                anchors.leftMargin: 15
            }
        }
        Rectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 122
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "帐号资料"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    TapHandler {
                        onTapped: {
                            accountInfor.visible = true
                        }
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "安全隐私"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "播放设置"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
        Rectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 245
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "开屏画面设置"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "离线设置"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "消息设置"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "下载管理"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "清理存储空间"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-10
                    Layout.alignment: Qt.AlignRight
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle{
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: 40
                    Layout.alignment: Qt.AlignHCenter
                    Text {
                        text: "其他设置"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(28, 28)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }

    }
    Button {
        width: parent.width
        height: 40
        anchors.bottom: parent.bottom
        text: qsTr("退出登陆")
        background: Rectangle {
            color: "white"
        }
        onClicked: {
            exitDialog.visible = true
        }
    }
    AccountInformation {
        id: accountInfor
        visible: false
        anchors.fill: parent
    }
    Button {
        id: exitDialog
        anchors.fill: parent
        visible: false
        background: Rectangle {
            color: "black"
            opacity: 0.5
        }
        ColumnLayout {
            anchors.centerIn: parent
            spacing: 0
            Rectangle {
                color: "white"
                Layout.preferredWidth: 240
                Layout.preferredHeight: 70
                ColumnLayout{
                    anchors.centerIn: parent
                    Text {
                        text: qsTr("退出帐号")
                        font.pixelSize: 14
                        font.bold: true
                        Layout.alignment: Qt.AlignHCenter
                    }
                    Text {
                        text: qsTr("确定退出当前帐号")
                        Layout.alignment: Qt.AlignHCenter
                    }
                }
            }
            ToolSeparator {
                Layout.preferredHeight: 1
                Layout.preferredWidth: parent.width
                contentItem: Rectangle{
                    anchors.fill: parent
                    color: "#cccccc"
                }
            }
            Rectangle {
                color: "white"
                Layout.preferredWidth: 240
                Layout.preferredHeight: 31
                Button {
                    id: cancelButton
                    width: parent.width/2
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("取消")
                    background: Rectangle {
                        color: "white"
                    }
                    onClicked: {
                        exitDialog.visible = false
                    }
                }
                Button {
                    width: parent.width/2
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("确认")
                    background: Rectangle {
                        color: "white"
                    }
                    onClicked: {
                        //退出当前帐号，回到帐号登陆注册界面
                        loginPage.visible = true
                        settingPage.visible = false
                    }
                }
            }
        }
    }
}
