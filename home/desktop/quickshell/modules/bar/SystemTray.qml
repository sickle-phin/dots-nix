import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets

ListView {
    id: listview
    required property int barWidth
    Layout.fillHeight: true
    Layout.preferredWidth: contentWidth + 5
    orientation: Qt.Horizontal
    interactive: false
    spacing: 1
    model: SystemTray.items
    delegate: Row {
        IconImage {
            id: image
            visible: (modelData.id === "Fcitx") || (modelData.id === "chrome_status_icon_1")
            implicitWidth: 25
            implicitHeight: 40
            source: if (modelData.icon === "image://icon/input-keyboard-symbolic") {
                Quickshell.iconPath("fcitx-mozc-direct");
            } else if (modelData.id === "Fcitx") {
                modelData.icon.replace(/_/g, "-");
            } else {
                modelData.icon;
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
                onClicked: function (mouse) {
                    if (mouse.button === Qt.LeftButton) {
                        modelData.activate();
                    } else if (mouse.button === Qt.MiddleButton) {
                        modelData.secondaryActivate();
                    } else {
                        console.log(modelData.icon);
                        modelData.display(pop, barWidth - parent.height * 3, parent.height);
                    }
                }
            }
        }
    }
    PopupWindow {
        id: pop
    }
}
