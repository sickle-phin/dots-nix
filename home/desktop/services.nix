{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe';
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      grimblast
      hyprpicker
      linux-wallpaperengine
      networkmanagerapplet
      swappy
      tesseract
      wl-clipboard
      wl-clip-persist
      wl-screenrec
      ;
  };

  services = {
    cliphist.enable = true;
    easyeffects = {
      enable = true;
      preset =
        if osConfig.myOptions.isLaptop then "\"Advanced Auto Gain\"" else "\"Bass Enhancing + Perfect EQ\"";
    };
    udiskie.enable = true;
    wl-clip-persist.enable = true;
  };

  home.sessionVariables.GRIMBLAST_HIDE_CURSOR = 0;

  systemd.user.services = {
    fumon = {
      Unit = {
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${getExe' osConfig.programs.uwsm.package "fumon"}";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };

  xdg = {
    configFile = {
      "swappy/config".text = ''
        [Default]
        save_dir=$HOME/Pictures/Screenshot
      '';
    };
    dataFile = {
      "easyeffects/irs".source = "${inputs.easyeffects-presets}/irs";
      "easyeffects/output/Advanced Auto Gain.json".source =
        "${inputs.easyeffects-presets}/Advanced Auto Gain.json";
      "easyeffects/output/Bass Enhancing + Perfect EQ.json".source =
        "${inputs.easyeffects-presets}/Bass Enhancing + Perfect EQ.json";
    };
  };
}
