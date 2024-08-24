{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "update-nix" ''
      if ! nix profile upgrade '.*'; then
        notify-send -u normal -i "${../icons/NixOS.png}" "NixOS" "update failed"
        exit 1
      fi
      if nix flake update "$HOME/dots-nix"; then
        notify-send -u low -i "${../icons/NixOS.png}" "NixOS" "update completed"
      else
        notify-send -u normal -i "${../icons/NixOS.png}" "NixOS" "update failed"
      fi
    '')

    (writeShellScriptBin "gc-nix" ''
      if ! sudo nix-collect-garbage --delete-old; then
        notify-send -u normal -i "${../icons/NixOS.png}" "NixOS" "garbage collection failed"
        exit 1
      fi
      if ! nix-collect-garbage --delete-old; then
        notify-send -u low -i "${../icons/NixOS.png}" "NixOS" "garbage collection failed"
        exit 1
      fi
      if nix store gc --debug; then
        notify-send -u low -i "${../icons/NixOS.png}" "NixOS" "garbage collection completed"
      else
        notify-send -u low -i "${../icons/NixOS.png}" "NixOS" "garbage collection failed"
      fi
    '')

    (writeShellScriptBin "rebuild-nix" ''
      if sudo nixos-rebuild switch --flake "$HOME/dots-nix#$HOST"; then
        notify-send -u low -i "${../icons/NixOS.png}" "NixOS" "rebuild completed"
      else
        notify-send -u normal -i "${../icons/NixOS.png}" "NixOS" "rebuild failed"
      fi
    '')

    (writeShellScriptBin "nvim-clean" ''
      rm -rf "$HOME/.config/nvim"
    '')

    (writeShellScriptBin "nvim-test" ''
      nvim-clean
      rsync -avz --copy-links --chmod=D2755,F744 "$HOME/dots-nix/home/apps/nvim" "$HOME/.config"
    '')
  ];
}
