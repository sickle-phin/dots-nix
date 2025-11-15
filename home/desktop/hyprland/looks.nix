{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkDefault;
in
{
  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 4;
      gaps_out = "9,8,9,8";
      border_size = 0;
      "col.active_border" = mkDefault "rgba(585b70ff)";
      "col.inactive_border" = "rgba(585b70ff)";

      resize_on_border = true;
      extend_border_grab_area = 30;

      layout = "dwindle";

      allow_tearing = false;

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
        "realsmooth, 0.28, 0.29, 0.69, 1.08"
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
        "hyprfocusIn, 1, 1.7, realsmooth"
        "hyprfocusOut, 1, 1.7, realsmooth"
      ];
    };
  };

  specialisation = {
    dark.configuration.wayland.windowManager.hyprland.settings = {
      source = [
        "${pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/hyprland/refs/heads/main/themes/mocha.conf";
          sha256 = "sha256-SxVNvZZjfuPA2yB9xA0EHHEnE9eIQJAFVBIUuDiSIxQ=";
        }}"
      ];
      general."col.active_border" = "\$${osConfig.myOptions.catppuccin.accent.dark}";
    };
    light.configuration.wayland.windowManager.hyprland.settings = {
      source = [
        "${pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/hyprland/refs/heads/main/themes/latte.conf";
          sha256 = "sha256-xYhmqYTHF+nlJVIlNDY4Fyd6moEv6Z8YISTKmpX/p6k=";
        }}"
      ];
      general."col.active_border" = "\$${osConfig.myOptions.catppuccin.accent.light}";
    };
  };
}
