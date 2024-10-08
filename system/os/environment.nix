{ pkgs, ... }:
{
  environment = {
    shells = [ pkgs.zsh ];
    systemPackages = builtins.attrValues {
      inherit (pkgs)
        cpufrequtils
        curl
        dmidecode
        expect
        lm_sensors
        lshw
        psmisc
        sbctl
        sysstat
        usbutils
        wget
        ;
    };

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
