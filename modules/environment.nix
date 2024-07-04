{ pkgs
, inputs
, ...
}:{
  environment = {
    systemPackages = with pkgs; [
      cpufrequtils
      dmidecode
      usbutils
      neovim
      wget
      curl
      git
      sysstat
      tk
      lm_sensors
      scrot
      sbctl
      sddm-chili-theme
      breeze-gtk
      unar
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
