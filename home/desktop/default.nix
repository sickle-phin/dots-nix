{ pkgs, ... }:
{
  imports = [
    ./ags.nix
    ./entries
    ./fcitx5
    ./hyprland
    ./mako.nix
    ./scripts
    ./theme
    ./waybar.nix
    ./wlogout.nix
    ./rofi.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      cliphist
      hyprpicker
      hyprshot
      hyprsunset
      networkmanagerapplet
      pamixer
      swww
      tesseract
      wl-clipboard
      ;
  };

  services = {
    udiskie = {
      enable = true;
      settings = {
        program_options = {
          udisks_version = 2;
        };
      };
      tray = "always";
    };
  };
}
