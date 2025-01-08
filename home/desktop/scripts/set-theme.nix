{
  inputs,
  pkgs,
  ...
}:
let
  catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "zsh-syntax-highlighting";
    rev = "7926c3d3e17d26b3779851a2255b95ee650bd928";
    sha256 = "sha256-l6tztApzYpQ2/CiKuLBf8vI2imM6vPJuFdNDSEi7T/o=";
  };
  dracula = pkgs.fetchFromGitHub {
    owner = "dracula";
    repo = "zsh-syntax-highlighting";
    rev = "09c89b657ad8a27ddfe1d6f2162e99e5cce0d5b3";
    sha256 = "sha256-JrSKx8qHGAF0DnSJiuKWvn6ItQHvWpJ5pKo4yNbrHno=";
  };
  set-theme = pkgs.writeShellScriptBin "set-theme" ''
    #!/usr/bin/env bash

    THEMES[0]="Catppuccin Latte"
    THEMES[1]="Catppuccin Mocha"
    THEMES[2]="Dracula"
    THEMES[3]="Everforest"
    THEMES[4]="Gruvbox Dark"
    THEMES[5]="Gruvbox Light"
    THEMES[6]="Nord"

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
        XCURSOR_SIZE="$5"
        HYPRCURSOR_SIZE="$6"
        ICON_THEME="$7"
        BORDER_COLOR="$8"
        POLARITY="$9"
        PANEL_THEME="''${10}"
        WEZTERM_THEME="''${11}"
        BAT_THEME="''${12}"
        BTOP_THEME="''${13}"

        jq -s add "${inputs.hyprpanel}/themes/''${PANEL_THEME}_split.json" "$XDG_CONFIG_HOME/hyprpanel/template.json" > "$XDG_CONFIG_HOME/hyprpanel/config.json" && hyprpanel restart
        hyprctl setcursor "$CURSOR_THEME" "$HYPRCURSOR_SIZE"
        echo "\$border_color = rgba($BORDER_COLOR)" > "$XDG_CACHE_HOME/theme/border.conf"
        echo "return \"$WEZTERM_THEME\"" > "$XDG_CONFIG_HOME/wezterm/current_theme.lua"
        dconf write /org/gnome/desktop/interface/cursor-size $XCURSOR_SIZE
        dconf write /org/gnome/desktop/interface/cursor-theme "'$CURSOR_THEME'"
        dconf write /org/gnome/desktop/interface/gtk-theme "'$GTK_THEME'"
        dconf write /org/gnome/desktop/interface/icon-theme "'$ICON_THEME'"
        dconf write /org/gnome/desktop/interface/color-scheme "'prefer-$POLARITY'" 
        kvantummanager --set "$QT_THEME"
        set_xcursor "$CURSOR_THEME"
        echo "$CURSOR_THEME" > "$XDG_CACHE_HOME/theme/cursor_theme"
        echo "$XCURSOR_SIZE" > "$XDG_CACHE_HOME/theme/xcursor_size"
        echo "$HYPRCURSOR_SIZE" > "$XDG_CACHE_HOME/theme/hyprcursor_size"
        cp "$XDG_CONFIG_HOME/fuzzel/''${THEMES[$INDEX]}.ini" "$XDG_CACHE_HOME/theme/fuzzel.ini" -f
        systemctl --user restart hyprpolkitagent
        hyprctl reload
        echo "--theme='$BAT_THEME'" > "$XDG_CONFIG_HOME/bat/config"
        printf "color_theme = \"%s.theme\"\ntheme_background = False\nvim_keys = True" "$BTOP_THEME" > "$XDG_CONFIG_HOME/btop/btop.conf"

    }

    main() {
        pick=$(config_menu | fuzzel -d)

        if [[ -z $pick ]]; then
            exit 0
        fi

        [ ! -d "$XDG_CACHE_HOME/theme" ] && mkdir -p "$XDG_CACHE_HOME/theme"
        if [[ $pick = "''${THEMES[0]}" ]]; then
            set_theme 0 "catppuccin-latte-pink-standard+normal" "catppuccin-latte-pink" "catppuccin-latte-light-cursors" 32 40 "Papirus-Light" "ea76cbff" "light" "catppuccin_latte" "catppuccin-latte" "Catppuccin Latte" "catppuccin_latte"
            cp "${catppuccin}/themes/catppuccin_latte-zsh-syntax-highlighting.zsh" "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh" -f
        elif [[ $pick = "''${THEMES[1]}" ]]; then
            set_theme 1 "catppuccin-mocha-pink-standard+normal" "catppuccin-mocha-pink" "catppuccin-mocha-dark-cursors" 32 40 "Papirus-Dark" "f5c2e7ff" "dark" "catppuccin_mocha" "catppuccin-mocha" "Catppuccin Mocha" "catppuccin_mocha"
            cp "${catppuccin}/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh" "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh" -f
        elif [[ $pick = "''${THEMES[2]}" ]]; then
            set_theme 2 "Dracula" "Dracula-purple" "Dracula-cursors" 31 31 "Dracula" "bd93f9ff" "dark" "dracula" "Dracula (Official)" "Dracula" "dracula"
            cp "${dracula}/zsh-syntax-highlighting.sh" "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh" -f
        elif [[ $pick = "''${THEMES[3]}" ]]; then
            set_theme 3 "Everforest-Dark-B" "catppuccin-mocha-green" "catppuccin-mocha-dark-cursors" 32 40 "Papirus-Dark" "a7c080ff" "dark" "everforest" "Everforest Dark Hard (Gogh)" "base16" "everforest-dark-hard"
            rm "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh"
        elif [[ $pick = "''${THEMES[4]}" ]]; then
            set_theme 4 "Gruvbox-Dark" "Gruvbox-Dark-Blue" "Capitaine Cursors (Gruvbox)" 37 37 "Papirus-Dark" "458588ff" "dark" "gruvbox" "GruvboxDarkHard" "gruvbox-dark" "gruvbox_dark"
            rm "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh"
        elif [[ $pick = "''${THEMES[5]}" ]]; then
            set_theme 5 "Gruvbox-Light" "Gruvbox_Light_Blue" "Capitaine Cursors (Gruvbox) - White" 37 37 "Papirus-Light" "076678ff" "light" "gruvbox" "GruvboxLight" "gruvbox-light" "gruvbox_light"
            rm "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh"
        elif [[ $pick = "''${THEMES[6]}" ]]; then
            set_theme 6 "Nordic" "Nordic" "Nordic-cursors" 31 31 "Nordic-green" "8fbcbbff" "dark" "nord" "nord" "Nord" "nord"
            rm "$XDG_CACHE_HOME/theme/zsh-syntax-highlighting.zsh"
        fi
    }

    main
  '';
in
{
  home.packages = [ set-theme ];
}
