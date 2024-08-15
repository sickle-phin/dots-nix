{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      cpufrequtils
      curl
      dmidecode
      lm_sensors
      psmisc
      sbctl
      steam-run
      sysstat
      tk
      unar
      usbutils
      wget
    ];

    sessionVariables = {
      EDITOR = "nvim";
    };

    enableAllTerminfo = true;
  };

  programs = {
    hyprland.enable = true;
  };
}
