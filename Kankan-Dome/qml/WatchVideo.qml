import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

Rectangle {
    anchors.fill: parent
    color: "white"
    property string totalTime:"00:00:00";
    property string currentTime:"00:00:00";
    property alias video: video

    function getVideoInfo() {

    }

    //时间转化   "00:00:00"
    function setTime(playTime) {
        var h, m, s
        var time
        playTime = (playTime-playTime%1000)/1000
        h = (playTime-playTime%3600)/3600
        m = (playTime-h*3600-playTime%60)/60
        s = playTime-m*60
        if (h >= 0 & h < 10) {
            time = "0" + h + ":"
        } else {
            time = h + ":"
        }
        if (m >= 0 & m < 10) {
            time += "0" + m + ":"
        } else {
            time += m + ":"
        }
        if (s >= 0 & s < 10) {
            time += "0" + s
        } else {
            time += s
        }
        return time
    }

    Rectangle {
        id: videoRec
        height: width/16*9
        width: parent.width
        color: "black"
        Video{
            id: video
            anchors.fill: parent
            focus: true
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
//            Keys.onSpacePressed: video.playbackState === MediaPlayer.PlayingState ?
//                                     video.pause() : video.play()
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
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 5
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
            width: parent.width-20
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            spacing: 3
            Button {
                id: playBut
                icon.source: "qrc:play.png"
                icon.width: 30
                icon.height: 30
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
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
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
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
                Layout.preferredWidth: parent.width-playBut.width-playbackTime.width-fullScreenBut.width-9
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
                    fullScreen.video.source = video.source
                    fullScreen.visible = true
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
    TabBar {
        id: tabBar
        anchors.top: videoRec.bottom
        contentWidth: parent.width
        contentHeight: 40
        TabButton {
            height: parent.height
            background: Rectangle {
                color: "white"
            }
            ColumnLayout {
                anchors.fill: parent
                spacing: 0
                Text {
                    id: abstractText
                    text: qsTr("简介")
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
                Rectangle {
                    id: abstractRec
                    Layout.preferredWidth: parent.width/2
                    Layout.preferredHeight: 3
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                }
            }
            states: [
                State {
                    name: "default"
                    when: tabBar.currentIndex !== 0
                    PropertyChanges {
                        target: abstractText; color: "#cccccc"
                    }
                    PropertyChanges {
                        target: abstractRec; color: "white"
                    }
                },
                State {
                    name: "isCurrentIndex"
                    when: tabBar.currentIndex === 0
                    PropertyChanges {
                        target: abstractText; color: "#24c3f5"
                    }
                    PropertyChanges {
                        target: abstractRec; color: "#24c3f5"
                    }
                }
            ]
        }
        TabButton {
            height: parent.height
            background: Rectangle {
                color: "white"
            }
            ColumnLayout {
                anchors.fill: parent
                Text {
                    id: commentText
                    text: qsTr("评论")
                    font.pixelSize: 16
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
                Rectangle {
                    id: commentRec
                    Layout.preferredWidth: parent.width/2
                    Layout.preferredHeight: 3
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                }
            }
            states: [
                State {
                    name: "default"
                    when: tabBar.currentIndex !== 1
                    PropertyChanges {
                        target: commentText; color: "#cccccc"
                    }
                    PropertyChanges {
                        target: commentRec; color: "white"
                    }
                },
                State {
                    name: "isCurrentIndex"
                    when: tabBar.currentIndex === 1
                    PropertyChanges {
                        target: commentText; color: "#24c3f5"
                    }
                    PropertyChanges {
                        target: commentRec; color: "#24c3f5"
                    }
                }
            ]
        }
    }
    ToolSeparator {
        id: toolS
        height: 1
        width: parent.width
        anchors.top: tabBar.bottom
        contentItem: Rectangle{
            anchors.fill: parent
            color: "#cccccc"
        }
    }
    StackLayout {
        width: parent.width
        height: parent.height-videoRec.height-tabBar.height-1
        anchors.top: toolS.bottom
        currentIndex: tabBar.currentIndex
        Item {
            id: abstractItem
            width: parent.width
            height: parent.height
            ScrollView {
                anchors.fill: parent
                ColumnLayout {
                    width: abstractItem.width
                    Rectangle {
                        Layout.preferredWidth: parent.width-30
                        Layout.preferredHeight: 40
                        Layout.topMargin: 8
                        Layout.alignment: Qt.AlignHCenter
                        Rectangle {
                            id: headPortrait
                            height: 40
                            width: 40
                            radius: width/2
                            border.width: 1
                            border.color: "#707070"
                            Image {
                                id: image
                                smooth: true
                                visible: false
                                anchors.fill: parent
                                source: "qrc:head_portrait.png"
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
                            text: "nickname"
                            font.pixelSize: 16
                            anchors.left: headPortrait.right
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }
                        Button {
                            width: 70
                            height: 30
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            background: Rectangle {
                                color: "#24c3f5"
                            }
                            Row {
                                spacing: 2
                                anchors.centerIn: parent
                                Image {
                                    source: "qrc:add_white.png"
                                    sourceSize: Qt.size(18, 18)
                                }
                                Text {
                                    text: qsTr("关注")
                                    color: "white"
                                    font.pixelSize: 14
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
                }
            }
        }
        Item {
            id: commentItem
            width: parent.width
            height: parent.height
            Column {
                spacing: 0
                anchors.fill: parent
                ScrollView {
                    id: scrollView
                    width: parent.width
                    height: parent.height-publishComment.height-1
                    clip: true
                    ListView {
                        id: commentView
                        anchors.fill: parent
                        model: commentModel
                        delegate: commentDelegate
                        boundsBehavior: Flickable.StopAtBounds
                    }
                }
                ToolSeparator {
                    id: toolS_2
                    height: 1
                    width: parent.width
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                RowLayout {
                    id: publishComment
                    width: parent.width-30
                    height: 40
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    Rectangle {
                        id: rec
                        Layout.preferredWidth: parent.width-publishBut.width-12
                        Layout.preferredHeight: 30
                        Layout.alignment: Qt.AlignVCenter
                        radius: 20
                        border.width: 1
                        border.color: "#707070"
                        TextField {
                            id: editText
                            width: parent.width-30
                            height: 28
                            anchors.centerIn: parent
                            background: Rectangle{
                                color: "white"
                            }
                        }
                    }
                    Button {
                        id: publishBut
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignVCenter
                        background: Rectangle {
                            color: "white"
                        }
                        Text {
                            text: qsTr("发布")
                            anchors.centerIn: parent
                        }
                        onClicked: {
                            //为当前稿件添加一条评论
                        }
                    }
                }
            }


        }
    }
    Component {
        id: commentDelegate
        ColumnLayout {
            width: commentView.width
            spacing: 10
            Row {
                width: parent.width-20
                spacing: 10
                Layout.topMargin: 8
                Layout.alignment: Qt.AlignHCenter
                Rectangle {
                    id: headPortrait
                    height: 40
                    width: 40
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
                ColumnLayout {
                    spacing: 5
                    width: parent.width-headPortrait.width-10
                    Layout.alignment: Qt.AlignVCenter
                    Text {
                        text: nickname
                        color: "grey"
                        font.pixelSize: 14
                    }
                    Text {
                        text: Qt.formatDateTime(commentDate, "yyyy-MM-dd hh:mm")
                        color: "grey"
                        font.pixelSize: 12
                    }
                    Text {
                        Layout.preferredWidth: parent.width-10
                        Layout.topMargin: 5
                        text: comment
                        font.pixelSize: 16
                        wrapMode: Text.WrapAnywhere
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
        }
    }
    ListModel {
        id: commentModel
        Component.onCompleted: {
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "哈哈哈哈哈", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "而望各位高人给我那天回退人生观和他和她和回退恨不得否认我而给他人u一个i很快糊弄客户个", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "哈哈哈哈哈", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "而望各位高人给我那天回退人生观和他和她和回退恨不得否认我而给他人u一个i很快糊弄客户个", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "哈哈哈哈哈", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "而望各位高人给我那天回退人生观和他和她和回退恨不得否认我而给他人u一个i很快糊弄客户个", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "哈哈哈哈哈", commentDate: new Date()});
            commentModel.append({headSource: "qrc:head_portrait.png", nickname: "吃瓜的快乐", comment: "而望各位高人给我那天回退人生观和他和她和回退恨不得否认我而给他人u一个i很快糊弄客户个", commentDate: new Date()});
        }
    }


    FullScreen {
        id: fullScreen
        visible: false
        anchors.fill: parent
    }

}
