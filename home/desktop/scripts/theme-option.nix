{ pkgs, ... }:
let
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    THEMES[0]="Catppuccin Latte"
    THEMES[1]="Catppuccin Mocha"
    THEMES[2]="Dracula"
    THEMES[3]="Gruvbox Dark"
    THEMES[4]="Gruvbox Light"

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
        GTK_THEME="$1"
        QT_THEME="$2"
        CURSOR_THEME="$3"
        CURSOR_SIZE="$4"
        ICON_THEME="$5"
        BORDER_COLOR="$6"
        POLARITY="$7"
        hyprctl setcursor "$CURSOR_THEME" "$CURSOR_SIZE"
        echo "$CURSOR_THEME" > "$XDG_CACHE_HOME/hypr/cursor_theme"
        echo "$CURSOR_SIZE" > "$XDG_CACHE_HOME/hypr/cursor_size"
        hyprctl keyword general:col.active_border "rgba($BORDER_COLOR)"
        echo "rgba($BORDER_COLOR)" > "$XDG_CACHE_HOME/hypr/border"
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-$POLARITY'" 
        dconf write /org/gnome/desktop/interface/cursor-size $CURSOR_SIZE
        dconf write /org/gnome/desktop/interface/cursor-theme "'$CURSOR_THEME'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'$GTK_THEME'"
        dconf write /org/gnome/desktop/interface/icon-theme "'$ICON_THEME'"
        kvantummanager --set "$QT_THEME"
        set_xcursor "$CURSOR_THEME"
        pkill waybar && uwsm app -- waybar
    }

    main() {
        pick=$(config_menu | rofi -dmenu -p "  Themes ")

        if [[ -z $pick ]]; then
            exit 0
        fi

        if [[ $pick = "''${THEMES[0]}" ]]; then
            set_theme "catppuccin-latte-pink-standard+normal" "catppuccin-latte-pink" "catppuccin-latte-light-cursors" 32 "Papirus-Light" "ea76cbee" "light"
        elif [[ $pick = "''${THEMES[1]}" ]]; then
            set_theme "catppuccin-mocha-pink-standard+normal" "catppuccin-mocha-pink" "catppuccin-mocha-dark-cursors" 32 "Papirus-Dark" "f5c2e7ee" "dark"
        elif [[ $pick = "''${THEMES[2]}" ]]; then
            set_theme "Dracula" "Dracula-purple" "Dracula-cursors" 31 "Dracula" "bd93f9ee" "dark"
        elif [[ $pick = "''${THEMES[3]}" ]]; then
            set_theme "Gruvbox-Dark" "Gruvbox-Dark-Blue" "Capitaine Cursors (Gruvbox)" 37 "Papirus-Dark" "458588ee" "dark"
        elif [[ $pick = "''${THEMES[4]}" ]]; then
            set_theme "Gruvbox-Light" "Gruvbox_Light_Blue" "Capitaine Cursors (Gruvbox) - White" 37 "Papirus-Light" "076678ee" "light"
        fi
        systemctl --user restart hyprpolkitagent
    }

    main
  '';
in
{
  home.packages = [ set-theme ];
}
