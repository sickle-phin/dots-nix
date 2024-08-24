{ pkgs, inputs, ... }:
{
  imports = [
    inputs.sddm-sugar-candy-nix.nixosModules.default
    {
      nixpkgs.overlays = [ inputs.sddm-sugar-candy-nix.overlays.default ];
    }
  ];

  services = {
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
            CursorTheme = "catppuccin-mocha-dark-cursors";
            CursorSize = 30;
          };
        };
      };
    };
  };

  environment.systemPackages = [ pkgs.catppuccin-cursors.mochaDark ];
}
