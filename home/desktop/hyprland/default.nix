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

  xdg.configFile = {
    "hypr/images" = {
      source = ./images;
      recursive = true;
    };
  };
}
