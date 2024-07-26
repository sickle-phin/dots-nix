{ pkgs
, inputs
, ...
}: {
  imports = [ inputs.nix-gaming.nixosModules.platformOptimizations ];

  programs = {
    steam = {
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
        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 1;
          nv_powermizer_mode = 1;
        };
        cpu = {
          pin_cores = 0;
        };
      };
    };
  };
}