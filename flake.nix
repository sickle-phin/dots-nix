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
    flake-parts.url = "github:hercules-ci/flake-parts";

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
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

    xremap-flake.url = "github:xremap/nix-flake";
  };

  outputs =
    inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ inputs.git-hooks-nix.flakeModule ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          ...
        }:
        {
          pre-commit = {
            check.enable = true;
            settings = {
              src = ./.;
              hooks = {
                nixfmt-rfc-style.enable = true;
              };
            };
          };
          devShells.default = pkgs.mkShell {
            shellHook = ''
              ${config.pre-commit.installationScript}
            '';
          };
        };
      flake = {
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
    };
}
