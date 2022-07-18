import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
    id: personal
    width: parent.width
    height: parent.height
    RowLayout {
        id: personalMessage
        height: 60
        spacing: 20
        Rectangle {
            id: img
            Layout.preferredHeight: 50
            Layout.preferredWidth: 50
            Layout.leftMargin: 10
            radius: width/2
            border.width: 1
            border.color: "#707070"
            Image {
                id: image
                smooth: true
                visible: false
                anchors.fill: parent
                source: "qrc:head_portrait.png"
                sourceSize: Qt.size(70, 70)
                antialiasing: true
            }
            Rectangle {
                id: mask
                anchors.fill: parent
                radius: width/2
                visible: false
                antialiasing: true
                smooth: true
            }
            OpacityMask {
                id:mask_image
                anchors.fill: image
                source: image
                maskSource: mask
                visible: true
                antialiasing: true
            }
        }
        Text {
            id: nickname
            text: qsTr("text")
            font.pointSize: 16
        }
    }
    ToolBar {
        id: toolBar
        width: parent.width
        height: 60
        anchors.top: personalMessage.bottom
        background: Rectangle {
            color: "white"
        }

        RowLayout {
            width: parent.width
            height: parent.height
            spacing: 0
            ToolButton {
                id: manuscript
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle {
                    color: "white"
                }

                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: manuscriptText
                        text: qsTr("稿件")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: manuscriptNumText
                        text: qsTr("1")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
                onClicked: {
                    bar.visible = false
                    manuscriptPage.visible = true
                }
            }
            ToolSeparator {
                Layout.preferredHeight: toolBar.height-32
                Layout.preferredWidth: 3
                contentItem: Rectangle{
                    anchors.fill: parent
                    color: "#88def9"
                }
            }
            ToolButton {
                id: fanButton
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle {
                    color: "white"
                }
                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: fansText
                        text: qsTr("粉丝")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: fansNumText
                        text: qsTr("2")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
                onClicked: {
                    bar.visible = false
                    myFriend.friendBar.currentIndex = 1
                    myFriend.visible = true
                }
            }
            ToolSeparator {
                Layout.preferredHeight: toolBar.height-32
                Layout.preferredWidth: 3
                contentItem: Rectangle {
                    anchors.fill: parent
                    color: "#88def9"
                }
            }
            ToolButton {
                id: followerButton
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle {
                    color: "white"
                }
                ColumnLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: followerText
                        text: qsTr("关注")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: followerNumText
                        text: qsTr("10")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
                onClicked: {
                    bar.visible = false
                    myFriend.friendBar.currentIndex = 0
                    myFriend.visible = true
                }
            }
        }
    }
    ToolSeparator {
        id: toolS
        height: 2
        width: parent.width
        anchors.top: toolBar.bottom
        contentItem: Rectangle{
            anchors.fill: parent
            color: "#cccccc"
        }
    }
    ScrollView {
        width: parent.width-20
        height: parent.height-personalMessage.height-toolBar.height-2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: toolS.bottom
        clip: true
        ScrollBar.horizontal: ScrollBar{ visible: true }
        ColumnLayout {
            width: personal.width-20
            RowLayout {
                Layout.preferredWidth: parent.width
                Button {
                    Layout.preferredWidth: parent.width/4
                    Layout.preferredHeight: 60
                    background: Rectangle {
                        color: "white"
                    }
                    ColumnLayout {
                        spacing: 5
                        anchors.centerIn: parent
                        Image {
                            source: "qrc:download.png"
                            sourceSize: Qt.size(25, 25)
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("离线缓存")
                        }
                    }
                }
                Button {
                    Layout.preferredWidth: parent.width/4
                    Layout.preferredHeight: 60
                    background: Rectangle {
                        color: "white"
                    }
                    ColumnLayout {
                        spacing: 5
                        anchors.centerIn: parent
                        Image {
                            source: "qrc:history.png"
                            sourceSize: Qt.size(26, 26)
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("历史记录")
                        }
                    }
                }
                Button {
                    Layout.preferredWidth: parent.width/4
                    Layout.preferredHeight: 60
                    background: Rectangle {
                        color: "white"
                    }
                    ColumnLayout {
                        spacing: 5
                        anchors.centerIn: parent
                        Image {
                            source: "qrc:myCollect.png"
                            sourceSize: Qt.size(28, 28)
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("我的收藏")
                        }
                    }
                }
                Button {
                    Layout.preferredWidth: parent.width/4
                    Layout.preferredHeight: 60
                    background: Rectangle {
                        color: "white"
                    }
                    ColumnLayout {
                        spacing: 5
                        anchors.centerIn: parent
                        Image {
                            source: "qrc:watchLater.png"
                            sourceSize: Qt.size(28, 28)
                            Layout.alignment: Qt.AlignHCenter
                        }
                        Text {
                            text: qsTr("稍后再看")
                        }
                    }
                }
            }
        }
    }
    MyFriend {
        id: myFriend
        anchors.fill: parent
        visible: false
    }
    ManuscriptPage {
        id: manuscriptPage
        anchors.fill: parent
        visible: false
    }
}
