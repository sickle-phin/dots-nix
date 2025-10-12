import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import "../.."
import "../config"

Scope {
    id: bar

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: barRoot
            WlrLayershell.namespace: "qs-bar"
            WlrLayershell.layer: WlrLayer.Bottom
            property var modelData
            screen: modelData
            color: "transparent"
            anchors {
                top: true
                right: true
                left: true
            }
            margins {
                top: Config.margin
                right: Config.margin
                left: Config.margin
            }
            implicitHeight: 40
            BarContent {
                barWidth: barRoot.width
                screenName: barRoot.screen.name
            }
        }
    }

    IpcHandler {
        target: "bar"

        function setDark(): void {
            States.dark = true;
        }
        function setLight(): void {
            States.dark = false;
        }
        function togglePowerPanel(): void {
            States.powerPanelOpen = !States.powerPanelOpen;
        }
        function toggleWallpaper(): void {
            States.wallpaperOpen = !States.wallpaperOpen;
        }
    }

    Process {
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                if (this.text === "'prefer-light'\n") {
                    States.dark = false;
                } else {
                    States.dark = true;
                }
            }
        }
        command: ["dconf", "read", "/org/gnome/desktop/interface/color-scheme"]
    }
}
