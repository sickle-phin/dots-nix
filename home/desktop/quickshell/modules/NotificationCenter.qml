import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import "config"
import ".."
import "../services"

PanelWindow {
    id: root
    WlrLayershell.namespace: "qs-notification-center"
    WlrLayershell.layer: WlrLayer.Top
    exclusionMode: "Normal"
    color: "transparent"
    implicitWidth: 500

    anchors {
        top: true
        right: true
        bottom: true
    }

    margins {
        top: Config.margin
        right: Config.margin
        bottom: Config.margin
    }

    Rectangle {
        anchors.fill: parent
        color: States.dark ? Dark.background : Light.background
        radius: 10
        ColumnLayout {
            spacing: 10
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 12
                Rectangle {
                    implicitHeight: 40
                    implicitWidth: 40
                    radius: 10

                    color: if (notifMouseArea.containsMouse) {
                        Qt.darker(States.dark ? Dark.red : Light.red, 1.1);
                    } else {
                        States.dark ? Dark.red : Light.red;
                    }
                    MouseArea {
                        id: notifMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            States.notificationOpen = !States.notificationOpen;
                        }
                    }
                    IconImage {
                        anchors.fill: parent
                        source: if (States.notificationOpen) {
                            Quickshell.iconPath("notification-inactive");
                        } else {
                            Quickshell.iconPath("notification-disabled");
                        }
                    }
                }
                Rectangle {
                    implicitHeight: 40
                    implicitWidth: 40
                    radius: 10

                    color: if (trashMouseArea.containsMouse) {
                        Qt.darker(States.dark ? Dark.mauve : Light.mauve, 1.1);
                    } else {
                        States.dark ? Dark.mauve : Light.mauve;
                    }
                    MouseArea {
                        id: trashMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Notifications.discardAllNotifications();
                        }
                    }
                    IconImage {
                        anchors.fill: parent
                        source: Quickshell.iconPath("indicator-trashindicator")
                    }
                }
            }

            ListView {
                id: listview
                Layout.leftMargin: 7
                spacing: 10
                implicitHeight: listview.contentHeight
                implicitWidth: 500
                flickDeceleration: 10000
                boundsBehavior: Flickable.DragAndOvershootBounds
                verticalLayoutDirection: ListView.BottomToTop
                model: Notifications.list
                delegate: ColumnLayout {
                    Text {
                        text: modelData.time
                        color: States.dark ? Dark.text : Light.text
                        font.family: "Mona Sans"
                    }
                    Rectangle {
                        id: pop
                        clip: true
                        height: title.height + body.height
                        width: listview.width - 14
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
}
