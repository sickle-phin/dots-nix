import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../.."
import "../config"

Rectangle {
    Layout.fillHeight: true
    Layout.preferredWidth: height
    radius: 10
    color: States.dark ? Dark.red : Light.red
    IconImage {
        anchors.fill: parent
        source: Quickshell.iconPath("system-shutdown-panel")
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            parent.color = Qt.darker(parent.color, 1.1);
        }
        onExited: {
            parent.color = States.dark ? Dark.red : Light.red;
        }
        onClicked: {
            States.powerPanelOpen = !States.powerPanelOpen;
        }
    }
}
