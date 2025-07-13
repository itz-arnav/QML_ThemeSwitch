import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: control
    property color bgColor: "white"

    Repeater {
        model: 3
        Rectangle {
            anchors.centerIn: parent
            width: parent.width - (index * 2)
            height: parent.height - (index * 2)
            color: Qt.lighter(control.bgColor, 1.3 + (index * 0.1))
            radius: height/2
            opacity: 0.4 - (index * 0.1)
            layer.enabled: true
            layer.effect: MultiEffect {
                blurEnabled: true
                blur: 0.5 + (index * 0.3)
            }
        }
    }

    Rectangle {
        id: actualRect
        anchors {
            fill: parent
            margins: 3
        }
        color: control.bgColor
        radius: height/2
    }
}
