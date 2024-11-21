{ lib, pkgs, ... }:
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
      hyprsunset
      networkmanagerapplet
      pamixer
      swappy
      swww
      tesseract
      wl-clipboard
      wl-clip-persist
      ;
  };

  services = {
    cliphist.enable = true;

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

  systemd.user.services = {
    cliphist.Unit.After = lib.mkForce "graphical-session.target";
    cliphist-images.Unit.After = lib.mkForce "graphical-session.target";
  };
}
