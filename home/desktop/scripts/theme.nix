{
  osConfig,
  pkgs,
  ...
}:
let
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-light'" ]]; then
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}-standard+normal'";
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        ~/.config/specialisation/light/activate
    else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}-standard+normal'";
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        ~/.config/specialisation/dark/activate
    fi
    systemctl restart --user hyprpolkitagent.service
  '';

  toggle-theme = pkgs.writeShellScriptBin "toggle-theme" ''
    #!/usr/bin/env bash

    theme=$(dconf read /org/gnome/desktop/interface/color-scheme)
    if [[ $theme = "'prefer-dark'" ]]; then
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-light'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-latte-${osConfig.myOptions.catppuccin.accent.light}-standard+normal'";
        hyprctl setcursor "catppuccin-latte-light-cursors" 37
        ~/.config/specialisation/light/activate
    else
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-dark'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'catppuccin-mocha-${osConfig.myOptions.catppuccin.accent.dark}-standard+normal'";
        hyprctl setcursor "catppuccin-mocha-dark-cursors" 37
        ~/.config/specialisation/dark/activate
    fi
    pgrep -x btop >/dev/null && pkill -USR2 btop
    pgrep -x cava >/dev/null && pkill -USR2 cava
    systemctl restart --user hyprpolkitagent.service
  '';
in
{
  home.packages = [
    set-theme
    toggle-theme
  ];
}
