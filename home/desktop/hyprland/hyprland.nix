{ pkgs
, inputs
, ...
}: {
    
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      inputs.hyprfocus.packages.x86_64-linux.hyprfocus
    ];
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      env = [
        "GTK_BACKEND,wayland"
        "GTK_IM_MODULE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
      ];
      exec-once = [
        "hyprpaper"
        "dbus-launch fcitx5"
        "waybar"
      ];
      input = {
        kb_layout = "us";
        follow_mouse = 1;

        touchpad = {
          natural_scroll = "no";
          scroll_factor = 0.2;
        };

        sensitivity = 0;
        repeat_delay = 250;
        repeat_rate = 60;
      };
      general = {
        gaps_in = 10;
        gaps_out = 25;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = true;

        layout = "dwindle";
      };

      dwindle = {
        force_split = 2;
      };

      decoration = {
        rounding = 10;

        blur = {
          enabled = true;
          size = 7;
          passes = 2;
          ignore_opacity = true;
        };

        drop_shadow = true;
        shadow_range = 7;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        dim_inactive = false;
        dim_strength = 0.35;
      };
      animations = {
        enabled = "yes";

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 5, myBezier, slide"
          "windowsOut, 1, 16, default, slide"
          "border, 1, 15, default"
          "borderangle, 1, 8, default"
          "fade, 1, 3, default"
          "workspaces, 1, 6, default"
        ];
      };

      gestures = {
        workspace_swipe = "on";
      };
      # "device:epic-mouse-v1" = {
      #   sensitivity = -0.5;
      # };

      misc = {
        disable_hyprland_logo = true;
        force_default_wallpaper = 0;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      plugin = {
        hyprfocus = {
          enabled = true;

          keyboard_focus_animation = "flash";

          bezier = [
            "bezIn, 0.5,0.0,1.0,0.5"
            "bezOut, 0.0,0.5,0.5,1.0"
          ];

          shrink = {
            shrink_percentage = 0.99;

            in_bezier = "bezIn";
            in_speed = 1;

            out_bezier = "bezOut";
            out_speed = 3;
          };
          flash = {
            flash_opacity = 0.87;

            in_bezier = "bezIn";
            in_speed = 0.000001;

            out_bezier = "bezOut";
            out_speed = 3;
          };
        };
      };
      windowrule = [
        "opacity 0.90, [\\s\\S]"
        "noblur, [\\s\\S]"
        "opacity 1.0, Alacritty"
        "opacity 1.0, dev.warp.Warp"
        "opacity 1.0, org.wezfurlong.wezterm"
        "size 55% 55%, neovide"
        "opacity 1.0, neovide"
        "opacity 0.98, firefox"
        "opacity 0.97, google-chrome"
        "opacity 0.95, Vivaldi-stable"
        "float, pavucontrol"
        "animation popin, pavucontrol"
        "animation popin, wofi"
        "float, ^(org.kde.polkit-kde-authentication-agent-1)$"
        "animation popin, ^(org.kde.polkit-kde-authentication-agent-1)$"
        "opacity 1.0, steam_app_2586520"
      ];
      windowrulev2 = "noborder,onworkspace:1";

      layerrule = "blur, waybar";

      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, wezterm"
        "$mod, B, exec, LANG=ja_JP.UTF-8 google-chrome-stable"
        "$mod, C, exec, hyprpicker | wl-copy"
        "SUPER_SHIFT, E, exec, wlogout"
        "$mod, D, exec, wofi --show drun"
        "$mod, F, togglefloating"
        "SUPER_SHIFT, F, fullscreen, 0"
        "$mod, S, exec, hyprshot -m output"
        "SUPER_SHIFT, S, exec, hyprshot -m region"
        "$mod, P, pseudo"
        "$mod, V, togglesplit"
        "$mod, Q, killactive"
        "SUPER_SHIFT, Q, exec, hyprctl kill"
        "$mod, F2, exec, bash ~/.config/hypr/scripts/volume.sh --toggle"
        "$mod, F3, exec, bash ~/.config/hypr/scripts/volume.sh --dec"
        "$mod, F4, exec, bash ~/.config/hypr/scripts/volume.sh --inc"
        "$mod, F5, exec, bash ~/.config/hypr/scripts/backlight.sh --dec"
        "$mod, F6, exec, bash ~/.config/hypr/scripts/backlight.sh --inc"
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList
          (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10)
      );
      bindm = [
        "$mod, mouse:273, resizewindow"
        "$mod, mouse:272, movewindow"
      ];
    };
  };
}
