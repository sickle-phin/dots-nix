pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property int margin: 8
    readonly property var appNameMap: ({
            "mozc_tool": "mozc",
            "nm-connection-editor": "preferences-system-network",
            Slack: "slack",
            "Tor Browser": "tor-browser",
            Waydroid: "waydroid",
            ".blueman-manager-wrapped": "blueman-device",
            ".supertuxkart-wrapped": "supertuxkart",
            ".virt-manager-wrapped": "virt-manager"
        })
}
