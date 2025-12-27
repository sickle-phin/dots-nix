{
  inputs,
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe inputs.dank-material-shell.packages.${pkgs.stdenv.hostPlatform.system}.dms-shell;
in
{
  home.packages = [
    (pkgs.writeShellScriptBin "update-nixos" ''
      if ! nix profile upgrade --all; then
        ${getExe pkgs.libnotify} -a "NixOS" -u "critical" -i "distributor-logo-nixos" "update-nixos" "update failed"
        exit 1
      fi
      if nix flake update --flake "${config.home.homeDirectory}/dots-nix"; then
        ${getExe pkgs.libnotify} -a "NixOS" -u "low" -i "distributor-logo-nixos" "update-nixos" "update completed"
      else
        ${getExe pkgs.libnotify} -a "NixOS" -u "critical" -i "distributor-logo-nixos" "update-nixos" "update failed"
      fi
    '')

    (pkgs.writeShellScriptBin "gc-nixos" ''
      if nh clean all; then
        ${getExe pkgs.libnotify} -a "NixOS" -u "low" -i "distributor-logo-nixos" "gc-nixos" "garbage collection completed"
      else
        ${getExe pkgs.libnotify} -a "NixOS" -u "critical" -i "distributor-logo-nixos" "gc-nixos" "garbage collection failed"
      fi
    '')

    (pkgs.writeShellScriptBin "rebuild-nixos" ''
      if nh os switch -H "${osConfig.networking.hostName}"; then
        ${getExe pkgs.libnotify} -a "NixOS" -u "low" -i "distributor-logo-nixos" "rebuild-nixos" "rebuild completed"
      else
        ${getExe pkgs.libnotify} -a "NixOS" -u "critical" -i "distributor-logo-nixos" "rebuild-nixos" "rebuild failed"
      fi
    '')

    (pkgs.writeShellScriptBin "nvim-clean" ''
      rm -rf "$HOME/.config/nvim"
    '')

    (pkgs.writeShellScriptBin "nvim-test" ''
      nvim-clean
      rsync -avz --copy-links --chmod=D2755,F744 "$HOME/dots-nix/home/applications/nvim" "$HOME/.config"
    '')

    (pkgs.writeShellScriptBin "wl-copy" ''
      ${dms} cl copy
    '')
  ];
}
