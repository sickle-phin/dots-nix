{ pkgs
, ...
}: {
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
  ];
  xdg.configFile = {
    "hypr/images" = {
      source = ./images;
      recursive = true;
    };
  };
  xdg.configFile = {
    "hypr/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };
}
