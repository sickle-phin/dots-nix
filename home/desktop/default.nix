{
  imports = [
    ./fcitx5.nix
    ./fuzzel.nix
    ./hypridle.nix
    ./hyprland
    ./hyprlock.nix
    ./hyprpanel.nix
    ./services.nix
    ./scripts
    ./theme
  ];

  xdg.configFile."quickshell".source = ./quickshell;
}
