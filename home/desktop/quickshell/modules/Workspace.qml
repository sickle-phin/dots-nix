import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import "../config"

Item {
    id: root
    property string screenName
    Layout.preferredHeight: parent.height
    Layout.preferredWidth: listview.contentWidth

    Process {
        id: getClients
        running: true
        property list<var> clients: []
        command: ["hyprctl", "-j", "clients"]
        stdout: StdioCollector {
            onStreamFinished: {
                getClients.clients = JSON.parse(this.text);
            }
        }
    }

    Connections {
        target: Hyprland
        onRawEvent: {
            if (event.name === "openwindow" || event.name === "closewindow" || event.name === "movewindow") {
                getClients.running = true;
                console.log(event.name);
                console.log("\n");
            }
        }
    }

    Rectangle {
        id: workspace
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5

        opacity: 0.5
        radius: 15
        color: Theme.workspace
    }

    ListView {
        id: listview
        anchors.fill: parent
        anchors.topMargin: 5
        anchors.bottomMargin: 5
        interactive: false
        orientation: Qt.Horizontal
        model: Hyprland.workspaces

        delegate: Row {
            id: workspaceRow
            height: parent.height

            Rectangle {
                visible: modelData.monitor.name === root.screenName
                height: parent.height
                implicitWidth: 30
                radius: workspace.radius
                color: Hyprland.focusedWorkspace.id === modelData.id ? Theme.workspace : "transparent"

                Rectangle {
                    anchors.fill: parent
                    radius: parent.radius
                    color: "transparent"

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true

                        onEntered: parent.color = Hyprland.focusedWorkspace.id === modelData.id ? "transparent" : Theme.workspace
                        onExited: parent.color = "transparent"
                        onClicked: {
                            Hyprland.dispatch("workspace " + modelData.id);
                            getClients.running = true;
                        }
                    }
                }

                Text {
                    visible: icon.source == "dummy"
                    anchors.centerIn: parent
                    text: modelData.id
                    font.family: "Mona Sans"
                    font.pixelSize: 15
                    color: Theme.background
                }

                IconImage {
                    id: icon
                    anchors.centerIn: parent
                    implicitSize: 22

                    property int index: findClientIndex()
                    property string appClass: getClients.clients[index]?.class || ""
                    readonly property var appNameMap: ({
                            ".virt-manager-wrapped": "virt-manager",
                            Slack: "slack"
                        })
                    property string appName: appNameMap[appClass] || appClass

                    source: index >= 0 ? Quickshell.iconPath(appName, Quickshell.shellRoot + "/icons/NixOS.png") : "dummy"

                    function findClientIndex() {
                        for (let i = 0; i < getClients.clients.length; ++i) {
                            if (modelData.id === getClients.clients[i].workspace.id)
                                return i;
                        }
                        return -1;
                    }
                }
            }
        }
    }
}
