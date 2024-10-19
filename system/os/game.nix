{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [ inputs.nix-gaming.nixosModules.platformOptimizations ];

  programs = {
    steam = lib.mkIf config.myOptions.enableGaming {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
      platformOptimizations.enable = true;
    };

    gamemode = {
      enable = true;
      settings = {
        general = {
          softrealtime = "auto";
          renice = 15;
        };
        cpu = {
          pin_cores = 0;
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
            endscript = pkgs.writeShellScript "gamemode-end" ''
              export PATH=$PATH:${programs}
              powerprofilesctl set power-saver
            '';
          in
          {
            start = startscript.outPath;
            end = endscript.outPath;
          };
      };
    };
  };
}
