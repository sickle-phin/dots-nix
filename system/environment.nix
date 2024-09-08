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
    nix-ld.enable = true;
  };
}
