import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

Item {
    anchors.fill: parent
    property alias bar: bar
    property alias personalPage: personalPage
    property alias homePage: homePage

    TabBar {
        id: bar
        anchors.bottom: parent.bottom
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
                    sourceSize: Qt.size(30, 30)
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
                width: 50
                height: 50
            }
            onClicked: {
                publishPage.visible = true
                mainPage.visible = false
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
                    sourceSize: Qt.size(30, 30)
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
            onClicked: {
                if (personalPage.nickname == "") {
                    personalPage.getNetizenInfo()
                }
            }
        }
    }

    StackLayout {
        width: parent.width
        height: parent.height-bar.height
        currentIndex: bar.currentIndex
        HomePage {
            id: homePage
            width: parent.width
            height: parent.height
        }
        Item {

        }
        PersonalPage {
            id: personalPage
            width: parent.width
            height: parent.height
        }
    }


}
