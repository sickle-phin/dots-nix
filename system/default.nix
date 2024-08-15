{ inputs, username, ... }:
{
  imports = [
    ./boot.nix
    ./console.nix
    ./environment.nix
    ./fonts.nix
    ./gui.nix
    ./i18n.nix
    ./networking.nix
    ./nix.nix
    ./security.nix
    ./services.nix
    ./sound.nix
    ./users.nix
    ./xremap.nix

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
