{ pkgs, ... }:
let
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    THEMES[0]="Adwaita Light"
    THEMES[1]="Adwaita Dark"
    THEMES[2]="Catppuccin Latte"
    THEMES[3]="Catppuccin Mocha"
    THEMES[4]="Dracula"
    THEMES[5]="Gruvbox Dark"
    THEMES[6]="Gruvbox Light"
    THEMES[7]="Nord"

    config_menu() {
        for i in "''${!THEMES[@]}"; do
            echo "''${THEMES[$i]}"
        done
    }

    set_xcursor() {
        CURSOR_THEME="$1"
        INDEX_THEME_FILE="[Icon Theme]\nInherits=$CURSOR_THEME"
        echo -e "$INDEX_THEME_FILE" > ~/.icons/default/index.theme
    }

    set_theme() {
        INDEX="$1"
        GTK_THEME="$2"
        QT_THEME="$3"
        CURSOR_THEME="$4"
        CURSOR_SIZE="$5"
        ICON_THEME="$6"
        BORDER_COLOR="$7"
        POLARITY="$8"
        hyprctl setcursor "$CURSOR_THEME" "$CURSOR_SIZE"
        echo "\$border_color = rgba($BORDER_COLOR)" > "$XDG_CACHE_HOME/theme/border.conf"
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-$POLARITY'" 
        dconf write /org/gnome/desktop/interface/cursor-size $CURSOR_SIZE
        dconf write /org/gnome/desktop/interface/cursor-theme "'$CURSOR_THEME'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'$GTK_THEME'"
        dconf write /org/gnome/desktop/interface/icon-theme "'$ICON_THEME'"
        kvantummanager --set "$QT_THEME"
        set_xcursor "$CURSOR_THEME"
        echo "$CURSOR_THEME" > "$XDG_CACHE_HOME/theme/cursor_theme"
        echo "$CURSOR_SIZE" > "$XDG_CACHE_HOME/theme/cursor_size"
        cp "$XDG_CONFIG_HOME/fuzzel/''${THEMES[$INDEX]}.ini" "$XDG_CACHE_HOME/theme/fuzzel.ini" -f
        systemctl --user restart hyprpolkitagent
        hyprctl reload
        pkill waybar && uwsm app -- waybar
    }

    main() {
        pick=$(config_menu | fuzzel -d)

        if [[ -z $pick ]]; then
            exit 0
        fi

        [ ! -d "$XDG_CACHE_HOME/theme" ] && mkdir -p "$XDG_CACHE_HOME/theme"
        if [[ $pick = "''${THEMES[0]}" ]]; then
            set_theme 0 "adw-gtk3" "KvGnome" "Adwaita" 29 "Papirus-Light" "3584E4ff" "light"
        elif [[ $pick = "''${THEMES[1]}" ]]; then
            set_theme 1 "adw-gtk3-dark" "KvGnomeDark" "Adwaita" 29 "Papirus-Dark" "3584E4ff" "dark"
        elif [[ $pick = "''${THEMES[2]}" ]]; then
            set_theme 2 "catppuccin-latte-pink-standard+normal" "catppuccin-latte-pink" "catppuccin-latte-light-cursors" 32 "Papirus-Light" "ea76cbff" "light"
        elif [[ $pick = "''${THEMES[3]}" ]]; then
            set_theme 3 "catppuccin-mocha-pink-standard+normal" "catppuccin-mocha-pink" "catppuccin-mocha-dark-cursors" 32 "Papirus-Dark" "f5c2e7ff" "dark"
        elif [[ $pick = "''${THEMES[4]}" ]]; then
            set_theme 4 "Dracula" "Dracula-purple" "Dracula-cursors" 31 "Dracula" "bd93f9ff" "dark"
        elif [[ $pick = "''${THEMES[5]}" ]]; then
            set_theme 5 "Gruvbox-Dark" "Gruvbox-Dark-Blue" "Capitaine Cursors (Gruvbox)" 37 "Papirus-Dark" "458588ff" "dark"
        elif [[ $pick = "''${THEMES[6]}" ]]; then
            set_theme 6 "Gruvbox-Light" "Gruvbox_Light_Blue" "Capitaine Cursors (Gruvbox) - White" 37 "Papirus-Light" "076678ff" "light"
        elif [[ $pick = "''${THEMES[7]}" ]]; then
            set_theme 7 "Nordic" "Nordic" "Nordic-cursors" 31 "Nordic-green" "8fbcbbff" "dark"
        fi
    }

    main
  '';
in
{
  home.packages = [ set-theme ];
}
