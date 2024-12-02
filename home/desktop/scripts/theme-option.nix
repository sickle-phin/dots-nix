{ pkgs, ... }:
let
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    THEMES[0]="Catppuccin Latte"
    THEMES[1]="Catppuccin Mocha"
    THEMES[2]="Dracula"

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

    main() {
        pick=$(config_menu | rofi -dmenu -p "  Themes ")

        if [[ -z $pick ]]; then
            exit 0
        fi

        if [[ $pick = "''${THEMES[0]}" ]]; then
            hyprctl setcursor "catppuccin-mocha-dark-cursors" 32
            echo "catppuccin-mocha-dark-cursors" > "$XDG_CACHE_HOME/hypr/cursor"
            hyprctl keyword general:col.active_border "rgba(ea76cbee)"
            echo "rgba(ea76cbee)" > "$XDG_CACHE_HOME/hypr/border"
            dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'" 
            dconf write /org/gnome/desktop/interface/cursor-size 32
            dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-dark-cursors'"
            dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-pink-standard+normal'"
            dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'"
            kvantummanager --set catppuccin-latte-pink
            set_xcursor "catppuccin-mocha-dark-cursors"
            pkill waybar && uwsm app -- waybar
        elif [[ $pick = "''${THEMES[1]}" ]]; then
            hyprctl setcursor "catppuccin-mocha-dark-cursors" 32
            echo "catppuccin-mocha-dark-cursors" > "$XDG_CACHE_HOME/hypr/cursor"
            hyprctl keyword general:col.active_border "rgba(f5c2e7ee)"
            echo "rgba(f5c2e7ee)" > "$XDG_CACHE_HOME/hypr/border"
            dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 
            dconf write /org/gnome/desktop/interface/cursor-size 32
            dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-dark-cursors'"
            dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-mocha-pink-standard+normal'"
            dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'"
            kvantummanager --set catppuccin-mocha-pink
            set_xcursor "catppuccin-mocha-dark-cursors"
            pkill waybar && uwsm app -- waybar
        elif [[ $pick = "''${THEMES[2]}" ]]; then
            hyprctl setcursor "Dracula-cursors" 32
            echo "Dracula-cursors" > "$XDG_CACHE_HOME/hypr/cursor"
            hyprctl keyword general:col.active_border "rgba(bd93f9ee)"
            echo "rgba(bd93f9ee)" > "$XDG_CACHE_HOME/hypr/border"
            dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 
            dconf write /org/gnome/desktop/interface/cursor-size 32
            dconf write /org/gnome/desktop/interface/cursor-theme "'Dracula-cursors'"
            dconf write /org/gnome/desktop/interface/gtk-theme "'Dracula'"
            dconf write /org/gnome/desktop/interface/icon-theme "'Dracula'"
            kvantummanager --set Dracula-purple
            set_xcursor "Dracula-cursors"
            pkill waybar && uwsm app -- waybar
        fi
        systemctl --user restart hyprpolkitagent
    }

    main
  '';
in
{
  home.packages = [ set-theme ];
}
