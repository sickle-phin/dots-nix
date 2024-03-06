{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hyprpaper
  ];
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = ''
      preload = ~/.config/hypr/images/sickle.jpg
      wallpaper = eDP-1, ~/.config/hypr/images/sickle.jpg
      splash = false
      ipc = false
    '';
  };
}
