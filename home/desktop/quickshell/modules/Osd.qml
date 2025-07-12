import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import Quickshell.Widgets
import "../config"

Scope {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink]
    }

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.shouldShowAudio = true;
            root.shouldShowOsd = true;
            hideTimer.restart();
        }

        function onMutedChanged() {
            root.shouldShowAudio = true;
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    property string backlight

    Process {
        command: ["ls", "-1", "/sys/class/backlight"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.backlight = this.text.split("\n")[0];
            }
        }
    }

    FileView {
        id: maxBrightnessFile
        path: Qt.resolvedUrl("/sys/class/backlight/" + root.backlight + "/max_brightness")
        blockLoading: true
    }

    FileView {
        id: brightnessFile
        path: Qt.resolvedUrl("/sys/class/backlight/" + root.backlight + "/brightness")
        blockLoading: true
        watchChanges: true
        onFileChanged: {
            this.reload();
            root.shouldShowAudio = false;
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    readonly property string maxBrightness: maxBrightnessFile.text()
    property string brightness: brightnessFile.text()

    property bool shouldShowOsd: false
    property bool shouldShowAudio: true

    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: root.shouldShowOsd = false
    }

    LazyLoader {
        active: root.shouldShowOsd

        PanelWindow {
            WlrLayershell.namespace: "qs-osd"
            WlrLayershell.layer: WlrLayer.Overlay
            exclusionMode: "Ignore"

            anchors.right: true
            margins.right: screen.width / 200

            implicitWidth: 70
            implicitHeight: 400
            color: "transparent"

            mask: Region {}

            Rectangle {
                anchors.fill: parent
                radius: height / 2
                color: Theme.background
                opacity: 0.85
            }

            ColumnLayout {
                anchors {
                    fill: parent
                    topMargin: 15
                    bottomMargin: 15
                }

                Text {
                    Layout.alignment: Qt.AlignHCenter
                    text: if (root.shouldShowAudio) {
                        Math.round(Pipewire.defaultAudioSink?.audio.volume * 100);
                    } else {
                        text: Math.round(root.brightness / root.maxBrightness * 100);
                    }
                    color: if (root.shouldShowAudio) {
                        Theme.audio;
                    } else {
                        Theme.brightness;
                    }
                    font.family: "Mona Sans"
                    font.pixelSize: 20
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter
                    implicitWidth: 15
                    radius: 20
                    color: Theme.hover

                    Rectangle {
                        anchors {
                            right: parent.right
                            left: parent.left
                            bottom: parent.bottom
                        }

                        implicitHeight: if (root.shouldShowAudio) {
                            parent.height * (Pipewire.defaultAudioSink?.audio.volume ?? 0);
                        } else {
                            parent.height * (root.brightness / root.maxBrightness ?? 0);
                        }
                        radius: parent.radius
                        color: if (root.shouldShowAudio) {
                            Theme.audio;
                        } else {
                            Theme.brightness;
                        }

                        Behavior on implicitHeight {
                            NumberAnimation {
                                duration: 100
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }

                IconImage {
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 5
                    implicitSize: 30
                    source: if (root.shouldShowAudio) {
                        if (Pipewire.defaultAudioSink?.audio.muted) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-mute.png");
                        } else if (0.54 < Pipewire.defaultAudioSink?.audio.volume) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-high.png");
                        } else if (0.29 < Pipewire.defaultAudioSink?.audio.volume) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-mid.png");
                        } else {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-low.png");
                        }
                    } else {
                        if (0.8 <= brightness / maxBrightness) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/brightness-100");
                        } else if (0.6 <= brightness / maxBrightness) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/brightness-80");
                        } else if (0.4 <= brightness / maxBrightness) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/brightness-60");
                        } else if (0.2 <= brightness / maxBrightness) {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/brightness-40");
                        } else {
                            Quickshell.iconPath(Quickshell.shellRoot + "/icons/brightness-20");
                        }
                    }
                }
            }
        }
    }
}
