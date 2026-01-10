{
  config,
  inputs,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.lists) optionals;
  vendor = config.myOptions.gpu.vendor;
in
{
  nix = {
    channel.enable = false;
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      flake-registry = "";
      http-connections = 50;
      max-jobs = "auto";
      substituters = [
        "https://nix-community.cachix.org"
      ]
      ++ optionals (vendor == "nvidia") [
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ]
      ++ optionals (vendor == "nvidia") [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
      use-registries = true;
      use-xdg-base-directories = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [ pkgs.nurl ];

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 3";
      };
      flake = "/home/${username}/dots-nix";
    };
  };
}
