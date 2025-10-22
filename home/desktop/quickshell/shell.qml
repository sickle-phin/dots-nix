//@ pragma UseQApplication
//@ pragma Env QT_SCALE_FACTOR=1

import Quickshell
import "modules"
import "modules/bar"

ShellRoot {
    Bar {}
    Notification {}
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
