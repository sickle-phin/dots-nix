default:
  just --list

up:
  nix flake update
  @notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "update the flake.lock"

gc:
  # garbage collect all unused nix store entries
  sudo nix store gc --debug
  sudo nix-collect-garbage --delete-old
  @notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "garbage collection done"

pink:
  sudo nixos-rebuild switch --flake ~/dots-nix#pink;
  @notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "rebuild done(pink)"

labo:
  sudo nixos-rebuild switch --flake ~/dots-nix#labo;
  @notify-send -u low -i "$HOME/.config/mako/icons/NixOS.png" "rebuild done(labo)"

hyprland-clean:
  rm -f ${HOME}/.config/hypr/hyprland.conf

hyprland-test: hyprland-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/desktop/hyprland/hyprland.conf ${HOME}/.config/hypr

nvim-clean:
  rm -rf ${HOME}/.config/nvim

nvim-test: nvim-clean
  rsync -avz --copy-links --chmod=D2755,F744 home/nvim/nvim ${HOME}/.config
