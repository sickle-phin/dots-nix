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
    color: if (mouseArea.containsMouse) {
        Qt.darker(States.dark ? Dark.red : Light.red, 1.1);
    } else {
        States.dark ? Dark.red : Light.red;
    }
    IconImage {
        anchors.fill: parent
        source: Quickshell.iconPath("system-shutdown-panel")
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            States.powerPanelOpen = !States.powerPanelOpen;
        }
    }
}
