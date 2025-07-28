{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
    ];
    extra-trusted-public-keys = [
    ];
  };

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

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

    wavefox = {
      url = "github:QNetITQ/WaveFox";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = inputs.nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      checks = forAllSystems (system: {
        pre-commit-check = inputs.git-hooks-nix.lib.${system}.run {
          src = ./.;
          hooks = {
            nixfmt-rfc-style.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = inputs.nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });

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
