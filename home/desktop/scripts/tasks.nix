{
  pkgs,
  config,
  osConfig,
  ...
}:
{

  home.packages = [
    (pkgs.writeShellScriptBin "update-nixos" ''
      if ! nix profile upgrade --all; then
        notify-send -a "NixOS" -u "critical" -i "distributor-logo-nixos" "update-nixos" "update failed"
        exit 1
      fi
      if nix flake update --flake "${config.home.homeDirectory}/dots-nix"; then
        notify-send -a "NixOS" -u "low" -i "distributor-logo-nixos" "update-nixos" "update completed"
      else
        notify-send -a "NixOS" -u "critical" -i "distributor-logo-nixos" "update-nixos" "update failed"
      fi
    '')

    (pkgs.writeShellScriptBin "gc-nixos" ''
      if nh clean all; then
        notify-send -a "NixOS" -u "low" -i "distributor-logo-nixos" "gc-nixos" "garbage collection completed"
      else
        notify-send -a "NixOS" -u "critical" -i "distributor-logo-nixos" "gc-nixos" "garbage collection failed"
      fi
    '')

    (pkgs.writeShellScriptBin "rebuild-nixos" ''
      if nh os switch -H "${osConfig.networking.hostName}"; then
        notify-send -a "NixOS" -u "low" -i "distributor-logo-nixos" "rebuild-nixos" "rebuild completed"
      else
        notify-send -a "NixOS" -u "critical" -i "distributor-logo-nixos" "rebuild-nixos" "rebuild failed"
      fi
    '')

    (pkgs.writeShellScriptBin "nvim-clean" ''
      rm -rf "$HOME/.config/nvim"
    '')

    (pkgs.writeShellScriptBin "nvim-test" ''
      nvim-clean
      rsync -avz --copy-links --chmod=D2755,F744 "$HOME/dots-nix/home/applications/nvim" "$HOME/.config"
    '')
  ];
}
