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
    hyprpicker
    hyprshot
    pamixer
    swaylock-effects
    swww
    wl-clipboard
  ];
}
