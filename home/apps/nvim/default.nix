{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      nil
      nixfmt-rfc-style
      lua-language-server
      stylua
      clang-tools
      pyright
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };
}
