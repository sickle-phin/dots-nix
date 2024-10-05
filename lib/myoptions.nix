{ lib, ... }:
{
  options = {
    myOptions = {
      cpu = lib.mkOption {
        type = lib.types.str;
        default = "intel";
        description = lib.mdDoc ''
          cpu: intel/amd
        '';
      };
      enableGaming = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = lib.mdDoc ''
          enable steam gaming
        '';
      };
      gpu = lib.mkOption {
        type = lib.types.str;
        default = "intel";
        description = lib.mdDoc ''
          gpu: intel/amd/nvidia
        '';
      };
      hasBluetooth = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          enable bluetooth
        '';
      };
      isLaptop = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = lib.mdDoc ''
          desktop or laptop
        '';
      };
      kbLayout = lib.mkOption {
        type = lib.types.str;
        default = "us";
        description = lib.mdDoc ''
          keyboard layout
        '';
      };
      maxFramerate = lib.mkOption {
        type = lib.types.int;
        default = 60;
        description = lib.mdDoc ''
          max monitor framerate
        '';
      };
      monitor = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ", preferred, auto, 1" ];
        description = lib.mdDoc ''
          monitor settings for hyprland
        '';
      };
      signingKey = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = lib.mdDoc ''
          gpg signing key ID
        '';
      };
      ssh.publicKey = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = lib.mdDoc ''
          ssh public key
        '';
      };
    };
  };

}
