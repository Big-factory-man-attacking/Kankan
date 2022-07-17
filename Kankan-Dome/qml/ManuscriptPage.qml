import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    color: "white"
    ColumnLayout {
        anchors.fill: parent
        spacing: 8
        RowLayout {
            id: titleRow
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            spacing: 15
            Button {
                id: to_leftButton
                icon.source: "qrc:to_left.png"
                icon.width: 35
                icon.height: 30
                background: Rectangle {
                    color: "white"
                }
                onClicked: {
                    bar.visible = true
                    manuscriptPage.visible = false
                }
            }
            Text {
                text: qsTr("稿件管理")
                font.pixelSize: 16
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
        RowLayout {
            id: searchPart
            Layout.preferredHeight: 50
            Layout.preferredWidth: parent.width
            spacing: 10
            Rectangle {
                Layout.preferredHeight: 35
                Layout.preferredWidth: parent.width-searchButton.width-30
                Layout.leftMargin: 10
                radius: 50
                border.width: 1
                border.color: "#707070"
                RowLayout {
                    width: parent.width-20
                    height: parent.height
                    anchors.centerIn: parent
                    spacing: 10
                    Image {
                        id: searchImg
                        Layout.preferredHeight: 20
                        Layout.preferredWidth: 20
                        fillMode: Image.PreserveAspectFit
                        source: "qrc:search.png"
                    }
                    TextField {
                        id: editText
                        Layout.preferredHeight: parent.height-10
                        Layout.preferredWidth: parent.width-searchImg.width-clearButton.width-20
                        background: Rectangle{
                            color: "white"
                        }
                    }
                    Button {
                        id: clearButton
                        visible: editText.length === 0 ? false : true
                        Layout.preferredHeight: 30
                        Layout.preferredWidth: 30
                        icon.source: "qrc:clear.png"
                        icon.height: 22
                        icon.width: 22
                        background: Rectangle {
                            color: "white"
                        }
                        onClicked: {
                            editText.clear()
                        }
                    }
                }
            }
            Button {
                id: searchButton
                text: qsTr("搜索")
                Layout.rightMargin: 10
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
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height-titleRow.height-searchPart.height-25
            color: "#f2f2f2"
            ListView {
                id: manuscriptListView
                anchors.fill: parent
                spacing: 10
                model: manuscriptListModel
                delegate: manuscriptDelegate
            }
        }
    }
    Component {
        id: manuscriptDelegate
        Rectangle {
            width: manuscriptListView.width
            height: 220
            color: "white"
            ColumnLayout {
                anchors.fill: parent
                spacing: 5
                Rectangle {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 90
                    Image {
                        id: coverImg
                        source: manuscriptCover
                        sourceSize: Qt.size(160, 90)
                        fillMode: Image.PreserveAspectFit
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                    }
                    Button {
                        width: 35
                        height: 18
                        anchors.right: coverImg.right
                        anchors.bottom: coverImg.bottom
                        anchors.rightMargin: 5
                        anchors.bottomMargin: 5
                        Text {
                            text: duration
                            color: "white"
                            anchors.centerIn: parent
                            font.pixelSize: 12
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.5
                            radius: 3
                        }
                    }
                    ColumnLayout {
                        spacing: 30
                        anchors.left: coverImg.right
                        anchors.top: parent.top
                        anchors.leftMargin: 15
                        anchors.topMargin: 10
                        Text {
                            id: headline
                            text: manuscriptTitle
                            font.pixelSize: 16
                        }
                        Text {
                            id: publishTimeText
                            text: publishTime
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
                RowLayout {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 30
                    spacing: 0
                    Rectangle {
                        Layout.preferredWidth: parent.width/4
                        Layout.preferredHeight: 30
                        Button {
                            icon.width: 30
                            icon.height: 30
                            icon.source: "qrc:video.png"
                            text: "234"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            background: Rectangle {
                                color: "white"
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: parent.width/4
                        Layout.preferredHeight: 30
                        Button {
                            icon.width: 30
                            icon.height: 30
                            icon.source: "qrc:comment.png"
                            text: "1234"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            background: Rectangle {
                                color: "white"
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: parent.width/4
                        Layout.preferredHeight: 30
                        Button {
                            icon.width: 30
                            icon.height: 30
                            icon.source: "qrc:like.png"
                            text: "34"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            background: Rectangle {
                                color: "white"
                            }
                        }
                    }
                    Rectangle {
                        Layout.preferredWidth: parent.width/4
                        Layout.preferredHeight: 30
                        Button {
                            icon.width: 30
                            icon.height: 30
                            icon.source: "qrc:collection.png"
                            text: "2"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            background: Rectangle {
                                color: "white"
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
                RowLayout {
                    spacing: 15
                    Layout.alignment: Qt.AlignRight
                    Layout.rightMargin: 15
                    RoundButton {
                        Layout.preferredWidth: 55
                        text: qsTr("分享")
                        radius: 5
                    }
                    RoundButton {
                        Layout.preferredWidth: 55
                        text: qsTr("编辑")
                        radius: 5
                        onClicked: {
                            //先将所有的数据读到发布界面，然后显示发布见面
                            editManuscript.visible = true

                        }
                    }
                    RoundButton {
                        Layout.preferredWidth: 55
                        text: qsTr("互动")
                        radius: 5
                    }
                    RoundButton {
                        Layout.preferredWidth: 55
                        text: qsTr("删除")
                        radius: 5
                        onClicked: {
                            manuscriptListModel.remove(manuscriptListView.currentIndex, 1)
                            //该稿件也要删除

                        }
                    }
                }
            }
        }
    }
    ListModel {
        id: manuscriptListModel
        ListElement {
            manuscriptCover: "file:///root/cover.png"
            manuscriptTitle: "歌乐山"
            publishTime: "2022.07.17 9:54"
            duration: "1:30"
        }
        ListElement {
            manuscriptCover: "file:///root/cover.png"
            manuscriptTitle: "歌乐山"
            publishTime: "2022.07.17 9:54"
            duration: "0:30"
        }
    }
    EditManuscript {
        id: editManuscript
        visible: false
        anchors.fill: parent
    }
}
