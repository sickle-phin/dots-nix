{ pkgs
, ...
}: {
  home.packages = with pkgs; [
    hyprpaper
  ];
  xdg.configFile = {
    "hypr/hyprpaper.conf".text = ''
      preload = ~/dots-nix/images/sickle.jpg
      wallpaper = eDP-1, ~/dots-nix/images/sickle.jpg
      splash = false
      ipc = false
    '';
  };
}
