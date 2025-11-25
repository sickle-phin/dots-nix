{
  inputs,
  osConfig,
  pkgs,
  ...
}:
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
  };

  home.sessionVariables.GRIMBLAST_HIDE_CURSOR = 0;

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
