import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Io
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
            margins.top: 15
            margins.left: 10
            margins.bottom: 15
            width: 40
            anchors {
                top: true
                left: true
                bottom: true
            }

            MyButton {
                id: launcher

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

            MyButton {
                anchors.centerIn: parent
                height: 100

                SystemClock {
                    id: clock
                    precision: SystemClock.Seconds
                }
                Text {
                    anchors.centerIn: parent
                    text: Qt.formatDateTime(clock.date, "hh\nmm")
                    font.family: "Moralerspace Neon HW"
                    font.pointSize: 17
                    color: Theme.text
                }
            }

            MyButton {
                id: power
                anchors.bottom: parent.bottom

                Image {
                    anchors.fill: parent
                    anchors.margins: 5
                    source: "/home/sickle-phin/dots-nix/home/desktop/icons/power.png"
                    fillMode: Image.PreserveAspectFit
                }

                property var process: Process {
                    command: ["fuzzel"]
                }
                onClicked: {
                    process.startDetached();
                }
            }
        }
    }
}
