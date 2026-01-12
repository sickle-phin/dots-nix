{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
  inherit (lib.meta) getExe';
  hyprctl = "${getExe' config.wayland.windowManager.hyprland.package "hyprctl"}";

  init-theme = pkgs.writeShellScriptBin "init-theme" ''
    theme=$(${getExe pkgs.dconf} read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'default'" ]]; then
        ${hyprctl} setcursor "catppuccin-latte-light-cursors" 37
        ~/.config/specialisation/light/activate
    else
        ${hyprctl} setcursor "catppuccin-mocha-dark-cursors" 37
        ~/.config/specialisation/dark/activate
    fi
  '';

  mode-changed-hook = pkgs.writeShellScriptBin "mode-changed-hook" ''
    theme="$2"
    if [[ $theme = "light" ]]; then
        ${hyprctl} setcursor "catppuccin-latte-light-cursors" 37
        ${getExe pkgs.dconf} write /org/gnome/desktop/interface/cursor-theme "'catppuccin-latte-light-cursors'"
        ${getExe pkgs.dconf} write /org/gnome/desktop/interface/icon-theme "'Papirus-Light'"
        ${getExe pkgs.pywalfox-native} light
        ~/.config/specialisation/light/activate
    else
        ${hyprctl} setcursor "catppuccin-mocha-dark-cursors" 37
        ${getExe pkgs.dconf} write /org/gnome/desktop/interface/cursor-theme "'catppuccin-mocha-dark-cursors'"
        ${getExe pkgs.dconf} write /org/gnome/desktop/interface/icon-theme "'Papirus-Dark'"
        ${getExe pkgs.pywalfox-native} dark
        ~/.config/specialisation/dark/activate
    fi
  '';
in
{
  home.packages = [
    init-theme
    mode-changed-hook
  ];
}
