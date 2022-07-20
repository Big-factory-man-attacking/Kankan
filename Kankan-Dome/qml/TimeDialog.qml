import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: timeTumbler
    color: "white"
    anchors.fill: parent
    visible: true
    property var date: new Date()
    property int feb: date.getFullYear()%4 == 0 ? 29 : 28
    readonly property var days: [31, feb, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

    function formatText(count,modelData) {
        var data = (count !== 24 && count !== 60) ? modelData + 1 : modelData
        return data.toString().length < 2 ? "0" + data : data
    }
    ColumnLayout {
        width: parent.width-20
        height: parent.height-20
        anchors.centerIn: parent
        spacing: 10
        Rectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 30
            Row {
                anchors.fill: parent
                spacing: 0
                Text {
                    width: parent.width/4
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    text: qsTr("月")
                }
                Text {
                    width: parent.width/4
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    text: qsTr("日")
                }
                Text {
                    width: parent.width/4
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    text: qsTr("时")
                }
                Text {
                    width: parent.width/4
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    text: qsTr("分")
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 190

            FontMetrics {
                id: fontMetrics
            }
            Component {

                id: delegateComponent

                Label {
                    text: formatText(Tumbler.tumbler.count, modelData)
                    opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: fontMetrics.font.pixelSize * 1.25
                }
            }
            RowLayout {
                anchors.fill: parent
                spacing: 0
                Tumbler {
                    id: monthTumbler
                    Layout.preferredWidth: parent.width/4
                    model:  12
                    currentIndex: date.getMonth()
                    delegate: delegateComponent
                }
                Tumbler {
                    id: dayTumbler
                    Layout.preferredWidth: parent.width/4
                    model: days[monthTumbler.currentIndex]
                    currentIndex: date.getDate()-1
                    delegate: delegateComponent
                }
                Tumbler {
                    id: hoursTumbler
                    Layout.preferredWidth: parent.width/4
                    model: 24
                    currentIndex: date.getHours()
                    delegate: delegateComponent
                }
                Tumbler {
                    id: minutesTumbler
                    Layout.preferredWidth: parent.width/4
                    model: 60
                    currentIndex: date.getMinutes()
                    delegate: delegateComponent
                }
            }
        }
        Rectangle {
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: parent.height-100
            Layout.preferredHeight: 30
            RowLayout {
                anchors.fill: parent
                Button{
                    text: qsTr("取消")
                    Layout.alignment: Qt.AlignLeft
                    background: Rectangle {
                        color: "#9de4fb"
                        radius: 3
                    }
                    onClicked: {
                        timeRec.visible = false
                        if ((timing_on.visible === false)) {
                            timing_on.clicked()
                        }
                    }
                }
                Button {
                    text: qsTr("确认")
                    Layout.alignment: Qt.AlignRight
                    background: Rectangle {
                        color: "#9de4fb"
                        radius: 3
                    }
                    onClicked: {
                        var publishDate = new Date()
                        publishDate.setMonth(monthTumbler.currentIndex)
                        publishDate.setDate(dayTumbler.currentIndex+1)
                        publishDate.setHours(hoursTumbler.currentIndex)
                        publishDate.setMinutes(minutesTumbler.currentIndex)
                        date = new Date()
                        if ((publishDate-date) < 7200000) {
                            timingHint.visible = true
                            hintTimer.running = true
                        } else {
                            date = publishDate
                            timeRec.visible = false
                            timing_off.visible = false
                            timing_on.visible = true
                            toolS_2.visible = true
                            showTimeButton.visible = true
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: timingHint
        width: 250
        height: 60
        anchors.centerIn: parent
        visible: false
        opacity: 0.8
        radius: 5
        color: "black"
        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 16
            text: qsTr("定时发布时间离当前时间必须\n大于2小时，请重新选择")
        }
        Timer {
            id: hintTimer
            interval: 3000
            running: false
            repeat: false
            onTriggered: {
                timingHint.visible = false
            }
        }
    }
}
