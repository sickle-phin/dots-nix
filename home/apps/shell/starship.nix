{ config, lib, ... }:
{
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      format = lib.concatStrings [
        "[╭─](maroon)"
        "[░▒▓](#214165)"
        "[🐬 at ](bg:#214165 fg:maroon)"
        "[  ](bg:#214165 fg:#7EBAE4)"
        "[](bg:blue fg:#214165)"
        "$directory"
        "[ ](fg:blue bg:surface0)"
        "$git_branch"
        "$git_status"
        "[ ](fg:surface0)"
        "$line_break"
        "[╰─](maroon)"
        "$character"
      ];
      directory = {
        style = "fg:surface0 bg:blue bold";
        format = "[ $path ]($style)";
        truncation_length = 5;
        truncation_symbol = "…/";
      };
      git_branch = {
        symbol = " ";
        style = "fg:text bg:surface0";
        format = "[$symbol$branch(:$remote_branch) ]($style)";
      };
      git_status = {
        style = "fg:text bg:surface0";
        format = "[($all_status$ahead_behind )]($style)";
      };
    };
  };
}
