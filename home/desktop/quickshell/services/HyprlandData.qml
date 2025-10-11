pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io

Singleton {
    property list<var> clients: []

    property var getClients: Process {
        id: getClients
        running: true
        command: ["hyprctl", "-j", "clients"]
        stdout: StdioCollector {
            onStreamFinished: {
                clients = JSON.parse(this.text);
            }
        }
    }

    Connections {
        target: Hyprland
        onRawEvent: {
            if (event.name === "openwindow" || event.name === "closewindow" || event.name === "movewindow") {
                getClients.running = true;
            }
        }
    }
}
