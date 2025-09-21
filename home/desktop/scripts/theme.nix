{
  pkgs,
  ...
}:
let
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-light'" ]]; then
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        ~/.config/specialisation/light/activate
    else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        ~/.config/specialisation/dark/activate
    fi
    systemctl restart --user fcitx5-daemon.service
    systemctl restart --user hyprpolkitagent.service
  '';

  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-dark'" ]]; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        ~/.config/specialisation/light/activate
    else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        ~/.config/specialisation/dark/activate
    fi
    pgrep -x btop >/dev/null && pkill -USR2 btop
    pgrep -x cava >/dev/null && pkill -USR2 cava
    systemctl restart --user fcitx5-daemon.service
    systemctl restart --user hyprpolkitagent.service
  '';
in
{
  home.packages = [
    set-theme
    toggle-theme
  ];
}
