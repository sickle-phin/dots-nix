{
  description = "NixOS configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";

    #home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-gaming.url = "github:fufexan/nix-gaming";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1&rev=9e781040d9067c2711ec2e9f5b47b76ef70762b3";

    catppuccin.url = "github:catppuccin/nix";

    xremap-flake.url = "github:xremap/nix-flake";

    wezterm = {
      url = "github:wez/wezterm/b8f94c474ce48ac195b51c1aeacf41ae049b774e?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    apple-color-emoji = {
      url = "https://github.com/samuelngs/apple-emoji-linux/releases/download/v17.4/AppleColorEmoji.ttf";
      flake = false;
    };
  };


  outputs =
    inputs @ { self
    , nixpkgs
    , home-manager
    , ...
    }: {
      nixosConfigurations = {
        irukaha = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/irukaha
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.disko.nixosModules.disko
            inputs.impermanence.nixosModules.impermanence
            inputs.nix-gaming.nixosModules.pipewireLowLatency
            inputs.nix-gaming.nixosModules.platformOptimizations
            inputs.catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.sickle-phin = {
                imports = [
                  ./home
                  inputs.catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
            inputs.xremap-flake.nixosModules.default
            {
              services.xremap.config.modmap = [
                {
                  name = "Global";
                  remap = { "CapsLock" = "Ctrl_L"; };
                }
              ];
            }
          ];
        };
        pink = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/pink
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.disko.nixosModules.disko
            inputs.impermanence.nixosModules.impermanence
            inputs.nix-gaming.nixosModules.pipewireLowLatency
            inputs.catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.sickle-phin = {
                imports = [
                  ./home
                  inputs.catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
            inputs.xremap-flake.nixosModules.default
            {
              services.xremap.config.modmap = [
                {
                  name = "Global";
                  remap = { "CapsLock" = "Ctrl_L"; };
                }
              ];
            }
          ];
        };
        labo = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/labo
            inputs.lanzaboote.nixosModules.lanzaboote
            inputs.nix-gaming.nixosModules.pipewireLowLatency
            inputs.catppuccin.nixosModules.catppuccin

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.sickle-phin = {
                imports = [
                  ./home
                  inputs.catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
            inputs.xremap-flake.nixosModules.default
            {
              services.xremap.config.modmap = [
                {
                  name = "Global";
                  remap = { "CapsLock" = "Ctrl_L"; };
                }
              ];
            }
          ];
        };
      };
    };
}
