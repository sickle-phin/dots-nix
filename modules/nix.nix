{
  pkgs,
  username,
  ...
}:
{
  nix = {
    channel.enable = false;
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      http-connections = 50;
      max-jobs = "auto";
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      use-xdg-base-directories = true;
    };
  };

  system.rebuild.enableNg = true;

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
