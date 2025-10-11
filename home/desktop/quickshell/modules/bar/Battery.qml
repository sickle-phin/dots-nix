import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Widgets
import "../.."
import "../config"

Rectangle {
    id: root

    Layout.preferredHeight: parent.height
    Layout.preferredWidth: parent.height
    color: "transparent"
    property var setBalance: Process {
        command: ["powerprofilesctl", "set", "balanced"]
    }
    property var setPerformance: Process {
        command: ["powerprofilesctl", "set", "performance"]
    }
    property var setPowerSaver: Process {
        command: ["powerprofilesctl", "set", "power-saver"]
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onEntered: {
            pop.visible = true;
        }
        onExited: {
            pop.visible = false;
        }
        onClicked: {
            if (PowerProfiles.profile === PowerProfile.Performance) {
                setPowerSaver.running = true;
            } else if (PowerProfiles.profile === PowerProfile.Balanced) {
                setPerformance.running = true;
            } else {
                setBalance.running = true;
            }
        }
    }
    IconImage {
        id: image
        anchors.centerIn: parent
        implicitWidth: 44
        implicitHeight: 44
        source: {
            var charging = "";
            var profile = "";
            var percent = UPower.displayDevice.percentage;
            if (!UPower.onBattery) {
                charging = "-charging";
            }
            if (PowerProfiles.hasPerformanceProfile) {
                if (PowerProfiles.profile === PowerProfile.Performance) {
                    profile = "-profile-performance";
                } else if (PowerProfiles.profile === PowerProfile.Balanced) {
                    profile = "-profile-balanced";
                } else {
                    profile = "-profile-powersave";
                }
            }
            if (percent >= 0.9) {
                return Quickshell.iconPath("battery-100" + charging + profile);
            } else if (percent >= 0.8) {
                return Quickshell.iconPath("battery-090" + charging + profile);
            } else if (percent >= 0.7) {
                return Quickshell.iconPath("battery-080" + charging + profile);
            } else if (percent >= 0.6) {
                return Quickshell.iconPath("battery-070" + charging + profile);
            } else if (percent >= 0.5) {
                return Quickshell.iconPath("battery-060" + charging + profile);
            } else if (percent >= 0.4) {
                return Quickshell.iconPath("battery-050" + charging + profile);
            } else if (percent >= 0.3) {
                return Quickshell.iconPath("battery-040" + charging + profile);
            } else if (percent >= 0.2) {
                return Quickshell.iconPath("battery-030" + charging + profile);
            } else if (percent >= 0.1) {
                return Quickshell.iconPath("battery-020" + charging + profile);
            } else if (percent > 0) {
                return Quickshell.iconPath("battery-010" + charging + profile);
            } else {
                return Quickshell.iconPath("battery-000" + charging + profile);
            }
        }
    }
    PopupWindow {
        id: pop
        color: "transparent"
        implicitHeight: text.height + 15
        implicitWidth: text.width + 15
        anchor {
            gravity: Edges.Bottom
            item: root
            margins.top: parent.height
            rect.x: 20
        }
        Rectangle {
            anchors.fill: parent
            radius: 10
            color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
            Text {
                id: text
                anchors.centerIn: parent
                text: qsTr("Profile: " + PowerProfile.toString(PowerProfiles.profile) + "\nBattery: " + UPower.displayDevice.percentage * 100 + "%")
                font.pixelSize: 16
                font.family: "Mona Sans"
                color: States.dark ? Dark.text : Light.text
            }
        }
    }
}
