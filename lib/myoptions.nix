{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    bool
    enum
    int
    listOf
    nullOr
    str
    ;
in
{
  options = {
    myOptions = {
      catppuccin.accent =
        let
          type = enum [
            "blue"
            "flamingo"
            "green"
            "lavender"
            "maroon"
            "mauve"
            "peach"
            "pink"
            "red"
            "rosewater"
            "sapphire"
            "sky"
            "teal"
            "yellow"
          ];

        in
        {
          dark = mkOption {
            type = type;
            default = "teal";
            description = "catppuccin accent color for dark theme";
          };
          light = mkOption {
            type = type;
            default = "pink";
            description = "catppuccin accent color for light theme";
          };
        };
      enableGaming = mkOption {
        type = bool;
        default = true;
        description = "enable steam gaming";
      };
      gpu.vendor = mkOption {
        type = nullOr (enum [
          "amd"
          "intel"
          "nvidia"
        ]);
        default = null;
        description = "The vendor of the system GPU";
      };
      hasBluetooth = mkOption {
        type = bool;
        default = false;
        description = "enable bluetooth";
      };
      isLaptop = mkOption {
        type = bool;
        default = false;
        description = "desktop or laptop";
      };
      kbLayout = mkOption {
        type = str;
        default = "us";
        description = "keyboard layout";
      };
      kbPermission = mkOption {
        type = nullOr str;
        default = null;
        description = "keyboard permission regex for hyprland";
      };
      maxFramerate = mkOption {
        type = int;
        default = 60;
        description = "max monitor framerate";
      };
      monitors = mkOption {
        type = listOf str;
        default = [ ", preferred, auto, 1" ];
        description = "monitor settings for hyprland";
      };
      signingKey = mkOption {
        type = str;
        default = "";
        description = "gpg signing key ID";
      };
      ssh.publicKey = mkOption {
        type = str;
        default = "";
        description = "ssh public key";
      };
      test.enable = mkOption {
        type = bool;
        default = false;
        description = "set password to 'test' for installation";
      };
    };
  };
}
