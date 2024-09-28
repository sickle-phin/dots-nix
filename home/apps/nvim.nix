{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
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
