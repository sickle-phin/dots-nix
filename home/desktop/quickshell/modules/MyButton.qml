import QtQuick
import QtQuick.Controls
import "../config"

RoundButton {
    height: 40
    width: parent.width
    background: Rectangle {
        radius: 10
        color: Theme.background
        opacity: 0.75

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                parent.color = Theme.hover;
            }
            onExited: {
                parent.color = Theme.background;
            }
        }
    }
}
