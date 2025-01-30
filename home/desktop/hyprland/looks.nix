{
  config,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    source = "${config.xdg.cacheHome}/theme/border.conf";

    general = {
      gaps_in = "7.5";
      gaps_out = 15;
      border_size = 3;
      "col.active_border" = "$border_color";
      "col.inactive_border" = "rgba(585b70ff)";

      resize_on_border = true;
      extend_border_grab_area = 30;

      layout = "dwindle";

      allow_tearing = true;

      snap.enabled = true;
    };

    decoration = {
      rounding = 10;
      rounding_power = 3;

      blur = {
        enabled = false;
        size = 6;
        passes = 1;
        ignore_opacity = true;
      };

      shadow = {
        enabled = true;
        range = 20;
        render_power = 3;
      };
    };

    animations = {
      enabled = "yes";
      bezier = [
        # "myBezier, 0.05, 0.9, 0.1, 1.05"
        "wind, 0.05, 0.9, 0.1, 1"
        "winIn, 0.1, 1, 0.1, 1"
        "winOut, 0.3, -0.3, 0, 1"
        "liner, 1, 1, 1, 1"
      ];
      animation = [
        "windows, 1, 5, wind, slide"
        "windowsIn, 1, 5, winIn, slide"
        "windowsOut, 1, 5, winOut, slide"
        "windowsMove, 1, 5, wind, slide"
        "border, 1, 1, liner"
        "borderangle, 1, 8, default"
        # "borderangle, 1, 30, liner, loop"
        "fade, 1, 3, default"
        "workspaces, 1, 5, wind"
      ];
    };
  };
}
