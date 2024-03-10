{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    brightnessctl
    hyprpicker
    hyprshot
    pamixer
    swaylock-effects
    wl-clipboard
  ];
}
