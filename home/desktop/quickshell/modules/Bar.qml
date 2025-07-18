import QtQuick
import QtQuick.Layouts
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

            RowLayout {
                anchors.fill: parent
                anchors.margins: 0
                spacing: 10

                // Launcher button on the left
                MyButton {
                    id: launcher
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.height
                    bgOpacity: 0.8
                    onClicked: process.startDetached()

                    Image {
                        anchors.fill: parent
                        anchors.margins: 5
                        source: "../icons/NixOS.png"
                        fillMode: Image.PreserveAspectFit
                    }
                    property var process: Process {
                        command: ["fuzzel"]
                    }
                }

                Rectangle {
                    id: bgWorkspace
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: workspace.width + 10
                    opacity: 0.8
                    color: Theme.background
                    radius: 10
                }

                Workspace {
                    id: workspace
                    anchors.centerIn: bgWorkspace
                    screenName: bar.screen.name
                }

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: battery.width + time.width + power.width + 5 * 2
                    color: Theme.background
                    opacity: 0.8
                    radius: 10
                }

                // Right-side group: battery, time, power
                RowLayout {
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    spacing: 0

                    // Battery
                    MyButton {
                        id: battery
                        Layout.preferredHeight: parent.height
                        Layout.preferredWidth: parent.height * 0.8
                        baseColor: "transparent"

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            fillMode: Image.PreserveAspectFit
                            source: {
                                var pct = UPower.displayDevice.percentage;
                                if (pct >= 0.875)
                                    return "../icons/battery-1.svg";
                                if (pct >= 0.75)
                                    return "../icons/battery-2.svg";
                                if (pct >= 0.625)
                                    return "../icons/battery-3.svg";
                                if (pct >= 0.5)
                                    return "../icons/battery-4.svg";
                                if (pct >= 0.375)
                                    return "../icons/battery-5.svg";
                                if (pct >= 0.25)
                                    return "../icons/battery-6.svg";
                                if (pct >= 0.125)
                                    return "../icons/battery-7.svg";
                                if (pct > 0)
                                    return "../icons/battery-8.svg";
                                return "../icons/battery-9.svg";
                            }
                            property var notifNormal: Process {
                                command: ["notify-send", "-u", "normal", "Your battery is running low!"]
                            }
                            property var notifCritical: Process {
                                command: ["notify-send", "-u", "critical", "Your battery is running low!"]
                            }
                            onSourceChanged: {
                                if (UPower.onBattery) {
                                    if (source == "battery-7.svg")
                                        notifNormal.startDetached();
                                    else if (source == "battery-8.svg")
                                        notifCritical.startDetached();
                                }
                            }
                        }
                        Text {
                            visible: !UPower.onBattery
                            anchors.centerIn: parent
                            text: "󱐋"
                            font.family: "Symbols Nerd Font"
                            font.pointSize: 14
                            color: Theme.background
                        }
                    }

                    // Time
                    MyButton {
                        id: time
                        Layout.preferredHeight: parent.height
                        Layout.preferredWidth: parent.height * 2.0
                        baseColor: "transparent"

                        SystemClock {
                            id: clock
                            precision: SystemClock.Seconds
                        }
                        Text {
                            anchors.centerIn: parent
                            text: Qt.formatDateTime(clock.date, "yyyy/M/d\nh:mm")
                            font.family: "Mona Sans"
                            font.pointSize: 11
                            lineHeight: 0.7
                            color: Theme.text
                        }
                    }

                    // Power
                    MyButton {
                        id: power
                        Layout.preferredHeight: parent.height
                        Layout.preferredWidth: parent.height
                        baseColor: Theme.power
                        hoverColor: Qt.darker(Theme.power, 1.1)
                        PowerPanel {
                            id: powerpanel
                            IpcHandler {
                                target: "powerpanel"
                                function toggle(): void {
                                    powerpanel.shouldShowPowerPanel = !powerpanel.shouldShowPowerPanel;
                                }
                            }
                        }
                        onClicked: {
                            powerpanel.shouldShowPowerPanel = !powerpanel.shouldShowPowerPanel;
                        }

                        Image {
                            anchors.fill: parent
                            anchors.margins: 5
                            source: "../icons/shutdown.png"
                            fillMode: Image.PreserveAspectFit
                        }
                    }
                }
            }
        }
    }
}
