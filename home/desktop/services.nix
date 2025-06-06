{ pkgs, ... }:
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      grimblast
      hyprpicker
      hyprsunset
      networkmanagerapplet
      swappy
      swww
      tesseract
      wl-clipboard
      wl-clip-persist
      wl-screenrec
      zenity
      ;
  };
  services = {
    cliphist.enable = true;
    hyprpolkitagent.enable = true;
    swww.enable = true;
    udiskie.enable = true;
  };
}
