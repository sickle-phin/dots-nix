{ pkgs, ... }:
{
  environment = {
    shells = with pkgs; [ zsh ];
    systemPackages = with pkgs; [
      cpufrequtils
      curl
      dmidecode
      lm_sensors
      lshw
      psmisc
      sbctl
      steam-run
      sysstat
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
    zsh = {
      enable = true;
    };
  };
}
