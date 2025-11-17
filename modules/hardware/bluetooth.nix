{
  config,
  lib,
  ...
}:
let
  inherit (lib.modules) mkIf;

  hasBluetooth = config.myOptions.hasBluetooth;
in
{
  config = mkIf hasBluetooth {
    hardware = {
      # To activate Bluetooth, execute "rfkill unlock all"
      bluetooth = {
        enable = true;
        powerOnBoot = false;
        disabledPlugins = [ "sap" ];
        settings = {
          General = {
            Experimental = true;
            FastConnectable = true;
            JustWorksRepairing = "always";
            MultiProfile = "multiple";
          };
        };
      };
    };
  };
}
