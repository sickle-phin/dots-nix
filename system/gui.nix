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
            FullBlur = true;
            ForceHideCompletePassword = true;
            BlurRadius = 20;
            AccentColor = "#89b4fa";
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
