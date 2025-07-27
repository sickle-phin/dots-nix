{ osConfig, pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      grimblast
      hyprpicker
      hyprsunset
      networkmanagerapplet
      quickshell
      swappy
      swww
      tesseract
      wl-clipboard
      wl-clip-persist
      wl-screenrec
      ;
  };
  xdg.configFile."swappy/config".text = ''
    [Default]
    save_dir=$HOME/Pictures/Screenshot
  '';
  services = {
    cliphist.enable = true;
    hyprpolkitagent.enable = true;
    hyprsunset.enable = osConfig.myOptions.isLaptop;
    swww.enable = true;
    udiskie.enable = true;
  };
}
