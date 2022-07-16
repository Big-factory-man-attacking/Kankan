import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtMultimedia
import Qt5Compat.GraphicalEffects

Item {
    id: home
    width: parent.width
    height: parent.height
    RowLayout{
        id: header
        height: 50
        width: parent.width
        spacing: 10
        Rectangle{
            id: headPortrait
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
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
        Rectangle{
            id: rectangle
            Layout.preferredHeight: 35
            Layout.preferredWidth: parent.width-headPortrait.width-messageImg.width-40
            radius: 50
            border.width: 1
            border.color: "#707070"
            RowLayout{
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
                TextField{
                    id: editText
                    Layout.preferredHeight: parent.height-10
                    Layout.preferredWidth: parent.width-searchImg.width-clearButton.width-20
                    background: Rectangle{
                        color: "white"
                    }
                }
                Button{
                    id: clearButton
                    visible: editText.length === 0 ? false : true
                    Layout.preferredHeight: 30
                    Layout.preferredWidth: 30
                    icon.source: "qrc:clear.png"
                    icon.height: 22
                    icon.width: 22
                    background: Rectangle{
                        color: "white"
                    }
                    onClicked: {
                        editText.clear()
                    }
                }
            }
        }
        Image{
            id: messageImg
            Layout.preferredHeight: 40
            Layout.preferredWidth: 40
            fillMode: Image.PreserveAspectFit
            source: "qrc:message.png"
            Layout.rightMargin: 10
        }
    }
    Rectangle{
        height: parent.height-header.height
        width: parent.width
        color: "#f2f2f2"
        anchors.top: header.bottom
        ColumnLayout{
            width: parent.width
            height: parent.height
            Video{
                id: video
                Layout.preferredHeight: width/16*9
                Layout.preferredWidth: parent.width-10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                source: "file:///root/mv.mkv"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        video.play()
                    }
                }

                focus: true
                Keys.onSpacePressed: video.playbackState === MediaPlayer.PlayingState ?
                                         video.pause() : video.play()
                Keys.onLeftPressed: video.seek(video.position - 5000)
                Keys.onRightPressed: video.seek(video.position + 5000)
            }
            GridView{
                Layout.preferredWidth: parent.width-10
                Layout.preferredHeight: parent.height-video.height
                model: videoModel
                delegate: contactDelegate

            }
            ListModel{
                id: videoModel
            }
            Component{
                id: contactDelegate
                Item{

                }
            }
        }
    }
}
