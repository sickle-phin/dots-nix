import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import Quickshell.Wayland
import "../config"

Scope {
    id: root
    property list<string> list

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData
            screen: modelData
            color: "transparent"
            margins.top: 8
            margins.right: 15
            margins.left: 15
            height: 40
            WlrLayershell.namespace: "qs-bar"

            anchors {
                top: true
                right: true
                left: true
            }

            MyButton {
                id: launcher
                anchors.left: parent.left
                height: parent.height
                width: parent.height
                bgOpacity: 0.8

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: "/home/sickle-phin/dots-nix/home/desktop/icons/NixOS.png"
                    fillMode: Image.PreserveAspectFit
                }

                property var process: Process {
                    command: ["fuzzel"]
                }
                onClicked: {
                    process.startDetached();
                }
            }

            Rectangle {
                anchors.right: parent.right
                color: Theme.background
                height: parent.height
                width: power.width + time.width + battery.width + 10
                radius: 10
                MyButton {
                    id: battery
                    anchors.right: time.left
                    height: parent.height
                    width: parent.height * 0.8
                    baseColor: "transparent"

                    Image {
                        anchors.fill: parent
                        anchors.margins: 5
                        fillMode: Image.PreserveAspectFit
                        source: if (0.875 <= UPower.displayDevice.percentage) {
                            "../icons/battery-1.svg";
                        } else if (0.75 <= UPower.displayDevice.percentage) {
                            "../icons/battery-2.svg";
                        } else if (0.625 <= UPower.displayDevice.percentage) {
                            "../icons/battery-3.svg";
                        } else if (0.5 <= UPower.displayDevice.percentage) {
                            "../icons/battery-4.svg";
                        } else if (0.375 <= UPower.displayDevice.percentage) {
                            "../icons/battery-5.svg";
                        } else if (0.25 <= UPower.displayDevice.percentage) {
                            "../icons/battery-6.svg";
                        } else if (0.125 <= UPower.displayDevice.percentage) {
                            "../icons/battery-7.svg";
                        } else if (0 < UPower.displayDevice.percentage) {
                            "../icons/battery-8.svg";
                        } else {
                            "../icons/battery-9.svg";
                        }
                        property var notifNormal: Process {
                            command: ["notify-send", "-u", "normal", "your battery is running low!"]
                        }
                        property var notifCritical: Process {
                            command: ["notify-send", "-u", "critical", "your battery is running low!"]
                        }
                        onSourceChanged: {
                            if (source == "../icons/battery-7.svg") {
                                notifNormal.startDetached();
                            } else if (source == "../icons/battery-8.svg") {
                                notifCritical.startDetached();
                            }
                        }
                    }
                    Text {
                        visible: !UPower.onBattery
                        anchors.centerIn: parent
                        text: "󱐋"
                        font.family: "Moralerspace Neon HW"
                        font.pointSize: 14
                    }
                }

                MyButton {
                    id: time
                    anchors.right: power.left
                    height: parent.height
                    width: parent.height * 2.5
                    baseColor: "transparent"

                    SystemClock {
                        id: clock
                        precision: SystemClock.Seconds
                    }
                    Text {
                        anchors.centerIn: parent
                        text: Qt.formatDateTime(clock.date, "yyyy/M/d\nh:mm")
                        font.family: "Moralerspace Neon HW"
                        font.pointSize: 12
                        color: Theme.text
                    }
                }

                MyButton {
                    id: power
                    anchors.right: parent.right
                    width: parent.height
                    baseColor: Theme.power
                    hoverColor: Qt.darker(Theme.power, 1.1)

                    Image {
                        anchors.fill: parent
                        anchors.margins: 5
                        source: "../icons/power.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }
        }
    }
}
