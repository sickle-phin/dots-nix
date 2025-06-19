{ inputs, ... }:
{
  xdg.configFile = {
    "quickshell/shell.qml" = {
      text = ''
        import Quickshell
        import Quickshell.Io
        import QtQuick

        Scope {
            id: root
            ListModel {
                id: fileModel
            }

            Variants {
                model: Quickshell.screens

                PanelWindow {
                    property var modelData
                    screen: modelData
                    color: "transparent"
                    margins.right: 17
                    margins.left: 17

                    anchors {
                        top: true
                        right: true
                        left: true
                    }

                    implicitHeight: 180
                    implicitWidth: 1500
                    Rectangle {
                        anchors.fill: parent

                        radius: 10
                        color: "#1e1e2e" // your actual color
                        opacity: 0.75
                    }

                    ListView {
                        width: 1800
                        height: 200
                        anchors.fill: parent
                        anchors.topMargin: 13
                        anchors.rightMargin: 13
                        anchors.leftMargin: 13
                        spacing: 13
                        contentY: 300

                        orientation: Qt.Horizontal

                        contentWidth: 320
                        flickableDirection: Flickable.AutoFlickDirection

                        model: fileModel

                        delegate: Row {
                            Image {
                                id: img
                                source: name
                                height: 150
                                // transformOrigin: Item.BottomRight
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
                                        command: ["swww", "img", name]
                                    }
                                    onClicked: {
                                        process.startDetached();
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
            }

            Process {
                id: dateProc
                command: ["fd", ".", "${inputs.wallpaper}/wallpaper"]
                running: true

                stdout: StdioCollector {
                    onStreamFinished: {
                        let lines = this.text.split("\n");

                        fileModel.clear();
                        for (let i = 0; i < lines.length - 1; ++i) {
                            fileModel.append({
                                name: lines[i]
                            });
                        }
                    }
                }
            }
        }
      '';
    };
  };
}
