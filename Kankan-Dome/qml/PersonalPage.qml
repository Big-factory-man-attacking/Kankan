import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: personal
    width: parent.width
    height: parent.height
    RowLayout{
        id: personalMessage
        height: 70
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
                source: "file:///root/1.png"
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
    ToolBar{
        id: toolBar
        width: parent.width
        height: 60
        anchors.top: personalMessage.bottom
        background: Rectangle{
            color: "white"
        }

        RowLayout{
            width: parent.width
            height: parent.height
            spacing: 0
            ToolButton{
                id: manuscript
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle{
                    color: "white"
                }

                ColumnLayout{
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
            }
            ToolSeparator{
                Layout.preferredHeight: toolBar.height-32
                Layout.preferredWidth: 3
                contentItem: Rectangle{
                    anchors.fill: parent
                    color: "#88def9"
                }
            }
            ToolButton{
                id: fanButton
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle{
                    color: "white"
                }
                ColumnLayout{
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
            }
            ToolSeparator{
                Layout.preferredHeight: toolBar.height-32
                Layout.preferredWidth: 3
                contentItem: Rectangle{
                    anchors.fill: parent
                    color: "#88def9"
                }
            }
            ToolButton{
                id: follwerButton
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: (parent.width-6)/3
                background: Rectangle{
                    color: "white"
                }
                ColumnLayout{
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    Text {
                        id: follwerText
                        text: qsTr("关注")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 12
                        color: "#707070"
                    }
                    Text {
                        id: follwerNumText
                        text: qsTr("10")
                        Layout.alignment: Qt.AlignHCenter
                        font.pointSize: 10
                        color: "#707070"
                    }
                }
            }
        }
    }

}
