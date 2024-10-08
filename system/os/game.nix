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
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
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
      };
    };
  };
}
