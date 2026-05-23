##  Dotfiles of NixOS

## Components

|                                                                | NixOS(Wayland)                                                                                                      |
| -------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| **Bootloader**                                                 | [Limine][Limine]                                                                                                    |
| **Filesystem & Encryption**                                    | tmpfs as `/`, [Btrfs][Btrfs] subvolumes on a [LUKS][LUKS] encrypted partition                                       |
| **Wayland Compositer**                                         | [Hyprland][Hyprland]                                                                                                |
| **Desktop Shell**                                              | [DankMaterialShell][DankMaterialShell]                                                                              |
| **Input Method Framework**                                     | [Fcitx5][Fcitx5] + [Hazkey][Hazkey]                                                                                 |
| **Terminal Emulator**                                          | [Ghostty][Ghostty]                                                                                                  |
| **Shell**                                                      | [Zsh][Zsh] + [Starship][Starship]                                                                                   |
| **Editor**                                                     | [Neovim][Neovim]                                                                                                    |

## References
- [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
- [isabelroses/dotfiles](https://github.com/isabelroses/dotfiles)
- [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)

[Limine]: https://github.com/limine-bootloader/limine
[Btrfs]: https://btrfs.readthedocs.io
[LUKS]: https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system
[Hyprland]: https://github.com/hyprwm/Hyprland
[DankMaterialShell]: https://github.com/AvengeMedia/DankMaterialShell
[Fcitx5]: https://github.com/fcitx/fcitx5
[Hazkey]: https://github.com/7ka-Hiira/hazkey
[Ghostty]: https://github.com/ghostty-org/ghostty
[Zsh]: https://sourceforge.net/p/zsh/code/ci/master/tree/
[Starship]: https://github.com/starship/starship
[Neovim]: https://github.com/neovim/neovim
