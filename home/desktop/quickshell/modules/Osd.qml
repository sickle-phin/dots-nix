import QtQuick
import QtQuick.Layouts
import Quickshell
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
            root.shouldShowOsd = true;
            hideTimer.restart();
        }

        function onMutedChanged() {
            root.shouldShowOsd = true;
            hideTimer.restart();
        }
    }

    property bool shouldShowOsd: false

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
                    text: Math.round(Pipewire.defaultAudioSink?.audio.volume * 100)
                    color: Theme.volume
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

                        implicitHeight: parent.height * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
                        radius: parent.radius
                        color: Theme.volume

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
                    source: if (Pipewire.defaultAudioSink?.audio.muted) {
                        Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-mute.png");
                    } else if (0.54 < Pipewire.defaultAudioSink?.audio.volume) {
                        Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-high.png");
                    } else if (0.29 < Pipewire.defaultAudioSink?.audio.volume) {
                        Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-mid.png");
                    } else {
                        Quickshell.iconPath(Quickshell.shellRoot + "/icons/volume-low.png");
                    }
                }
            }
        }
    }
}
