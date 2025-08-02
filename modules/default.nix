{ inputs, username, ... }:
{
  imports = [
    ../lib/myoptions.nix
    ../secrets
    ./boot.nix
    ./console.nix
    ./displaymanager.nix
    ./documentation.nix
    ./fonts.nix
    ./gaming.nix
    ./hardware
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./security
    ./services.nix
    ./system.nix
    ./users.nix
    ./virtualization.nix

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
