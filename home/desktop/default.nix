{ pkgs
, ...
}: {
  imports = [
    ./fcitx5
    ./hyprland
    ./mako
    ./theme
    ./waybar
    ./wlogout
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    pamixer
    swww
    tesseract
    wl-clipboard
  ];

  services.cliphist.enable = true;
}
