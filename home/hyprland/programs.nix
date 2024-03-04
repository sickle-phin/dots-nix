{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    brightnessctl
    pamixer
    wl-clipboard
  ];
}
