{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hyprdim
    hyprpicker
    hyprshot
  ];

  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
  ];

  xdg.configFile = {
    "hypr/images" = {
      source = ./images;
      recursive = true;
    };
  };
}
