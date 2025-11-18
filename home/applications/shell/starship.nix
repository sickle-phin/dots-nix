{ config, lib, ... }:
{
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [
        "[╭─](purple)"
        "[░▒▓](blue)"
        "[ 󱢴 ](bg:blue fg:black)"
        "[](bg:cyan fg:blue)"
        "$directory"
        "[ ](fg:cyan bg:black)"
        "$git_branch"
        "$git_status"
        "[ ](fg:black)"
        "$line_break"
        "[╰─](purple)"
        "$character"
      ];
      directory = {
        style = "fg:black bg:cyan bold";
        format = "[ $path ]($style)";
        truncation_length = 5;
        truncation_symbol = "…/";
      };
      git_branch = {
        symbol = " ";
        style = "fg:yellow bg:black";
        format = "[$symbol$branch(:$remote_branch) ]($style)";
      };
      git_status = {
        style = "fg:yellow bg:black";
        format = "[($all_status$ahead_behind )]($style)";
      };
    };
  };
}
