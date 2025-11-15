{ pkgs, ... }:
let
  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash
    theme="$2"

    if [[ $theme = "light" ]]; then
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-latte-light-cursors'";
        dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'";
        ~/.config/specialisation/light/activate
    else
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-dark-cursors'";
        dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'";
        ~/.config/specialisation/dark/activate
    fi
    pgrep -x btop >/dev/null && pkill -USR2 btop
    pgrep -x cava >/dev/null && pkill -USR2 cava
    systemctl restart --user hyprpolkitagent.service
    systemctl restart --user xdg-desktop-portal-gtk.service
  '';
in
{
  home.packages = [
    toggle-theme
  ];
}
