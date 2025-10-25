import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "config"
import ".."
import "../services"

Scope {
    id: notificationPopup

    PanelWindow {
        id: root
        WlrLayershell.namespace: "qs-notification-popup"
        WlrLayershell.layer: WlrLayer.Overlay
        exclusionMode: "Ignore"
        color: "transparent"
        implicitWidth: 500

        anchors {
            top: true
            right: true
            bottom: true
        }

        margins {
            right: Config.margin
            bottom: Config.margin
        }

        mask: Region {
            item: listview.contentItem
        }

        ListView {
            id: listview
            anchors {
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }
            spacing: 10
            implicitHeight: listview.contentHeight
            interactive: false
            model: Notifications.popupList
            delegate: Row {
                property bool popup: modelData.popup

                Rectangle {
                    id: pop
                    clip: true
                    height: title.height + body.height
                    width: root.width
                    radius: 10
                    color: States.dark ? Dark.background : Light.background
                    border.width: 3
                    border.color: if (modelData.urgency == 0) {
                        States.dark ? Dark.green : Light.green;
                    } else if (modelData.urgency == 2) {
                        States.dark ? Dark.red : Light.red;
                    } else {
                        States.dark ? Dark.yellow : Light.yellow;
                    }

                    RowLayout {
                        id: notificationContent
                        anchors.fill: parent
                        Layout.fillWidth: true
                        spacing: 0
                        IconImage {
                            id: image
                            Layout.alignment: Qt.AlignTop
                            Layout.topMargin: 7
                            Layout.leftMargin: 7
                            Layout.rightMargin: 2
                            implicitSize: 40
                            source: Quickshell.iconPath(modelData.appIcon, "notifications")
                        }
                        ColumnLayout {
                            spacing: -9
                            Layout.alignment: Qt.AlignTop
                            Layout.rightMargin: 10
                            Text {
                                id: title
                                Layout.fillWidth: true
                                text: modelData.summary
                                clip: true
                                font.pointSize: 15
                                font.bold: true
                                color: States.dark ? Dark.text : Light.text
                                verticalAlignment: Text.AlignVCenter
                                wrapMode: Text.Wrap
                                maximumLineCount: 1
                            }
                            Text {
                                id: body
                                Layout.fillWidth: true
                                text: modelData.body
                                clip: true
                                lineHeight: 0.7
                                font.pointSize: 15
                                color: States.dark ? Dark.text : Light.text
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
}
