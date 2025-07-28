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
      gpu.isLegacy = mkOption {
        type = bool;
        default = false;
        description = "whether to use legacy GPU drivers";
      };
      hasBluetooth = mkOption {
        type = bool;
        default = false;
        description = "enable bluetooth";
      };
      impermanence.enable = mkOption {
        type = bool;
        default = false;
        description = "whether to enable impermanence module";
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
      monitor = mkOption {
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
    };
  };
}
