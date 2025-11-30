{
  config,
  inputs,
  pkgs,
  ...
}:
{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        maxGenerations = 10;
        secureBoot.enable = !config.myOptions.test.enable;
        style = {
          graphicalTerminal = {
            palette = "1e1e2e;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            brightPalette = "585b70;f38ba8;a6e3a1;f9e2af;89b4fa;f5c2e7;94e2d5;cdd6f4";
            background = "441e1e2e";
            foreground = "cdd6f4";
            brightBackground = "585b70";
            brightForeground = "cdd6f4";
          };
          wallpapers = [ "${inputs.wallpaper}/wallpaper/sickle.jpg" ];
        };
      };
      timeout = if config.myOptions.isLaptop then 5 else 30;
    };

    kernelPackages = pkgs.linuxPackages_xanmod_latest;

    consoleLogLevel = 0;

    initrd = {
      verbose = false;
      systemd.enable = true;
    };

    tmp.cleanOnBoot = true;

    plymouth = {
      enable = true;
      font = "${pkgs.inter}/share/fonts/truetype/InterVariable.ttf";
      theme = "breeze";
      extraConfig = "DeviceScale=1";
    };

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
      "fbcon=nodefer"
    ];
  };
}
