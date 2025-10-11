import QtQuick
import QtQuick.Layouts
import "../.."
import "../config"

RowLayout {
    id: root
    required property int barWidth
    required property string screenName

    anchors.fill: parent
    RowLayout {
        id: leftSectionRowLayout
        Layout.alignment: Qt.AlignLeft
        spacing: 10
        Launcher {}
        Workspace {
            screenName: root.screenName
        }
    }
    Rectangle {
        Layout.alignment: Qt.AlignRight
        Layout.fillHeight: true
        Layout.preferredWidth: rightSectionRowLayout.implicitWidth + 10
        radius: 10
        color: States.dark ? Qt.rgba(Dark.base.r, Dark.base.g, Dark.base.b, 0.8) : Qt.rgba(Light.base.r, Light.base.g, Light.base.b, 0.8)
        RowLayout {
            id: rightSectionRowLayout
            Layout.fillHeight: true
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            spacing: 0
            Battery {}
            SystemTray {
                barWidth: root.barWidth
            }
            Clock {}
            PowerButton {}
        }
    }
}
