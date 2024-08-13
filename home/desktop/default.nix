{ pkgs
, ...
}: {
  imports = [
    ./fcitx5
    ./hyprland
    ./mako
    ./theme
    ./waybar
    ./wlogout.nix
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
