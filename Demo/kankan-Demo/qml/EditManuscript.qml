import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    anchors.fill: parent
    color: "white"
    property var manuscript: ({})
    property alias source: coverImg.source

    function getManuscript() {
        coverImg.source = manuscript["cover"]
        titleText.text = manuscript["title"]
        labelText.text = manuscript["label"]
        subarea.editText = manuscript["subarea"]
        inforTextA.text = manuscript["description"]
        if (manuscript["idOriginal"] === "1") {
            self_restraintButton.checked = true
        } else {
            reprintButton.checked = true
        }
    }

    Column {
        id: contentColumn
        width: parent.width
        height: parent.height
        spacing: 12
        RowLayout {
            id: titleRow
            width: parent.width
            height: 40
            spacing: 15
            Button {
                id: to_leftButton
                icon.source: "qrc:to_left.png"
                icon.width: 35
                icon.height: 30
                Layout.alignment: Qt.AlignBottom
                background: Rectangle {
                    color: "white"
                }
                onClicked: {
                    editManuscript.visible = false
                }
            }
            Text {
                text: qsTr("编辑稿件")
                font.pixelSize: 16
                Layout.alignment: Qt.AlignHCenter
            }
            Button {
                id: publishButton
                Layout.preferredWidth: 50
                Layout.preferredHeight: 30
                Layout.alignment: Qt.AlignBottom | Qt.AlignRight
                Layout.rightMargin: 10
                Text {
                    text: qsTr("保存")
                    color: "white"
                    anchors.centerIn: parent
                }
                background: Rectangle {
                    color: "#24c3f5"
                    radius: 5
                }
                onClicked: {
                    if (checkManscript() == true) {
                        //传输数据给稿件修改函数
                        manuscript["description"] = inforTextA.text
                        manuscript["title"] = titleText.text
                        manuscript["label"] = labelText.text
                        manuscript["subarea"] = subarea.editText
                        if (self_restraintButton.checked == true) {
                            manuscript["isOriginal"] = "1"
                        } else {
                            manuscript["isOriginal"] = "0"
                        }
                        manuscript["cover"] = source.toString()
                        videoSocialControl.modifyManuscriptInfo(mainPage.personalPage.netizen["id"], manuscript)
                        mainPage.personalPage.netizen["videos"][manuscriptListView.currentIndex] = manuscript
                        manuscripts[manuscriptListView.currentIndex] = manuscript
                        manuscriptPage.getManuscript()
                        mainPage.homePage.manuscripts = videoSocialControl.getSomeVideos()
                        mainPage.homePage.getVideoInfo()
                        editManuscript.visible = false
                    }
                }
            }
        }
        ToolSeparator {
            height: 1
            width: parent.width
            contentItem: Rectangle{
                anchors.fill: parent
                color: "#cccccc"
            }
        }
        ScrollView {
            id: scroll
            width: parent.width
            height: parent.height-titleRow.height-25
            clip: true
            ColumnLayout {
                width: contentColumn.width
                spacing: 12
                Rectangle {
                    id: coverRec
                    Layout.preferredWidth: parent.width-20
                    Layout.preferredHeight: (parent.width-20)/16*9
                    Layout.alignment: Qt.AlignHCenter
                    color: "grey"
                    Image {
                        id: coverImg
                        width: parent.width
                        height: parent.height
                        source: "qrc:cover.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    Button {
                        id: changeCover
                        width: 60
                        height: 30
                        anchors.right: coverImg.right
                        anchors.bottom: coverImg.bottom
                        anchors.rightMargin: 10
                        anchors.bottomMargin: 5
                        Text {
                            text: qsTr("修改封面")
                            color: "white"
                            anchors.centerIn: parent
                            font.pixelSize: 12
                        }
                        background: Rectangle {
                            color: "black"
                            opacity: 0.5
                            radius: 3
                        }
                        onClicked: {
                            dialogs.coverImageDialog.open()
                        }
                    }
                }
                Rectangle {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 95
                    Text {
                        id: headlineText
                        text: qsTr("标题")
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 5
                        font.pointSize: 12
                    }
                    ColumnLayout {
                        width: parent.width-headlineText.width-30
                        anchors.left: headlineText.right
                        anchors.leftMargin: 10
                        spacing: 1
                        ScrollView {
                            id: textAreaView
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: 76
                            Layout.alignment: Qt.AlignHCenter
                            clip: true
                            ScrollBar.horizontal: ScrollBar{ visible: true }
                            TextArea {
                                id: titleText
                                width: textAreaView.width-30
                                height: 76
                                placeholderText: qsTr("请输入标题（必填）")
                                wrapMode: TextEdit.Wrap
                                font.pointSize: 12
                            }
                        }
                        RowLayout {
                            spacing: 1
                            Layout.rightMargin: 20
                            Layout.alignment: Qt.AlignRight
                            Text {
                                Layout.preferredWidth: 30
                                text: titleText.length
                                color: titleText.length > 80 ? "red" : "black"
                                horizontalAlignment: Text.AlignRight
                            }
                            Text {
                                text: qsTr("/80")
                            }

                        }
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-30
                    Layout.alignment: Qt.AlignHCenter
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                RowLayout {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 30
                    spacing: 0
                    Label {
                        text: qsTr("分区：")
                        Layout.alignment: Qt.AlignLeft
                        Layout.leftMargin: 10
                    }
                    ComboBox {
                        id:subarea
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
                    Label {
                        text: qsTr("标签：")
                    }
                    TextField {
                        id: labelText
                        Layout.preferredWidth: 120
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-30
                    Layout.alignment: Qt.AlignHCenter
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 20
                    Text {
                        id: isOriginalText
                        text: qsTr("类型（必填）")
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }
                    RowLayout {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        width: 130
                        spacing: 10
                        Rectangle {
                            width: 100
                            Layout.preferredHeight: 20
                            Layout.preferredWidth: 60
                            RadioButton {
                                id: self_restraintButton
                                width: 20
                                height: 20
                                onCheckedChanged: {
                                    if (checked === true) {
                                        checkable = false
                                        self_restraintText.color = "#3ccaf6"
                                        reprintText.color = "black"
                                        reprintButton.checkable = true
                                        reprintButton.checked = false
                                    }
                                }
                            }
                            Text {
                                id: self_restraintText
                                text: qsTr("自制")
                                anchors.left: self_restraintButton.right
                                anchors.leftMargin: 5
                            }
                        }
                        Rectangle {
                            id: reprintRec
                            Layout.preferredHeight: 20
                            Layout.preferredWidth: 60
                            RadioButton {
                                id: reprintButton
                                width: 20
                                height: 20
                                onCheckedChanged: {
                                    if (checked === true) {
                                        checkable = false
                                        reprintText.color = "#3ccaf6"
                                        self_restraintText.color = "black"
                                        self_restraintButton.checkable = true
                                        self_restraintButton.checked = false
                                    }
                                }
                            }
                            Text {
                                id: reprintText
                                text: qsTr("转载")
                                anchors.left: reprintButton.right
                                anchors.leftMargin: 5
                            }
                        }
                    }
                }
                ToolSeparator {
                    Layout.preferredHeight: 1
                    Layout.preferredWidth: parent.width-30
                    Layout.alignment: Qt.AlignHCenter
                    contentItem: Rectangle{
                        anchors.fill: parent
                        color: "#cccccc"
                    }
                }
                Rectangle {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 100
                    Text {
                        id: inforText
                        text: qsTr("简介")
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                    }
                    Rectangle {
                        id: inforFrame
                        width: parent.width-inforText.width-30
                        height: 130
                        anchors.left: inforText.right
                        anchors.leftMargin: 10
                        radius: 10
                        color: "#f2f2f2"
                        ColumnLayout {
                            anchors.fill: parent
                            spacing: 1
                            ScrollView {
                                id: inforTextAreaView
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: 85
                                Layout.alignment: Qt.AlignHCenter
                                clip: true
                                ScrollBar.horizontal: ScrollBar{ visible: true }
                                TextArea {
                                    id: inforTextA
                                    width: textAreaView.width-30
                                    height: 85
                                    placeholderText: qsTr("可填写简介")
                                    wrapMode: TextEdit.Wrap
                                    font.pointSize: 12
                                }
                            }
                            RowLayout {
                                spacing: 1
                                Layout.rightMargin: 20
                                Layout.alignment: Qt.AlignRight
                                Text {
                                    Layout.preferredWidth: 30
                                    text: inforTextA.length
                                    color: inforTextA.length > 250 ? "red" : "black"
                                    horizontalAlignment: Text.AlignRight
                                }
                                Text {
                                    text: qsTr("/250")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Button {
        id: missInfo
        width: 200
        height: 60
        anchors.centerIn: parent
        visible: false
        Text {
            id: missText
            text: qsTr("请填写所有的必填信息！")
            color: "#24c3f5"
            font.pixelSize: 14
            anchors.centerIn: parent
        }
        background: Rectangle {
            color: "black"
            opacity: 0.1
            radius: 5
        }
    }
    Timer {
        id: missInfoTimer
        running: false
        repeat: false
        interval: 2000
        onTriggered: {
            missInfo.visible = false
        }
    }

    function checkManscript() {
        if (titleText.text == "" || labelText.text == "" || (self_restraintButton.checked == false && reprintButton.checked == false)) {
            missText.text = qsTr("请填写所有的必填信息！")
            missInfo.visible = true
            missInfoTimer.running = true
            return false
        }
        return true
    }
}
