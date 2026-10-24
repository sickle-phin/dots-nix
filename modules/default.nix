{ inputs, username, ... }:
let
  # Preservation still checks the initrd switch removed in NixOS 26.11.
  # Patch only that check, keeping the upstream mount and tmpfiles logic.
  preservationModule = builtins.toFile "preservation-systemd-initrd.nix" (
    builtins.replaceStrings
      [
        "assertion = config.boot.initrd.systemd.enable;"
        "./lib.nix"
        "./options.nix"
      ]
      [
        ''assertion = lib.versionAtLeast config.system.nixos.release "26.11" || config.boot.initrd.systemd.enable;''
        "${inputs.preservation}/lib.nix"
        "${inputs.preservation}/options.nix"
      ]
      (builtins.readFile "${inputs.preservation}/module.nix")
  );
in
{
  imports = [
    ../lib/myoptions.nix
    ../secrets
    ./boot.nix
    ./console.nix
    ./documentation.nix
    ./fonts.nix
    ./gaming.nix
    ./greeter.nix
    ./hardware
    ./locale.nix
    ./networking.nix
    ./nix.nix
    ./packages.nix
    ./preservation.nix
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
    preservationModule
  ];
}
