{ config
, pkgs
, lib
, ...
}: let
  programs = lib.makeBinPath [
    config.programs.hyprland.package
    pkgs.coreutils
  ];

  startscript = pkgs.writeShellScript "gamemode-start" ''
    export PATH=$PATH:${programs}
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | tail -1)
    hyprctl --batch 'keyword decoration:blur:enabled 0 ; keyword animations:enabled 0 ; keyword misc:vfr 0 ; keyword decoration:drop_shadow 0'
  '';

  endscript = pkgs.writeShellScript "gamemode-end" ''
    export PATH=$PATH:${programs}
    export HYPRLAND_INSTANCE_SIGNATURE=$(ls -1 /tmp/hypr | tail -1)
    hyprctl --batch 'keyword decoration:blur:enabled 1 ; keyword animations:enabled 1 ; keyword misc:vfr 1 ; keyword decoration:drop_shadow 1'
  '';
in {
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 15;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        nv_powermizer_mode = 1;
      };
      cpu = {
        pin_cores = 0;
      };
      custom = {
        start = startscript.outPath;
        end = endscript.outPath;
      };
    };
  };
}
