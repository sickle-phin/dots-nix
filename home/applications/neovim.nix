{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  home.packages = builtins.attrValues {
    inherit (pkgs)
      # nix
      nixd
      nixfmt

      # bash
      bash-language-server
      shfmt

      # lua
      lua-language-server
      stylua

      # python
      # pyright
      # ruff

      # javascript, typescript
      # biome

      # c, c++
      # clang-tools

      #rust
      # rust-analyzer
      # clippy
      # rustfmt

      # for copilot
      copilot-language-server
      ;

    inherit (pkgs.qt6Packages)
      # qml
      qtdeclarative
      ;
  };

  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
