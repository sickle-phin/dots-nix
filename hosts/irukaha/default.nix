{ inputs, ... }:
{
  imports = [
    ../../modules
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./hardware-configuration.nix
    ./profile.nix
  ];
}
