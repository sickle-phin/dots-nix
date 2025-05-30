{
  pkgs,
  ...
}:
{
  imports = [
    ./bar
    ./entries
    ./fcitx5
    ./hyprland
    ./launcher
    ./scripts
    ./theme
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      grimblast
      hyprpicker
      hyprpolkitagent
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
    udiskie.enable = true;
  };
}
