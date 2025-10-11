{
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkForce;
in
{
  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      grimblast
      hyprpicker
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
  xdg.configFile = {
    "swappy/config".text = ''
      [Default]
      save_dir=$HOME/Pictures/Screenshot
    '';
    "quickshell".source = ./quickshell;
  };
  programs.quickshell = {
    enable = true;
    systemd.enable = true;
  };
  services = {
    cliphist.enable = true;
    hyprpolkitagent.enable = true;
    hyprsunset.enable = osConfig.myOptions.isLaptop;
    swww.enable = true;
    udiskie.enable = true;
  };
  systemd.user.services.quickshell.Install.WantedBy = mkForce [ ];
}
