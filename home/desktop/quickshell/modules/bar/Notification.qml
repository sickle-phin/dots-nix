import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import "../.."
import "../config"

Rectangle {
    id: root

    Layout.preferredHeight: parent.height
    Layout.preferredWidth: parent.height - 5
    radius: 10

    color: if (mouseArea.containsMouse) {
        States.dark ? Dark.surface1 : Light.surface1;
    } else {
        "transparent";
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            States.notificationCenterOpen = !States.notificationCenterOpen;
        }
    }
    IconImage {
        id: image
        anchors.fill: parent
        source: if (States.notificationOpen) {
            Quickshell.iconPath("notification-inactive");
        } else {
            Quickshell.iconPath("notification-disabled");
        }
    }
}
