import QtQuick
import QtQuick.Controls
import "../config"

RoundButton {
    height: 40
    width: parent.width
    property color baseColor: Theme.background
    property color hoverColor: Theme.hover
    property real bgOpacity: 1.0

    background: Rectangle {
        radius: 10
        color: baseColor
        opacity: bgOpacity

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = hoverColor;
            }
            onExited: {
                parent.color = baseColor;
            }
        }
    }
}
