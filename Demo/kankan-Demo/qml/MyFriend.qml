import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Rectangle {
    anchors.fill: parent
    color: "white"
    property alias friendBar: myFriendBar
    property var followers: ({})
    property var fans: ({})

    function getFans() {
        fansListModel.clear()
        for (var i = 0; i < fans.length; i++) {
            fansListModel.append({headSource: fans[i]["headPortrait"], nickname: fans[i]["nickname"]})
        }
    }

    function getFollowers() {
        followerListModel.clear()
        for (var i = 0; i < followers.length; i++) {
            followerListModel.append({headSource: followers[i]["headPortrait"], nickname: followers[i]["nickname"]})
        }
    }

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
                    mainPage.bar.currentIndex = 2
                    mainPage.visible =  true
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
                onClicked: {
                    if (followerListModel.count === 0) {
                        getFollowers(mainPage.personalPage.netizen["followers"])
                    }
                }
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
                onClicked: {
                    if (fansListModel.count === 0) {
                        getFollowers(mainPage.personalPage.netizen["followers"])
                    }
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
        StackLayout {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height-title.height-myFriendBar.height-2
            currentIndex: myFriendBar.currentIndex
            Item {
                width: parent.width
                height: parent.height
                ScrollView {
                    anchors.fill: parent
                    clip: true
                    ScrollBar.horizontal: ScrollBar{ visible: true }
                    ListView {
                        id: followerListView
                        anchors.fill: parent
                        boundsBehavior: Flickable.StopAtBounds
                        model: followerListModel
                        delegate: followerDelegate
                    }
                }
                ListModel {
                    id: followerListModel
                }
            }
            Item {
                width: parent.width
                height: parent.height
                ScrollView {
                    anchors.fill: parent
                    clip: true
                    ScrollBar.horizontal: ScrollBar{ visible: true }
                    ListView {
                        id: fansListView
                        anchors.fill: parent
                        boundsBehavior: Flickable.StopAtBounds
                        model: fansListModel
                        delegate: fansDelegate
                    }
                }
                ListModel {
                    id: fansListModel
                }
            }
        }
        Component {
            id: followerDelegate
            Rectangle {
                height: 70
                width: followerListView.width
                Rectangle {
                    id: img
                    height: 40
                    width: 40
                    anchors.leftMargin: 15
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
                        videoSocialControl.takeOff(mainPage.personalPage.netizen["id"], followers[index]["id"])
                        for (var it = 0; it < mainPage.personalPage.netizen["followers"].length; it++) {
                            if (mainPage.personalPage.netizen["followers"][it]["id"] === followers[index]["id"]) {
                                mainPage.personalPage.netizen["followers"].splice(it, 1);
                            }
                        }
                        mainPage.personalPage.getNetizenInfo()
                        followerListModel.remove(index, 1)
                    }
                }
            }
        }
        Component {
            id: fansDelegate
            Rectangle {
                height: 70
                width: fansListView.width
                Rectangle {
                    id: img
                    height: 40
                    width: 40
                    anchors.leftMargin: 15
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
