pragma Singleton
import QtQuick
import Quickshell

Singleton {
    property var clock: SystemClock {
        precision: SystemClock.Seconds
    }
}
