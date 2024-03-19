{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprpicker
    hyprshot
  ];
  
  imports = [
    ./hyprland.nix
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
  xdg.configFile = {
    "hypr/hyprlock.conf" = {
      source = ./hyprlock.conf;
    };
  };
  xdg.configFile = {
    "hypr/hypridle.conf" = {
      source = ./hypridle.conf;
    };
  };
}
