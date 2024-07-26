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
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    pamixer
    swww
    wl-clipboard
  ];
}
