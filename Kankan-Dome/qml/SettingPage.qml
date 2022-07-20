import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    anchors.fill: parent
    color: "#f2f2f2"
    ColumnLayout {
        anchors.fill: parent
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
                    bar.visible = true
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
                        sourceSize: Qt.size(30, 30)
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
                        text: "安全隐私"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(30, 30)
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
                        sourceSize: Qt.size(30, 30)
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
                        text: "帐号资料"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(30, 30)
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
                        text: "安全隐私"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(30, 30)
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
                        sourceSize: Qt.size(30, 30)
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
                        text: "安全隐私"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(30, 30)
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
                        text: "安全隐私"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(30, 30)
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
                        text: "安全隐私"
                        font.pixelSize: 14
                        anchors.left: parent.left
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    Image {
                        source: "qrc:right.png"
                        sourceSize: Qt.size(30, 30)
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }
}
