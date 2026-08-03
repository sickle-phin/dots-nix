{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}:
let
  inherit (lib.meta) getExe;
  dms = getExe config.programs.dank-material-shell.package;
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
      if nh clean all --no-gcroots; then
        ${getExe pkgs.libnotify} -a "NixOS" -u "low" -i "distributor-logo-nixos" "gc-nixos" "garbage collection completed"
      else
        ${getExe pkgs.libnotify} -a "NixOS" -u "critical" -i "distributor-logo-nixos" "gc-nixos" "garbage collection failed"
      fi
    '')

    (pkgs.writeShellScriptBin "rebuild-nixos" ''
      profile=$(dms ipc powerprofile status)
      cleanup() {
        ${dms} ipc powerprofile set "$profile" &> /dev/null
        ${dms} ipc inhibit disable &> /dev/null
      }
      trap cleanup EXIT
      ${dms} ipc inhibit enable &> /dev/null
      ${dms} ipc powerprofile set performance &> /dev/null
      nh os switch -H "${osConfig.networking.hostName}"
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
