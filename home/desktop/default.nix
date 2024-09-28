{ pkgs, ... }:
{
  imports = [
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
      pamixer
      swww
      tesseract
      wl-clipboard
      ;
  };

  services.cliphist.enable = true;
}
