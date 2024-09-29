{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = builtins.attrValues {
      inherit (pkgs)
        nil
        nixfmt-rfc-style
        bash-language-server
        shfmt
        lua-language-server
        stylua
        pyright
        ruff
        clang-tools
        rust-analyzer
        clippy
        rustfmt
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
