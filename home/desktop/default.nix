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
    ./wofi
  ];

  home.packages = with pkgs; [
    brightnessctl
    pamixer
    swww
    wl-clipboard
  ];
}
