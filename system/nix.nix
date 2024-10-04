{ lib, pkgs, ... }:
{
  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://cache.nixos.org" ];
      trusted-public-keys = [ "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY=" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      use-xdg-base-directories = true;
    };

    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };

    channel.enable = false;
  };

  system.switch = {
    enable = false;
    enableNg = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment = {
    sessionVariables.NIXPKGS_ALLOW_UNFREE = 1;
    systemPackages = [ pkgs.nurl ];
  };

  programs = {
    command-not-found.enable = false;
    nh = {
      enable = true;
      flake = "/home/sickle-phin/dots-nix";
    };
  };
}
