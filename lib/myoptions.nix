{ lib, ... }:
with lib;
{
  options = {
    myOptions = {
      cpu = mkOption {
        type = types.str;
        default = "intel";
        description = mdDoc ''
          gpu: intel/amd/nvidia
        '';
      };
      gpu = mkOption {
        type = types.str;
        default = "intel";
        description = mdDoc ''
          gpu: intel/amd/nvidia
        '';
      };
      hasBluetooth = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          enable bluetooth
        '';
      };
      isLaptop = mkOption {
        type = types.bool;
        default = false;
        description = mdDoc ''
          desktop or laptop
        '';
      };
      kbLayout = mkOption {
        type = types.str;
        default = "us";
        description = mdDoc ''
          keyboard layout
        '';
      };
      maxFramerate = mkOption {
        type = types.int;
        default = 60;
        description = mdDoc ''
          max monitor framerate
        '';
      };
      monitor = mkOption {
        type = types.listOf types.str;
        default = [ ", preferred, auto, 1" ];
        description = mdDoc ''
          monitor settings for hyprland
        '';
      };
    };
  };

}
