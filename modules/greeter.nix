{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.strings) concatMapStringsSep;
in
{
  imports = [
    inputs.dank-material-shell.nixosModules.greeter
  ];

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        env = DMS_RUN_GREETER,1
        env = HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors
        env = HYPRCURSOR_SIZE,37
        env = QT_SCALE_FACTOR,1.2
        ${concatMapStringsSep "\n" (m: "monitor=" + m) config.myOptions.monitors}
        input {
          kb_layout=${config.myOptions.kbLayout}
          kb_options=ctrl:nocaps
        }
        misc {
          disable_hyprland_logo = true
          disable_splash_rendering = true
          force_default_wallpaper = 0
          vrr = 1
        }
        cursor {
          ${if (config.networking.hostName == "irukaha") then "min_refresh_rate = 48" else ""}
          ${if (!config.myOptions.isLaptop) then "default_monitor = DP-1" else ""}
        }
      '';
    };
    configHome = "/home/${username}";
  };

  environment.systemPackages = [ pkgs.catppuccin-cursors.mochaDark ];
}
