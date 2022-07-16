import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: main
    width: 400
    height: 1000
    visible: true
    color: "white"
    footer:  TabBar {
        id: bar
        contentWidth: parent.width
        contentHeight: 55
        TabButton {
            height: parent.height
            background: Rectangle{
                color: "white"
                opacity: 0.7
            }

            ColumnLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 1
                Image {
                    id: homeImg
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    id: homeText
                    text: qsTr("首页")
                    Layout.alignment: Qt.AlignHCenter
                    font.pointSize: 8
                }
            }
            states: [
                State {
                    name: "default"
                    when: bar.currentIndex !== 0
                    PropertyChanges {
                        target: homeImg; source: "qrc:home.png"
                    }
                    PropertyChanges {
                        target: homeText; color: "#707070"
                    }
                },
                State {
                    name: "isCurrentIndex"
                    when: bar.currentIndex === 0
                    PropertyChanges {
                        target: homeImg; source: "qrc:home_fill.png"
                    }
                    PropertyChanges {
                        target: homeText; color: "#24c3f5"
                    }
                }
            ]
        }
        TabButton {
            height: parent.height
            background: Rectangle{
                color: "white"
                opacity: 0.7
            }
            Image {
                id: publishImg
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                source: "qrc:add.png"
            }
            onClicked: {
                publishPage.visible = true
                bar.visible = false
            }
        }
        TabButton {
            height: parent.height
            background: Rectangle{
                color: "white"
                opacity: 0.7
            }
            ColumnLayout{
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                spacing: 1
                Image {
                    id: personalImg
                    fillMode: Image.PreserveAspectFit
                }
                Text {
                    id: personalText
                    text: qsTr("我的")
                    Layout.alignment: Qt.AlignHCenter
                    font.pointSize: 8
                }
            }
            states: [
                State {
                    name: "default"
                    when: bar.currentIndex !== 2
                    PropertyChanges {
                        target: personalImg; source: "qrc:my.png"
                    }
                    PropertyChanges {
                        target: personalText; color: "#707070"
                    }
                },
                State {
                    name: "isCurrentIndex"
                    when: bar.currentIndex === 2
                    PropertyChanges {
                        target: personalImg; source: "qrc:my_fill.png"
                    }
                    PropertyChanges {
                        target: personalText; color: "#24c3f5"
                    }
                }
            ]
        }
    }

    StackLayout {
        anchors.fill: parent
        currentIndex: bar.currentIndex
        HomePage{
            id: homePage
            width: parent.width
            height: parent.height
        }
        Item{

        }
        PersonalPage{
            id: personalPage
            width: parent.width
            height: parent.height
        }

    }
    PublishPage{
        id: publishPage
        visible: false
        anchors.fill: parent
    }
}
