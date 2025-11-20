{
  config,
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.meta) getExe;
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
        if osConfig.myOptions.isLaptop then "Advanced Auto Gain" else "Bass Enhancing + Perfect EQ";
    };
    udiskie.enable = true;
  };

  home.sessionVariables.GRIMBLAST_HIDE_CURSOR = 0;

  systemd.user.services.easyeffects.Service.ExecStartPost = [
    "${getExe config.services.easyeffects.package} --load-preset \"${config.services.easyeffects.preset}\""
  ];

  xdg.configFile = {
    "easyeffects/irs".source = "${inputs.easyeffects-presets}/irs";
    "easyeffects/output".source = inputs.easyeffects-presets;
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshot
    '';
  };
}
