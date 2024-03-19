{ pkgs
, ...
}: {
  imports = [
    ./hyprland
    ./mako
    ./swayidle.nix
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
