{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    ./ags.nix
    ./entries
    ./fcitx5
    ./hyprland
    ./mako.nix
    ./scripts
    ./theme
    ./waybar.nix
    ./wlogout.nix
    ./rofi.nix
  ];

  home.packages =
    let
      swww =
        if (osConfig.networking.hostName == "labo") then inputs.swww.packages.${pkgs.system}.swww else pkgs.swww;
    in
    builtins.attrValues {
      inherit (pkgs)
        brightnessctl
        hyprpicker
        hyprshot
        hyprsunset
        networkmanagerapplet
        pamixer
        swappy
        tesseract
        wl-clipboard
        wl-clip-persist
        ;
      inherit swww;
    };

  services = {
    cliphist.enable = true;

    udiskie = {
      enable = true;
      settings = {
        program_options = {
          udisks_version = 2;
        };
      };
      tray = "always";
    };
  };

  systemd.user.services = {
    cliphist.Unit.After = lib.mkForce "graphical-session.target";
    cliphist-images.Unit.After = lib.mkForce "graphical-session.target";
  };
}
