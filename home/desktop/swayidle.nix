{ config, pkgs, ... }:

{
  services.swayidle =
    let
      lockCommand = "${pkgs.swaylock-effects}/bin/swaylock -f --screenshots --clock --indicator --indicator-radius 100 --indicator-thickness 7 --effect-blur 7x5 --effect-vignette 0.5:0.5 --ring-color f477b6 --key-hl-color 50e090 --line-color 00000000 --inside-color 00000088 --separator-color 00000000 --fade-in 0.2";
      dpmsCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms";
    in
    {
      enable = true;
      systemdTarget = "hyprland-session.target";
      timeouts =
        [
          {
            timeout = 300;
            command = lockCommand;
          }
          {
            timeout = 600;
            command = "${dpmsCommand} off";
            resumeCommand = "${dpmsCommand} on";
          }
        ];
      events = [
        {
          event = "before-sleep";
          command = "${dpmsCommand} on && " + lockCommand;
        }
        {
          event = "lock";
          command = lockCommand;
        }
      ];
    };
}
