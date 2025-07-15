import Quickshell
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import "../config"

Rectangle {
    id: root
    property string screenName
    Layout.preferredHeight: parent.height
    Layout.preferredWidth: listview.contentWidth + 20
    opacity: 0.8
    color: Theme.background
    radius: 10
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

    ListView {
        id: listview
        anchors.fill: parent
        anchors.topMargin: 3
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 3
        // spacing: 35
        interactive: false
        orientation: Qt.Horizontal
        model: Hyprland.workspaces

        delegate: Row {
            RoundButton {
                id: rere
                height: listview.height
                visible: modelData.monitor.name === root.screenName
                property list<var> monitors: Hyprland.monitors
                implicitWidth: 35
                onClicked: {
                    Hyprland.dispatch("workspace " + modelData.id);
                    getClients.startDetached();
                }

                background: Rectangle {
                    radius: 15
                    color: Theme.text

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            parent.color = Theme.hover;
                        }
                        onExited: {
                            parent.color = Theme.text;
                        }
                    }
                }
                IconImage {
                    anchors.centerIn: rere
                    implicitSize: 22
                    function getIndex(): int {
                        for (let i in getClients.clients) {
                            if (modelData.id === getClients.clients[i].workspace.id) {
                                console.log();
                                return i;
                            }
                        }
                        return -1;
                    }
                    property int workspace: getworkspace()
                    property int i: getIndex()
                    readonly property var appNameMap: ({
                            ".virt-manager-wrapped": "virt-manager",
                            Slack: "slack"
                        })

                    property string appname: appNameMap[getClients.clients[i].class] || getClients.clients[i].class
                    source: i !== -1 ? Quickshell.iconPath(appname, Quickshell.shellRoot + "/icons/NixOS.png") : "dummy"
                }
            }
        }
    }
}
