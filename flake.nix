{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    ragenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mysecrets = {
      url = "git+ssh://git@github.com/sickle-phin/secrets-nix.git?shallow=1";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpak = {
      url = "github:nixpak/nixpak";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix/45745fe5960acaefef2b60f3455bcac6a0ca6bc9";

    xremap-flake.url = "github:xremap/nix-flake";

    ags.url = "github:Aylur/ags";
  };

  outputs = inputs: {
    nixosConfigurations =
      let
        mkNixosSystem =
          {
            system,
            hostname,
            username,
            modules,
          }:
          inputs.nixpkgs.lib.nixosSystem {
            inherit system modules;
            specialArgs = {
              inherit inputs hostname username;
            };
          };
      in
      {
        irukaha = mkNixosSystem {
          system = "x86_64-linux";
          hostname = "irukaha";
          username = "sickle-phin";
          modules = [ ./hosts/irukaha ];
        };
        pink = mkNixosSystem {
          system = "x86_64-linux";
          hostname = "pink";
          username = "sickle-phin";
          modules = [ ./hosts/pink ];
        };
        labo = mkNixosSystem {
          system = "x86_64-linux";
          hostname = "labo";
          username = "sickle-phin";
          modules = [ ./hosts/labo ];
        };
      };
  };
}
