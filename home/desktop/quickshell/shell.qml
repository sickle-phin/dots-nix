//@ pragma UseQApplication
//@ pragma Env QT_SCALE_FACTOR=1

import Quickshell
import "modules"
import "modules/bar"

ShellRoot {
    Bar {}
    LazyLoader {
        active: States.notificationOpen
        component: NotificationPop {}
    }
    LazyLoader {
        active: States.notificationCenterOpen
        component: NotificationCenter {}
    }
    Osd {}
    LazyLoader {
        active: States.powerPanelOpen
        component: PowerPanel {}
    }
    LazyLoader {
        active: States.wallpaperOpen
        component: Wallpaper {}
    }
}
