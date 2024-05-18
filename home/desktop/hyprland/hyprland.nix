{ pkgs
, inputs
, ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      env = [
        "NIXOS_OZONE_WL, 1"
        "XMODIFIERS, @im=fcitx"
        "GTK_IM_MODULE,"
        "QT_IM_MODULE, fcitx"
        "XCURSOR_SIZE, 24"
        "GDK_BACKEND, wayland,x11"
        "QT_QPA_PLATFORM, wayland;xcb"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "MOZ_ENABLE_WAYLAND = 1"
        "SWWW_TRANSITION,center"
        "SWWW_TRANSITION_FPS,60"
        "SWWW_TRANSITION_STEP,70"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];
      exec-once = [
        "pidof hypridle || hypridle"
        "swww query || swww init"
        "fcitx5 -d --replace"
        "pidof waybar || waybar"
      ];
      input = {
        kb_layout = "us,jp";
        kb_options = "grp:alt_shift_toggle";
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
        border_size = 0;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959dd)";

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
          size = 6;
          passes = 1;
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
        initial_workspace_tracking = 0;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      plugin = {
        hyprfocus = {
          enabled = true;
          animate_floating = true;
          animate_workspacechange = true;
          focus_animation = "flash";
          bezier = [
            "realsmooth, 0.28,0.29,.69,1.08"
          ];

          flash = {
            flash_opacity = 0.95;
            in_bezier = "realsmooth";
            in_speed = 0.5;
            out_bezier = "realsmooth";
            out_speed = 3;
          };
        };
      };
      windowrule = [
        "center, [\\s\\S]"
        "opacity 0.9, pavucontrol|wofi"
        "animation popin, imv|pavucontrol|wofi"
        "bordersize 2, imv|pavucontrol|wofi"
        "size 55% 55%, neovide"
        "float, imv|pavucontrol"
        "size 700 500, pavucontrol"
        "float, polkit-gnome-authentication-agent-1"
        "animation popin, polkit-gnome-authentication-agent-1"
        "opacity 0.9, polkit-gnome-authentication-agent-1"
        "opacity 1.0, steam_app_2586520"
      ];
      # windowrulev2 = "bordercolor rgba(595959dd), onworkspace:1";

      "$mod" = "SUPER";
      bind = [
        "$mod, RETURN, exec, wezterm"
        "$mod, B, exec, LANG=ja_JP.UTF-8 google-chrome-stable"
        "$mod, C, exec, pidof hyprpicker || hyprpicker | wl-copy"
        "SUPER_SHIFT, E, exec, pidof wlogout || wlogout -b 6 -T 400 -B 400"
        "$mod, D, exec, pidof wofi || wofi --show drun"
        "$mod, F, togglefloating"
        "SUPER_SHIFT, F, fullscreen, 0"
        "$mod, S, exec, hyprshot -m output"
        "SUPER_SHIFT, S, exec, hyprshot -m region"
        "$mod, P, pseudo"
        "$mod, V, togglesplit"
        "$mod, Q, killactive"
        "SUPER_SHIFT, Q, exec, hyprctl kill"
        "$mod, W, exec, pidof wofi || bash ~/.config/hypr/scripts/wallpaper.sh"
        "$mod, F2, exec, bash ~/.config/hypr/scripts/volume.sh --toggle"
        "$mod, F3, exec, bash ~/.config/hypr/scripts/volume.sh --dec"
        "$mod, F4, exec, bash ~/.config/hypr/scripts/volume.sh --inc"
        "$mod, F5, exec, bash ~/.config/hypr/scripts/backlight.sh --dec"
        "$mod, F6, exec, bash ~/.config/hypr/scripts/backlight.sh --inc"
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "SUPER_SHIFT, H, movewindow, l"
        "SUPER_SHIFT, L, movewindow, r"
        "SUPER_SHIFT, K, movewindow, u"
        "SUPER_SHIFT, J, movewindow, d"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
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
