{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  imports = [
    ./bar
    ./entries
    ./fcitx5
    ./hyprland
    ./launcher
    ./scripts
    ./theme
  ];

  home.packages =
    let
      swww =
        if (osConfig.networking.hostName == "labo") then
          inputs.swww.packages.${pkgs.system}.swww
        else
          pkgs.swww;
    in
    builtins.attrValues {
      inherit (pkgs)
        brightnessctl
        grimblast
        hyprpicker
        hyprpolkitagent
        hyprsunset
        networkmanagerapplet
        swappy
        tesseract
        wl-clipboard
        wl-clip-persist
        wl-screenrec
        zenity
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

  systemd.user = {
    services = {
      cliphist.Unit.After = lib.mkForce "graphical-session.target";
      cliphist-images.Unit.After = lib.mkForce "graphical-session.target";
      udiskie.Unit.After = lib.mkForce [
        "graphical-session.target"
        "tray.target"
      ];
    };
    targets.tray.Unit.Requires = lib.mkForce [ "graphical-session.target" ];
  };
}
