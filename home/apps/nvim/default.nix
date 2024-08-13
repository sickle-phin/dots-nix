{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      nil
      nixfmt-rfc-style
      # bash-language-server
      shfmt
      lua-language-server
      stylua
      clang-tools
      pyright
      ruff-lsp
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
