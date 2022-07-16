import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    anchors.fill: parent
    color: "white"
    property alias friendBar: myFriendBar

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            id: title
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            color: "white"
            Button {
                width: 45
                height: 40
                icon.source: "qrc:to_left.png"
                icon.width: 45
                icon.height: 40
                background: Rectangle {
                    color: "white"
                }
                onClicked: {
                    bar.visible = true
                    myFriend.visible = false
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
        TabBar {
            id: myFriendBar
            contentWidth: parent.width
            contentHeight: 40
            TabButton {
                id: followerTab
                height: parent.height
                background: Rectangle {
                    color: "white"
                }

                Text {
                    id: followerText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    text: qsTr("我的关注")
                }
                states: [
                    State {
                        name: "default"
                        when: myFriendBar.currentIndex !== 0
                        PropertyChanges {
                            target: followerText; color: "#707070"
                        }
                    },
                    State {
                        name: "isCurrentIndex"
                        when: myFriendBar.currentIndex === 0
                        PropertyChanges {
                            target: followerText; color: "#24c3f5"
                        }
                    }
                ]
            }
            TabButton {
                height: parent.height
                background: Rectangle {
                    color: "white"
                }
                Text {
                    id: fansText
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    text: qsTr("我的粉丝")
                }
                states: [
                    State {
                        name: "default"
                        when: myFriendBar.currentIndex !== 1
                        PropertyChanges {
                            target: fansText; color: "#707070"
                        }
                    },
                    State {
                        name: "isCurrentIndex"
                        when: myFriendBar.currentIndex === 1
                        PropertyChanges {
                            target: fansText; color: "#24c3f5"
                        }
                    }
                ]
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
        StackLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height-title.height-myFriendBar.height-2
            currentIndex: myFriendBar.currentIndex
            Item {
                width: parent.width
                height: parent.height
                ListView {
                    id: followerListView
                    anchors.fill: parent
                    model: followerListModel
                    delegate: followerDelegate
                }
                ListModel {
                    id: followerListModel
                    ListElement {
                        headSource: "qrc:head_portrait.png"
                        nickname: "巴拉巴拉能亮"
                    }
                    ListElement {
                        headSource: "qrc:head_portrait.png"
                        nickname: "。。。"
                    }
                }
            }
            Item {
                width: parent.width
                height: parent.height
                ListView {
                    id: fansListView
                    anchors.fill: parent
                    model: fansListModel
                    delegate: fansDelegate
                }
                ListModel {
                    id: fansListModel
                    ListElement {
                        headSource: "qrc:head_portrait.png"
                        nickname: "吃瓜的快乐"
                    }
                    ListElement {
                        headSource: "qrc:head_portrait.png"
                        nickname: "awsl"
                    }
                }
            }
        }
        Component {
            id: followerDelegate
            Rectangle {
                id: personalMessage
                height: 70
                width: followerListView.width
                Rectangle {
                    id: img
                    height: 40
                    width: 40
                    anchors.leftMargin: 10
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width/2
                    border.width: 1
                    border.color: "#707070"
                    Image {
                        id: image
                        smooth: true
                        visible: false
                        anchors.fill: parent
                        source: headSource
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
                    id: nicknameT
                    text: nickname
                    font.pointSize: 14
                    anchors.left: img.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
                Button {
                    icon.source: "qrc:unfollow.png"
                    icon.width: 25
                    icon.height: 25
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    background: Rectangle {
                        color: "white"
                    }

                    onClicked: {
                        followerListModel.remove(followerListView.currentIndex, 1)
                    }
                }
            }
        }
        Component {
            id: fansDelegate
            Rectangle {
                id: personalMessage
                height: 70
                width: followerListView.width
                Rectangle {
                    id: img
                    height: 40
                    width: 40
                    anchors.leftMargin: 10
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    radius: width/2
                    border.width: 1
                    border.color: "#707070"
                    Image {
                        id: image
                        smooth: true
                        visible: false
                        anchors.fill: parent
                        source: headSource
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
                    id: nicknameT
                    text: nickname
                    font.pointSize: 14
                    anchors.left: img.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
