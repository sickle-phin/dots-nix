{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hyprpicker
    hyprshot
  ];

  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
  ];
}
