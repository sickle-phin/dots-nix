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
      hyprpicker
      hyprshot
      networkmanagerapplet
      pamixer
      seahorse
      swww
      tesseract
      wl-clipboard
      ;
  };

  services = {
    cliphist.enable = true;

    gnome-keyring.enable = true;

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
