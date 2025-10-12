import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "config"
import ".."

Scope {
    id: root
    property list<string> list

    PanelWindow {
        id: wallpaper
        WlrLayershell.namespace: "qs-wallpaper-selctor"
        WlrLayershell.layer: WlrLayer.Overlay

        color: "transparent"
        margins.right: 50
        margins.left: 50
        margins.bottom: 37
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
            color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
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
                            command: ["swww", "img", modelData, "-o", wallpaper.screen.name]
                        }
                        onClicked: {
                            process.startDetached();
                            States.wallpaperOpen = false;
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
