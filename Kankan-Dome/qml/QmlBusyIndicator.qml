import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    visible: true
    anchors.fill: parent
    Rectangle {
        id: rect
        width: parent.width
        height: parent.height
        color: Qt.rgba(0, 0, 0, 0)
        radius: width / 2
        border.width: width / 6
        visible: false
    }
    ConicalGradient {
        width: rect.width
        height: rect.height
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#e5ffff"
            }
            GradientStop {
                position: 1.0
                color: "#00ffff"
            }
        }
        source: rect

        Rectangle {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            width: rect.border.width
            height: width
            radius: width / 2
            color: "#00ffff"
        }

        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 1000
            loops: Animation.Infinite
        }
    }
}
