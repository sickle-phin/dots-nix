{ lib, ... }:
let
  inherit (lib.options) mkOption;
  inherit (lib.types)
    bool
    either
    enum
    float
    int
    listOf
    nullOr
    str
    submodule
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
        type = listOf (submodule {
          options = {
            output = mkOption {
              type = str;
              description = "The name of the display output (e.g., DP-1, HDMI-A-1).";
            };
            mode = mkOption {
              type = str;
              description = "The resolution and refresh rate (e.g., 2560x1440@180).";
            };
            position = mkOption {
              type = str;
              description = "The position of the monitor (e.g., 0x0).";
            };
            scale = mkOption {
              type = either int float;
              default = 1;
              description = "The scale factor for the monitor.";
            };
            transform = mkOption {
              type = int;
              default = 0;
              description = "The rotation for the monitor.";
            };
            bitdepth = mkOption {
              type = int;
              default = 8;
              description = "The color bit depth.";
            };
          };
        });
        default = [ ];
        description = "List of monitor configurations.";
      };
      monitorsLegacy = mkOption {
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
