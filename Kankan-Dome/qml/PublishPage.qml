import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtMultimedia
import Qt5Compat.GraphicalEffects

Item {
    id: publishPage
    width: 400
    height: 1000
    ColumnLayout{
        anchors.fill: parent
        spacing: 0
        Rectangle{
            id: title
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 40
            color: "white"
            Button{
                width: 45
                height: 40
                icon.source: "qrc:to_left.png"
                icon.width: 45
                icon.height: 40
                background: Rectangle{
                    color: "white"
                }
                onClicked: {
                    bar.visible = true
                    bar.currentIndex = 0
                    publishPage.visible = false
                }
            }
        }
        ScrollView {
            Layout.preferredHeight: parent.height-title.height-publishRec.height
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter
            clip: true
            ScrollBar.horizontal: ScrollBar{ visible: true }

            Rectangle{
                id: manuscriptContext
                width: parent.width
                height: parent.height
                color: "#f2f2f2"
                ColumnLayout{
                    anchors.top: parent.top
                    anchors.topMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: parent.width-20
                    spacing: 10
                    Rectangle{
                        id: videoPart
                        Layout.preferredHeight: width/16*9
                        Layout.preferredWidth: parent.width
                        Button{
                            anchors.fill: parent
                            text: qsTr("点击选择视频")
                        }

                        Image{
                            id: videoCover
                            visible: false
                            anchors.fill: parent
                            source: "qrc:cover.png"
                        }
                        Video{
                            id: video
                            visible: false
                            anchors.fill: parent
                            source: "file:///root/mv.mkv"
                            fillMode: VideoOutput.PreserveAspectFit
                            focus: true
                            Keys.onSpacePressed: video.playbackState === MediaPlayer.PlayingState ?
                                                     video.pause() : video.play()
                            Keys.onLeftPressed: video.seek(video.position - 5000)
                            Keys.onRightPressed: video.seek(video.position + 5000)
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    video.play()
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: titlePart
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 100
                        radius: 10
                        ColumnLayout{
                            anchors.fill: parent
                            spacing: 1
                            ScrollView {
                                id: textAreaView
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 76
                                Layout.alignment: Qt.AlignHCenter
                                clip: true
                                ScrollBar.horizontal: ScrollBar{ visible: true }
                                TextArea{
                                    id: titleText
                                    width: textAreaView.width-30
                                    height: 76
                                    placeholderText: qsTr("请输入标题（必填）")
                                    wrapMode: TextEdit.Wrap
                                    font.pointSize: 12
                                }
                            }
                            RowLayout{
                                spacing: 1
                                Layout.rightMargin: 20
                                Layout.alignment: Qt.AlignRight
                                Text{
                                    Layout.preferredWidth: 30
                                    text: titleText.length
                                    color: titleText.length > 80 ? "red" : "black"
                                    horizontalAlignment: Text.AlignRight
                                }
                                Text{
                                    text: qsTr("/80")
                                }

                            }
                        }
                    }
                    Rectangle{
                        id: partitionPart
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 110
                        radius: 10
                        ColumnLayout{
                            anchors.fill: parent
                            anchors.margins: 15
                            spacing:10
                            RowLayout{
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 20
                                spacing: 0
                                Label{
                                    text: qsTr("分区：")
                                }
                                ComboBox {
                                    Layout.preferredHeight: 30
                                    Layout.preferredWidth: 120
                                    editable: true
                                    model: ListModel {
                                        id: model
                                        ListElement { text: "生活" }
                                        ListElement { text: "美食" }
                                        ListElement { text: "游戏" }
                                        ListElement { text: "音乐" }
                                        ListElement { text: "时尚" }
                                        ListElement { text: "知识" }
                                        ListElement { text: "影视" }
                                        ListElement { text: "动画" }
                                        ListElement { text: "舞蹈" }
                                    }
                                    onAccepted: {
                                        if (find(editText) === -1)
                                            model.append({text: editText})
                                    }
                                }
                                Label{
                                    text: qsTr("标签：")
                                }
                                TextField{
                                    Layout.preferredWidth: 120
                                }
                            }
                            ToolSeparator{
                                Layout.preferredHeight: 1
                                Layout.preferredWidth: parent.width-30
                                Layout.alignment: Qt.AlignHCenter
                                contentItem: Rectangle{
                                    anchors.fill: parent
                                    color: "#cccccc"
                                }
                            }
                            Rectangle{
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 20
                                Text{
                                    text: qsTr("类型（必填）")
                                    anchors.left: parent.left
                                }
                                RowLayout{
                                    anchors.right: parent.right
                                    width: 130
                                    spacing: 10
                                    Rectangle{
                                        width: 100
                                        Layout.preferredHeight: 20
                                        Layout.preferredWidth: 60
                                        RadioButton{
                                            id: self_restraintButton
                                            width: 20
                                            height: 20
                                            onCheckedChanged: {
                                                if (checked === true) {
                                                    checkable = false
                                                    self_restraintText.color = "#88def9"
                                                    reprintText.color = "black"
                                                    reprintButton.checkable = true
                                                    reprintButton.checked = false
                                                }
                                            }
                                        }
                                        Text{
                                            id: self_restraintText
                                            text: qsTr("自制")
                                            anchors.left: self_restraintButton.right
                                            anchors.leftMargin: 5
                                        }
                                    }
                                    Rectangle{
                                        id: reprintRec
                                        Layout.preferredHeight: 20
                                        Layout.preferredWidth: 60
                                        RadioButton{
                                            id: reprintButton
                                            width: 20
                                            height: 20
                                            onCheckedChanged: {
                                                if (checked === true) {
                                                    checkable = false
                                                    reprintText.color = "#88def9"
                                                    self_restraintText.color = "black"
                                                    self_restraintButton.checkable = true
                                                    self_restraintButton.checked = false
                                                }
                                            }
                                        }
                                        Text{
                                            id: reprintText
                                            text: qsTr("转载")
                                            anchors.left: reprintButton.right
                                            anchors.leftMargin: 5
                                        }
                                    }
                                }
                            }
                        }
                    }
                    Rectangle{
                        id: inforPart
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: 300
                        radius: 10
                        ColumnLayout{
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 10
                            Text {
                                id: inforText
                                text: qsTr("简介")
                            }
                            Rectangle{
                                id: inforFrame
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 100
                                radius: 10
                                color: "#f2f2f2"
                                ColumnLayout{
                                    anchors.fill: parent
                                    spacing: 1
                                    ScrollView {
                                        id: inforTextAreaView
                                        Layout.preferredWidth: parent.width
                                        Layout.preferredHeight: 76
                                        Layout.alignment: Qt.AlignHCenter
                                        clip: true
                                        ScrollBar.horizontal: ScrollBar{ visible: true }
                                        TextArea{
                                            id: inforTextA
                                            width: textAreaView.width-30
                                            height: 76
                                            placeholderText: qsTr("可填写简介")
                                            wrapMode: TextEdit.Wrap
                                            font.pointSize: 12
                                        }
                                    }
                                    RowLayout{
                                        spacing: 1
                                        Layout.rightMargin: 20
                                        Layout.alignment: Qt.AlignRight
                                        Text{
                                            Layout.preferredWidth: 30
                                            text: titleText.length
                                            color: titleText.length > 80 ? "red" : "black"
                                            horizontalAlignment: Text.AlignRight
                                        }
                                        Text{
                                            text: qsTr("/80")
                                        }
                                    }
                                }
                            }
                            ToolSeparator{
                                Layout.preferredHeight: 1
                                Layout.preferredWidth: parent.width-30
                                Layout.alignment: Qt.AlignHCenter
                                contentItem: Rectangle{
                                    anchors.fill: parent
                                    color: "#cccccc"
                                }
                            }
                            RowLayout{
                                Layout.preferredWidth: parent.width
                                Text {
                                    text: qsTr("定时发布")
                                    Layout.alignment: Qt.AlignLeft
                                }
                                Button{
                                    id: timing_off
                                    background: Rectangle{
                                        color: "white"
                                    }
                                    icon.height: 30
                                    icon.width: 40
                                    icon.source: "qrc:switch-off.png"
                                    Layout.alignment: Qt.AlignRight
                                    Layout.rightMargin: 20
                                    onClicked: {
                                        timing_off.visible = false
                                        timing_on.visible = true
                                    }
                                }
                                Button{
                                    id: timing_on
                                    visible: false
                                    background: Rectangle{
                                        color: "white"
                                    }
                                    icon.height: 30
                                    icon.width: 40
                                    icon.source: "qrc:switch-on.png"
                                    Layout.alignment: Qt.AlignRight
                                    Layout.rightMargin: 20
                                    onClicked: {
                                        timing_off.visible = true
                                        timing_on.visible = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            id: publishRec
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 60
            Button{
                id: publishButton
                width: 100
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 5
                anchors.bottom: parent.bottom
                Text {
                    text: qsTr("发布")
                    color: "white"
                    anchors.centerIn: parent
                }
                background: Rectangle{
                    color: "#24c3f5"
                    radius: 10
                }
            }
        }
    }
}
