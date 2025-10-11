import QtQuick
import QtQuick.Layouts
import "../config"
import "../.."
import "../../services"

Item {
    Layout.fillHeight: true
    Layout.preferredWidth: height * 2.1
    Text {
        anchors.centerIn: parent
        text: Qt.formatDateTime(SystemClock.clock.date, "yyyy/M/d\nh:mm")
        font.family: "Mona Sans"
        font.pointSize: 11
        lineHeight: 0.7
        color: States.dark ? Dark.text : Light.text
    }
}
