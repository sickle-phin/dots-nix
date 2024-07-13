{ pkgs
, inputs
, ...
}:{
  environment = {
    systemPackages = with pkgs; [
      breeze-gtk
      cpufrequtils
      curl
      dmidecode
      lm_sensors
      psmisc
      sbctl
      sddm-chili-theme
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
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
