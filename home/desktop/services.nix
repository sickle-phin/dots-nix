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
      linux-wallpaperengine
      networkmanagerapplet
      satty
      tesseract
      wl-screenrec
      ;
  };

  services = {
    easyeffects = {
      enable = true;
      preset =
        if osConfig.myOptions.isLaptop then "\"Advanced Auto Gain\"" else "\"Bass Enhancing + Perfect EQ\"";
    };
    udiskie.enable = true;
    wl-clip-persist.enable = true;
  };

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
    dataFile = {
      "easyeffects/irs".source = "${inputs.easyeffects-presets}/irs";
      "easyeffects/output/Advanced Auto Gain.json".source =
        "${inputs.easyeffects-presets}/Advanced Auto Gain.json";
      "easyeffects/output/Bass Enhancing + Perfect EQ.json".source =
        "${inputs.easyeffects-presets}/Bass Enhancing + Perfect EQ.json";
    };
  };
}
