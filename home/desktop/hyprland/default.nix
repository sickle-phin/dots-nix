{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hypridle
    hyprpicker
    hyprshot
  ];

  imports = [
    ./hyprland.nix
    ./hyprlock.nix
  ];

  xdg.configFile = {
    "hypr/images" = {
      source = ./images;
      recursive = true;
    };
    "hypr/scripts" = {
      source = ./scripts;
      recursive = true;
    };
    "hypr/hypridle.conf" = {
      source = ./hypridle.conf;
    };
  };
}
