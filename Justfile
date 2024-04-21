default:
  just --list

up:
  nix flake update

gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old

pink:
  sudo nixos-rebuild switch --flake ~/dots-nix#pink;

labo:
  sudo nixos-rebuild switch --flake ~/dots-nix#labo;

hyprland-clean:
  rm -f ${HOME}/.config/hypr/hyprland.conf

hyprland-test: hyprland-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/desktop/hyprland/hyprland.conf ${HOME}/.config/hypr

nvim-clean:
  rm -rf ${HOME}/.config/nvim

nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/nvim/nvim ${HOME}/.config
