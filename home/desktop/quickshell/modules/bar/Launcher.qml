import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import "../.."
import "../config"

Rectangle {
    Layout.fillHeight: true
    Layout.preferredWidth: height
    radius: 10
    color: if (mouseArea.containsMouse) {
        Qt.lighter(States.dark ? Dark.background : Light.background, 1.5);
    } else {
        States.dark ? Dark.background : Light.background;
    }
    property var process: Process {
        command: ["sh", "-c", "LANG=en_US.UTF-8; fuzzel"]
    }
    IconImage {
        anchors.fill: parent
        anchors.margins: 4
        source: Quickshell.iconPath("distributor-logo-nixos")
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: process.startDetached()
    }
}
