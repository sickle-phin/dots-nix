{ lib, ... }:
{
  nix = {
    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
      builders-use-substitutes = true;
      auto-optimise-store = true;
    };

    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    channel.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;

  system.switch = {
    enable = false;
    enableNg = true;
  };

  programs = {
    command-not-found.enable = false;
    nh = {
      enable = true;
      flake = "/home/sickle-phin/dots-nix";
    };
  };
}
