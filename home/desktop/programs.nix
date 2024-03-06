{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    swaylock-effects
    wl-clipboard
  ];
}
