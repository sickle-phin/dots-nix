{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.strings) concatMapStringsSep;
  toLua = lib.generators.toLua { };
  monitors = config.myOptions.monitors ++ [
    {
      output = "";
      mode = "preferred";
      position = "auto";
      scale = 1;
    }
  ];
in
{
  services.displayManager.dux-greeter = {
    enable = true;
    compositor = {
      name = "hyprland";
      customConfig = ''
        hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-dark-cursors")
        hl.env("HYPRCURSOR_SIZE", "37")
        hl.env("QT_SCALE_FACTOR", "1.2")

        ${concatMapStringsSep "\n" (monitor: "hl.monitor(" + toLua monitor + ")") monitors}

        hl.config(${
          toLua {
            input = {
              kb_layout = config.myOptions.kbLayout;
              kb_options = "ctrl:nocaps";
            };
            misc = {
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              force_default_wallpaper = 0;
              vrr = 2;
            };
            cursor = lib.optionalAttrs (!config.myOptions.isLaptop) {
              default_monitor = "DP-1";
            };
            ecosystem = {
              no_update_news = true;
              no_donation_nag = true;
            };
          }
        })
      '';
    };
    configHome = "/home/${username}";
  };

  environment.systemPackages = [
    pkgs.catppuccin-cursors.mochaDark
    pkgs.catppuccin-cursors.latteLight
  ];
}
