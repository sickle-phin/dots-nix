{ pkgs
, inputs
, ...
}: {
  imports = [
    inputs.sddm-sugar-candy-nix.nixosModules.default
    # {
    #   nixpkgs.overlays = [ inputs.sddm-sugar-candy-nix.overlays.default ];
    # }
  ];

  services = {
    xserver = {
      excludePackages = [ pkgs.xterm ];
    };

    displayManager = {
      sddm = {
        enable = true;
        enableHidpi = true;
        wayland.enable = true;
        wayland.compositor = "kwin";
        sugarCandyNix = {
          enable = true;
          settings = {
            Font = "PlemolJP HS";
            ForceHideCompletePassword = true;
          };
        };
        settings = {
          Theme = {
            CursorTheme = "breeze_cursors";
          };
        };
      };
    };
  };

  environment.systemPackages = [ pkgs.breeze-gtk ];
}
