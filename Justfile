host := `hostname`

default:
  just --list

@up:
  nix profile upgrade '.*' || \
  (notify-send -u normal -i "$HOME/dots-nix/home/desktop/icons/NixOS.png" "NixOS" "update failed(pink)" && exit 1)
  nix flake update || \
  (notify-send -u normal -i "$HOME/dots-nix/home/desktop/icons/NixOS.png" "NixOS" "update failed(pink)" && exit 1)
  notify-send -u low -i "$HOME/dots-nix/home/desktop/icons/NixOS.png" "update completed"

@gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old
  nix-collect-garbage --delete-old
  nix store gc --debug
  notify-send -u low -i "$HOME/dots-nix/home/desktop/icons/NixOS.png" "NixOS" "garbage collection completed"

@rebuild:
  sudo nixos-rebuild switch --flake ~/dots-nix#{{host}} || \
  (notify-send -u normal -i "$HOME/dots-nix/home/desktop/icons/NixOS.png" "NixOS" "rebuild failed" && exit 1)
  notify-send -u low -i "$HOME/dots-nix/home/desktop/icons/NixOS.png" "NixOS" "rebuild completed"

nvim-clean:
  rm -rf ${HOME}/.config/nvim

nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/apps/nvim ${HOME}/.config
