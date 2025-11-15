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
        notify-send -a "Update NixOS" -u normal -i "${../icons/NixOS.png}" "NixOS" "update failed"
        exit 1
      fi
      if nix flake update --flake "${config.home.homeDirectory}/dots-nix"; then
        notify-send -a "Update NixOS" -u low -i "${../icons/NixOS.png}" "NixOS" "update completed"
      else
        notify-send -a "Update NixOS" -u normal -i "${../icons/NixOS.png}" "NixOS" "update failed"
      fi
    '')

    (pkgs.writeShellScriptBin "gc-nixos" ''
      if nh clean all; then
        notify-send -a "Garbage Collection" -u low -i "${../icons/NixOS.png}" "NixOS" "garbage collection completed"
      else
        notify-send -a "Garbage Collection" -u normal -i "${../icons/NixOS.png}" "NixOS" "garbage collection failed"
      fi
    '')

    (pkgs.writeShellScriptBin "rebuild-nixos" ''
      if nh os switch -H "${osConfig.networking.hostName}"; then
        notify-send -a "Rebuild NixOS" -u low -i "${../icons/NixOS.png}" "NixOS" "rebuild completed"
      else
        notify-send -a "Rebuild NixOS" -u normal -i "${../icons/NixOS.png}" "NixOS" "rebuild failed"
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
