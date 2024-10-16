{ pkgs, ... }:
{
  imports = [
    ./entries
    ./fcitx5
    ./hyprland
    ./mako.nix
    ./scripts
    ./theme
    ./waybar.nix
    ./wlogout.nix
    ./rofi.nix
  ];

  home.packages = builtins.attrValues {
    inherit (pkgs)
      brightnessctl
      hyprpicker
      hyprshot
      pamixer
      swww
      tesseract
      wl-clipboard
      ;
  };

  services = {
    cliphist.enable = true;
    cliphist.package = pkgs.cliphist.overrideAttrs {
      src = pkgs.fetchFromGitHub {
        owner = "sentriz";
        repo = "cliphist";
        rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
        sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
      };
      vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
    };

    udiskie = {
      enable = true;
      settings = {
        program_options = {
          udisks_version = 2;
        };
      };
      tray = "always";
    };
  };
}
