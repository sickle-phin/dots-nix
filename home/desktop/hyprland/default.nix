{ pkgs
, inputs
, ...
}: {
  home.packages = with pkgs; [
    hyprlock
    hypridle
    hyprpicker
    hyprshot
  ];

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  #   settings = {};
  # };
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
  # xdg.configFile = {
  #   "hypr/hyprland.conf" = {
  #     source = ./hyprland.conf;
  #   };
  # };
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
