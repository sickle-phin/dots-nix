import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.SystemTray
import Quickshell.Services.UPower
import Quickshell.Wayland
import Quickshell.Widgets
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
                spacing: 8

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
                        command: ["env", "LANG=en_US.UTF-8", "fuzzel"]
                    }
                }

                Rectangle {
                    id: bgWorkspace
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: workspace.width + 90
                    opacity: 0.8
                    color: Theme.background
                    radius: 10
                }

                Workspace {
                    id: workspace
                    anchors.right: bgWorkspace.right
                    anchors.rightMargin: 10
                    screenName: bar.screen.name
                }

                Item {
                    Layout.fillWidth: true
                }

                Rectangle {
                    anchors.top: parent.top
                    anchors.right: parent.right
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: systemTray.width + battery.width + time.width + power.width + 5 * 2
                    color: Theme.background
                    opacity: 0.8
                    radius: 10
                }

                // Right-side group: battery, time, power
                RowLayout {
                    id: right
                    Layout.alignment: Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    spacing: 0
                    // Battery
                    MyButton {
                        id: battery
                        Layout.preferredHeight: parent.height
                        Layout.preferredWidth: parent.height * 0.8
                        baseColor: "transparent"
                        property var setBalance: Process {
                            command: ["powerprofilesctl", "set", "balanced"]
                        }
                        property var setPerformance: Process {
                            command: ["powerprofilesctl", "set", "performance"]
                        }
                        property var setPowerSaver: Process {
                            command: ["powerprofilesctl", "set", "power-saver"]
                        }
                        onClicked: {
                            if (PowerProfiles.profile === 0) {
                                setBalance.running = true;
                            } else if (PowerProfiles.profile === 1) {
                                setPerformance.running = true;
                            } else {
                                setPowerSaver.running = true;
                            }
                        }
                        Image {
                            anchors.fill: parent
                            anchors.margins: 3
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
                            font.pointSize: 16
                            color: Theme.background
                        }
                        PopupWindow {
                            visible: battery.hovered || rrr.hovered
                            anchor.window: bar
                            anchor.rect.x: right.x + battery.width / 2 - width / 2
                            anchor.rect.y: anchor.window.height
                            implicitHeight: text.implicitHeight + 10
                            implicitWidth: text.implicitWidth + 10
                            color: "transparent"
                            Button {
                                id: rrr
                                anchors.fill: parent
                                opacity: 0.8
                                hoverEnabled: true
                                background: Rectangle {
                                    color: Theme.background
                                    radius: 10
                                }
                            }
                            Text {
                                id: text
                                anchors.centerIn: rrr
                                text: qsTr("Profile: " + PowerProfile.toString(PowerProfiles.profile) + "\nBattery: " + UPower.displayDevice.percentage * 100 + "%")
                                font.pixelSize: 16
                                font.family: "Mona Sans"
                                color: Theme.text
                            }
                        }
                    }

                    Rectangle {
                        id: systemTray
                        Layout.preferredHeight: parent.height - 10
                        Layout.preferredWidth: listview.contentWidth
                        color: "transparent"
                    }
                    ListView {
                        id: listview
                        anchors.fill: systemTray
                        orientation: Qt.Horizontal
                        interactive: false
                        model: SystemTray.items
                        delegate: Row {
                            IconImage {
                                implicitWidth: 22
                                implicitHeight: 30
                                source: if (modelData.icon === "image://icon/input-keyboard-symbolic") {
                                    Quickshell.iconPath("fcitx");
                                } else {
                                    modelData.icon;
                                }
                                MouseArea {
                                    anchors.fill: parent
                                    acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                                    onClicked: function (mouse) {
                                        if (mouse.button === Qt.LeftButton) {
                                            onClicked: modelData.activate();
                                            console.log(modelData.icon);
                                        } else if (mouse.button === Qt.MiddleButton) {
                                            modelData.secondaryActivate();
                                        } else if (modelData.hasMenu) {
                                            onClicked: modelData.display(bar, bar.width - power.width - time.width, bar.height);
                                        }
                                    }
                                }
                            }
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
