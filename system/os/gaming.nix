{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkIf;
in
{
  programs = {
    steam = mkIf config.myOptions.enableGaming {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 15;
        };
        custom =
          let
            programs = lib.makeBinPath [
              pkgs.power-profiles-daemon
            ];
            startscript = pkgs.writeShellScript "gamemode-start" ''
              export PATH=$PATH:${programs}
              powerprofilesctl set performance
            '';
            endscript =
              let
                profile = if config.hardware.cpu.amd.updateMicrocode then "power-saver" else "balanced";
              in
              pkgs.writeShellScript "gamemode-end" ''
                export PATH=$PATH:${programs}
                powerprofilesctl set ${profile}
              '';
          in
          {
            start = startscript.outPath;
            end = endscript.outPath;
          };
      };
    };
  };

  hardware.xone.enable = mkIf config.myOptions.enableGaming true;

  # reference: https://github.com/fufexan/nix-gaming/blob/master/modules/platformOptimizations.nix
  boot = {
    kernel.sysctl = {
      # 20-shed.conf
      "kernel.sched_cfs_bandwidth_slice_us" = 3000;
      # 20-net-timeout.conf
      # This is required due to some games being unable to reuse their TCP ports
      # if they're killed and restarted quickly - the default timeout is too large.
      "net.ipv4.tcp_fin_timeout" = 5;
      # 30-splitlock.conf
      # Prevents intentional slowdowns in case games experience split locks
      # This is valid for kernels v6.0+
      "kernel.split_lock_mitigate" = 0;
      # 30-vm.conf
      # USE MAX_INT - MAPCOUNT_ELF_CORE_MARGIN.
      # see comment in include/linux/mm.h in the kernel tree.
      "vm.max_map_count" = 2147483642;
    };
    kernelModules = [ "ntsync" ];
  };
}
