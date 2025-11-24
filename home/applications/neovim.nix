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
      gcc
      gnumake
      yarn

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
  };

  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
