import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../config"
import "../services"

Scope {
    id: root
    property int test: 400

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: a
            property var modelData

            screen: modelData
            color: "transparent"
            implicitHeight: listview.contentHeight
            implicitWidth: 500
            exclusionMode: "Normal"
            WlrLayershell.namespace: "qs-notification-popup"

            anchors {
                right: true
                bottom: true
            }

            margins.right: if (Notifs.popupList.length > 0) {
                10;
            } else {
                -600;
            }

            margins.bottom: if (Notifs.popupList.length > 0) {
                10;
            } else {
                -00;
            }

            ListView {
                id: listview
                anchors.fill: parent
                anchors.topMargin: 10
                spacing: 10
                verticalLayoutDirection: ListView.BottomToTop
                interactive: false
                model: Notifs.popupList
                delegate: Row {
                    property bool popup: modelData.popup

                    Rectangle {
                        id: pop
                        clip: true
                        height: title.height + body.height
                        width: a.width
                        radius: 10
                        color: Theme.background
                        opacity: 0.85
                        border.width: 3
                        border.color: if (modelData.urgency == 0) {
                            Theme.low;
                        } else if (modelData.urgency == 2) {
                            Theme.critical;
                        } else {
                            Theme.normal;
                        }
                    }

                    property var process: Process {
                        command: ["echo", "$ICON_DIR"]
                        stdout: StdioCollector {
                            onStreamFinished: console.log(`line read: ${this.text}`)
                        }
                    }

                    Item {
                        Image {
                            id: icon
                            source: Quickshell.iconPath(modelData.appIcon, Quickshell.shellRoot + "/icons/NixOS.png")
                            x: pop.x + 10
                            y: pop.y + 5
                            height: 40
                            fillMode: Image.PreserveAspectFit
                        }
                        Text {
                            id: title
                            text: modelData.summary
                            clip: true
                            x: icon.x + icon.width + 10
                            width: pop.width - 100
                            font.pointSize: 13
                            font.bold: true
                            color: Theme.text
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            maximumLineCount: 1
                        }
                        Text {
                            id: body
                            text: modelData.body
                            clip: true
                            x: title.x
                            y: title.y + 15
                            width: pop.width - 70
                            lineHeight: 0.6
                            font.pointSize: 13
                            color: Theme.text
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.Wrap
                            maximumLineCount: 10
                        }
                    }
                }
            }
        }
    }
}
