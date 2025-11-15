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
    inputs.dankMaterialShell.nixosModules.greeter
  ];

  programs.dankMaterialShell.greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        env = DMS_RUN_GREETER,1
        env = HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors
        env = HYPRCURSOR_SIZE,37
        ${concatMapStringsSep "\n" (m: "monitor=" + m) config.myOptions.monitors}
        input:kb_layout=${config.myOptions.kbLayout}
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
    configFiles = [
      "/home/${username}/.config/DankMaterialShell/settings.json"
      "/home/${username}/.local/state/DankMaterialShell/session.json"
      "/home/${username}/.local/cache/DankMaterialShell/dms-colors.json"
    ];
  };

  environment.systemPackages = [ pkgs.catppuccin-cursors.mochaDark ];
}
