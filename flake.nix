{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        darwin.follows = "";
      };
    };

    dank-material-shell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    easyeffects-presets = {
      url = "github:JackHack96/EasyEffects-Presets";
      flake = false;
    };

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "";
        gitignore.follows = "";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";

    matugen-themes = {
      url = "github:InioX/matugen-themes";
      flake = false;
    };

    mysecrets = {
      url = "git+ssh://git@github.com/sickle-phin/secrets-nix.git?shallow=1";
      flake = false;
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wallpaper = {
      url = "git+ssh://git@github.com/sickle-phin/wallpaper.git";
      flake = false;
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
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
          package = inputs.nixpkgs.legacyPackages.${system}.prek;
          src = ./.;
          hooks = {
            nixfmt.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = inputs.nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages;
        };
      });

      formatter = forAllSystems (system: inputs.nixpkgs.legacyPackages.${system}.nixfmt-tree);

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
