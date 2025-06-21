import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root
    property list<string> list

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: wallpaper
            property var modelData
            screen: modelData
            color: "transparent"
            margins.right: 50
            margins.left: 50
            margins.bottom: -200
            implicitHeight: 180
            exclusionMode: "Normal"
            anchors {
                right: true
                left: true
                bottom: true
            }

            Rectangle {
                id: rect
                anchors.fill: parent
                radius: 10
                color: "#1e1e2e"
                opacity: 0.75
            }

            ListView {
                id: listview
                cacheBuffer: 4096
                anchors.fill: parent
                anchors.topMargin: 15
                anchors.rightMargin: 17
                anchors.leftMargin: 17
                spacing: 13
                orientation: Qt.Horizontal
                flickableDirection: Flickable.HorizontalFlick
                flickDeceleration: 10000
                boundsBehavior: Flickable.StopAtBounds
                rebound: Transition {
                    NumberAnimation {
                        properties: "x"
                        duration: 300
                        easing.type: Easing.OutCubic
                    }
                }

                model: root.list

                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.NoButton

                    property int speed: 15

                    onWheel: event => {
                        let scroll_flick = -(event.angleDelta.x * speed);
                        if (scroll_flick === 0) {
                            scroll_flick = event.angleDelta.y * speed;
                        }
                        if (listview.horizontalOvershoot !== 0 || (scroll_flick > 0 && (listview.horizontalVelocity <= 0)) || (scroll_flick < 0 && (listview.horizontalVelocity >= 0))) {
                            listview.flick((scroll_flick - listview.horizontalVelocity), 0);
                            return;
                        } else {
                            listview.cancelFlick();
                            return;
                        }
                    }
                }

                delegate: Row {
                    Image {
                        id: img
                        source: modelData
                        height: 150
                        fillMode: Image.PreserveAspectFit

                        Behavior on height {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }

                        Behavior on y {
                            NumberAnimation {
                                duration: 300
                                easing.type: Easing.OutCubic
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            property var process: Process {
                                command: ["swww", "img", modelData]
                            }
                            onClicked: {
                                process.startDetached();
                                wallpaper.margins.bottom = -200;
                            }
                            onEntered: {
                                img.y = -10;
                                img.height = 170;
                            }
                            onExited: {
                                img.y = 0;
                                img.height = 150;
                            }
                        }
                    }
                }
            }

            IpcHandler {
                target: "wallpaper"
                function toggle(): void {
                    if (wallpaper.margins.bottom === 37) {
                        wallpaper.margins.bottom = -200;
                    } else {
                        wallpaper.margins.bottom = 37;
                    }
                }
            }
        }
    }

    Process {
        id: dateProc
        command: ["sh", "-c", "fd . $WALLPAPER_DIR"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: root.list = this.text.split("\n")
        }
    }
}
