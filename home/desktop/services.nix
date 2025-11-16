{ pkgs, ... }:
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

  xdg.configFile = {
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshot
    '';
  };

  services = {
    cliphist.enable = true;
    easyeffects.enable = true;
    hyprpolkitagent.enable = true;
    udiskie.enable = true;
  };
}
