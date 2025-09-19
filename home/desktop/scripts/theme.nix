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
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
    else
        ~/.config/specialisation/dark/activate
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 
    fi
  '';

  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-dark'" ]]; then
        ~/.config/specialisation/light/activate
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'" 
    else
        ~/.config/specialisation/dark/activate
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'" 
    fi
    pgrep -x btop >/dev/null && pkill -USR2 btop
    pgrep -x cava >/dev/null && pkill -USR2 cava
    systemctl --user restart hyprpolkitagent
  '';
in
{
  home.packages = [
    set-theme
    toggle-theme
  ];
}
