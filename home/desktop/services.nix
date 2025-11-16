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
        if osConfig.myOptions.isLaptop then "Advanced Auto Gain" else "Bass Enhancing + Perfect EQ";
    };
    hyprpolkitagent.enable = true;
    udiskie.enable = true;
  };

  xdg.configFile = {
    "easyeffects/output".source = inputs.easyeffects-presets;
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshot
    '';
  };
}
