host := `hostname`

default:
  just --list

@up:
  nix profile upgrade '.*' || \
  (notify-send -u normal -i "$HOME/.config/mako/icons/NixOS.png" "update failed(pink)" && exit 1)
  nix flake update || \
  (notify-send -u normal -i "$HOME/.config/mako/icons/NixOS.png" "update failed(pink)" && exit 1)
  notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "update completed"

@gc:
  # garbage collect all unused nix store entries
  sudo nix-collect-garbage --delete-old
  nix-collect-garbage --delete-old
  nix store gc --debug
  notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "garbage collection completed"

@rebuild:
  sudo nixos-rebuild switch --flake ~/dots-nix#{{host}} || \
  (notify-send -u normal -i "$HOME/.config/mako/icons/NixOS.png" "rebuild failed" && exit 1)
  notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "rebuild completed"

hyprland-clean:
  rm -f ${HOME}/.config/hypr/hyprland.conf

hyprland-test: hyprland-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/desktop/hyprland/hyprland.conf ${HOME}/.config/hypr

nvim-clean:
  rm -rf ${HOME}/.config/nvim

nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/nvim/nvim ${HOME}/.config
