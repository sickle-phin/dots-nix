{ inputs, username, ... }:
{
  imports = [
    ../lib/myoptions.nix
    ../secrets
    ./hardware
    ./os
    ./security

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = {
          inherit inputs;
          inherit username;
        };
        users.${username}.imports = [ ../home ];
      };
    }
  ];
}
