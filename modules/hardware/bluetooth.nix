{ config, ... }:
{
  # To activate Bluetooth, execute "rfkill unblock bluetooth"
  hardware = {
    bluetooth = {
      enable = config.myOptions.hasBluetooth;
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
}
