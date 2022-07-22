import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

Rectangle {
    anchors.fill: parent
    property alias video: video
    Rectangle {
        anchors.fill: parent
        color: "black"
        Video{
            id: video
            anchors.fill: parent
            focus: true
            orientation: 90
            fillMode: VideoOutput.PreserveAspectFit
            onSourceChanged: {
                playBut.clicked()
                vieoTimer.running = true
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    topBar.visible = true
                    bottomBar.visible = true
                    barTimer.running = true
                }
            }


            Keys.onSpacePressed: video.playbackState === MediaPlayer.PlayingState ?
                                     video.pause() : video.play()
//            Keys.onLeftPressed: video.seek(video.position - 5000)
//            Keys.onRightPressed: video.seek(video.position + 5000)
            Timer {
                id: vieoTimer
                interval: 500
                running: false
                repeat: false
                onTriggered: {
                    totalTime = setTime(video.duration)
                }
            }
        }
        RowLayout {
            id: topBar
            visible: false
            height: parent.height-20
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            Button {
                icon.source: "qrc:to_left_white.png"
                icon.width: 20
                icon.height: 20
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                background: Rectangle {
                    opacity: 0
                }
                onClicked: {
                    watchVideo.visible = false
                }
            }
            Button {
                icon.source: "qrc:more.png"
                icon.width: 25
                icon.height: 25
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                background: Rectangle {
                    opacity: 0
                }
            }
        }
        RowLayout {
            id: bottomBar
            visible: false
            height: parent.height-20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            spacing: 3
            Button {
                id: playBut
                icon.source: "qrc:play.png"
                icon.width: 30
                icon.height: 30
                rotation: 90
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                background: Rectangle {
                    opacity: 0
                }
                onClicked: {
                    video.play()
                    playBut.visible = false
                    pauseBut.visible = true
                }
            }
            Button {
                id: pauseBut
                visible: false
                icon.source: "qrc:stop.png"
                icon.width: 30
                icon.height: 30
                rotation: 90
                Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
                background: Rectangle {
                    opacity: 0
                }
                onClicked: {
                    video.pause()
                    playBut.visible = true
                    pauseBut.visible = false
                }
            }
            Slider{
                id:audioSlider
                to:video.duration
                value: video.position
                Layout.preferredHeight: parent.height-playBut.height-playbackTime.height-fullScreenBut.width-9
                snapMode: Slider.SnapOnRelease
                onValueChanged: {
                    currentTime=setTime(value)
                }
                onMoved: {
                    video.seek(value)
                }
            }
            Text {
                id: playbackTime
                text:currentTime+"/"+totalTime
                color: "white"
                font.pixelSize: 10
            }
            Button {
                id: fullScreenBut
                icon.source: "qrc:full_screen.png"
                icon.width: 28
                icon.height: 28
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                background: Rectangle {
                    opacity: 0
                }
                onClicked: {
                    video.orientation = 90
                }
            }
            Timer {
                id: barTimer
                interval: 5000
                running: false
                repeat: false
                onTriggered: {
                    topBar.visible = false
                    bottomBar.visible = false
                }
            }
        }
    }
}
