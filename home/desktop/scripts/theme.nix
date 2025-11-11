{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;

  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-light'" ]]; then
        # dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}-standard+normal'";
        dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3'";
        dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-latte-light-cursors'";
        dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'";
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        ~/.config/specialisation/light/activate
    else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        # dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}-standard+normal'";
        dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3'";
        dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-dark-cursors'";
        dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'";
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        ~/.config/specialisation/dark/activate
    fi
    systemctl restart --user quickshell.service
    systemctl restart --user hyprpolkitagent.service
  '';

  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-dark'" ]]; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}-standard+normal'";
        dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-latte-light-cursors'";
        dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'";
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        ${getExe pkgs.quickshell} ipc call bar setLight
        ~/.config/specialisation/light/activate
    else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}-standard+normal'";
        dconf write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-dark-cursors'";
        dconf write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'";
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        ${getExe pkgs.quickshell} ipc call bar setDark 
        ~/.config/specialisation/dark/activate
    fi
    pgrep -x btop >/dev/null && pkill -USR2 btop
    pgrep -x cava >/dev/null && pkill -USR2 cava
    systemctl restart --user quickshell.service
    systemctl restart --user hyprpolkitagent.service
  '';
in
{
  home.packages = [
    set-theme
    toggle-theme
  ];
}
