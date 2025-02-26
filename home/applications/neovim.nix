{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = builtins.attrValues {
      inherit (pkgs)
        # nix
        nil
        nixfmt-rfc-style

        # bash
        bash-language-server
        shfmt

        # lua
        lua-language-server
        stylua

        # python
        pyright
        ruff

        # javascript, typescript
        # biome

        # c, c++
        clang-tools

        #rust
        rust-analyzer
        clippy
        rustfmt

        # for copilot
        nodejs-slim
        ;
    };
  };

  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
