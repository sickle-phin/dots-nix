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
      nil
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
      nodejs-slim
      ;

    inherit (pkgs.kdePackages)
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
