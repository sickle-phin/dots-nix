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
    services.blueman.enable = true;
  };
}
