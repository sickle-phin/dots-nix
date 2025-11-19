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

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell/tags/v0.6.0";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
    };

    dms-plugins = {
      url = "github:AvengeMedia/dms-plugins";
      flake = false;
    };

    dms-emoji-launcher = {
      url = "github:devnullvoid/dms-emoji-launcher";
      flake = false;
    };

    dms-wallpaperengine = {
      url = "github:sgtaziz/dms-wallpaperengine";
      flake = false;
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

    wavefox = {
      url = "github:QNetITQ/WaveFox";
      flake = false;
    };

    yazi-flavors = {
      url = "github:yazi-rs/flavors";
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
