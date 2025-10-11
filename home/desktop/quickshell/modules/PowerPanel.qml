import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import ".."
import "config"

Scope {
    id: root

    PanelWindow {
        id: powerpanel
        WlrLayershell.namespace: "qs-power-panel"
        WlrLayershell.layer: WlrLayer.Overlay
        exclusionMode: "Ignore"
        color: "transparent"
        implicitHeight: 400
        implicitWidth: listview.contentWidth

        ListView {
            id: listview
            anchors.fill: parent
            orientation: Qt.Horizontal
            spacing: 10
            interactive: false
            model: ["lock", "logout", "suspend", "shutdown", "reboot"]
            delegate: Row {
                RoundButton {
                    height: powerpanel.height - 20
                    implicitWidth: 300
                    background: Rectangle {
                        id: rect
                        radius: 20
                        color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
                    }
                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        property var process: Process {
                            command: if (modelData === "lock") {
                                ["sh", "-c", "sleep 0.1 && hyprlock"];
                            } else if (modelData === "logout") {
                                ["uwsm", "stop"];
                            } else if (modelData === "suspend") {
                                ["systemctl", "suspend"];
                            } else if (modelData === "shutdown") {
                                ["systemctl", "poweroff"];
                            } else if (modelData === "reboot") {
                                ["systemctl", "reboot"];
                            }
                        }
                        onClicked: {
                            States.powerPanelOpen = false;
                            process.startDetached();
                        }
                        onEntered: {
                            rect.color = Qt.lighter(rect.color, 1.2);
                        }
                        onExited: {
                            rect.color = States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8);
                        }
                    }

                    ColumnLayout {
                        anchors.fill: parent
                        IconImage {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.topMargin: 30
                            implicitSize: 200
                            source: Quickshell.iconPath(Quickshell.shellRoot + "/icons/" + modelData + ".png")
                        }
                        Text {
                            Layout.alignment: Qt.AlignHCenter
                            Layout.bottomMargin: 30
                            text: modelData.charAt(0).toUpperCase() + modelData.slice(1)
                            color: States.dark ? Dark.text : Light.text
                            font.pixelSize: 40
                            font.family: "Mona Sans"
                        }
                    }
                }
            }
        }
    }
}
