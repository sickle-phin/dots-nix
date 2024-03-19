{ config, pkgs, ... }:

{
  services.swayidle =
    let
      lockCommand = "bash -c ${pkgs.hyprlock}/bin/hyprlock &";
      dpmsCommand = "${pkgs.hyprland}/bin/hyprctl dispatch dpms";
    in
    {
      enable = false;
      systemdTarget = "hyprland-session.target";
      timeouts =
        [
          {
            timeout = 10;
            command = lockCommand;
          }
          {
            timeout = 20;
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
