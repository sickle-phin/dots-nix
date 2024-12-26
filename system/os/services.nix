{ pkgs, ... }:
{
  services = {
    fwupd.enable = true;
    gvfs.enable = true;
    hardware.openrgb.enable = true;
    printing.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    upower.enable = true;
  };

  systemd = {
    user.services.hyprpolkitagent = {
      description = "hyprpolkitagent";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 50;
  };
}
