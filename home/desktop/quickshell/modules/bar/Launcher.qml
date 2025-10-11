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
    color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
    property var process: Process {
        command: ["sh", "-c", "LANG=en_US.UTF-8; fuzzel"]
    }
    IconImage {
        anchors.fill: parent
        anchors.margins: 4
        source: Quickshell.iconPath("distributor-logo-nixos")
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            parent.color = Qt.lighter(parent.color, 1.5);
        }
        onExited: {
            parent.color = States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8);
        }
        onClicked: process.startDetached()
    }
}
