import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Widgets
import "../config"
import "../.."
import "../../services"

Rectangle {
    id: root
    required property string screenName
    Layout.fillHeight: true
    Layout.preferredWidth: listview.contentWidth + 10
    radius: 10
    color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
    Rectangle {
        id: workspace
        anchors.centerIn: parent
        implicitHeight: parent.height * 0.7
        implicitWidth: listview.contentWidth
        radius: 20
        color: States.dark ? Qt.rgba(Dark.overlay1.r, Dark.overlay1.g, Dark.overlay1.b, 0.7) : Qt.rgba(Light.overlay1.r, Light.overlay1.g, Light.overlay1.b, 0.7)
        ListView {
            id: listview
            anchors.fill: parent
            interactive: false
            orientation: Qt.Horizontal
            model: Hyprland.workspaces

            delegate: Row {
                id: workspaceRow
                height: parent.height

                Rectangle {
                    id: item
                    visible: modelData.monitor.name === root.screenName
                    height: parent.height
                    implicitWidth: 30
                    radius: 20
                    color: Hyprland.focusedWorkspace.id === modelData.id ? States.dark ? Dark.overlay2 : Light.overlay2 : "transparent"

                    Rectangle {
                        anchors.fill: parent
                        radius: parent.radius
                        color: "transparent"

                        MouseArea {
                            id: mouseArea
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                screenCopyView.captureSource = Hyprland.workspaces.values[modelData.id - 1].toplevels.values[0].wayland;
                                parent.color = Hyprland.focusedWorkspace.id === modelData.id ? "transparent" : States.dark ? Dark.overlay2 : Light.overlay2;
                            }
                            onExited: {
                                screenCopyView.captureSource = null;
                                parent.color = "transparent";
                            }
                            onClicked: {
                                Hyprland.dispatch("workspace " + modelData.id);
                                HyprlandData.getClients.running = true;
                            }
                        }
                    }

                    Text {
                        visible: icon.source == "dummy"
                        anchors.centerIn: parent
                        text: modelData.id
                        font.family: "Mona Sans"
                        font.pixelSize: 15
                        color: States.dark ? Dark.base : Light.base
                    }

                    IconImage {
                        id: icon
                        anchors.centerIn: parent
                        implicitSize: 22

                        property int index: findClientIndex()
                        property string appClass: HyprlandData.clients[index]?.class || ""
                        property string appName: Config.appNameMap[appClass] || appClass

                        source: index >= 0 ? Quickshell.iconPath(appName, Quickshell.shellRoot + "/icons/NixOS.png") : "dummy"

                        function findClientIndex() {
                            for (let i = 0; i < HyprlandData.clients.length; ++i) {
                                if (modelData.id === HyprlandData.clients[i].workspace.id)
                                    return i;
                            }
                            return -1;
                        }
                    }
                    PopupWindow {
                        id: pop
                        visible: mouseArea.containsMouse
                        color: "transparent"
                        anchor {
                            item: root
                            rect.y: root.height
                        }
                        implicitHeight: screenCopyView.hasContent ? screenCopyView.sourceSize.height * 0.3 : 1
                        implicitWidth: screenCopyView.hasContent ? screenCopyView.sourceSize.width * 0.3 : 1
                        Rectangle {
                            id: rect
                            visible: screenCopyView.hasContent
                            anchors.fill: parent
                            radius: 10
                            color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
                            ScreencopyView {
                                id: screenCopyView
                                visible: hasContent
                                anchors.fill: parent
                                anchors.margins: 7
                                live: true
                            }
                        }
                    }
                }
            }
        }
    }
}
