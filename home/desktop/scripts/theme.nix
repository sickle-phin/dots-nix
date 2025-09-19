{
  pkgs,
  ...
}:
let
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-light'" ]]; then
        ~/.config/specialisation/light/activate
        hyprctl setcursor "catppuccin-latte-light-cursors" 39
    else
        ~/.config/specialisation/dark/activate
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 39
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 
    fi
  '';

  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-dark'" ]]; then
        ~/.config/specialisation/light/activate
        hyprctl setcursor "catppuccin-latte-light-cursors" 39
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'" 
    else
        ~/.config/specialisation/dark/activate
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 39
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 
    fi
  '';
in
{
  home.packages = [
    set-theme
    toggle-theme
  ];
}
