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

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mysecrets = {
      url = "git+ssh://git@github.com/sickle-phin/secrets-nix.git?shallow=1";
      flake = false;
    };

    wallpaper = {
      url = "git+ssh://git@github.com/sickle-phin/wallpaper.git";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

    xremap-flake.url = "github:xremap/nix-flake";

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww.url = "github:LGFae/swww/1bd7166f0e06bbb4f1c175b35bfef582b4e639ac";

    wavefox = {
      url = "github:QNetITQ/WaveFox";
      flake = false;
    };
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
