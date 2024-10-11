{ config, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    enableCompletion = false; # already enabled at nixos module
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true;
    };
    history = {
      path = "${config.xdg.stateHome}/zsh_history";
      ignorePatterns = [
        "cd"
        "ll"
        "ls"
        "mv"
        "rm"
        "rmdir"
        "z"
      ];
    };

    shellAliases = {
      cat = "bat";
      cp = "cp -iv";
      du = "dust";
      ls = "lsd -Fg --group-directories-first --date \"+%F %T\"";
      ll = "lsd -Fgl --group-directories-first --date \"+%F %T\"";
      la = "lsd -AFg --group-directories-first --date \"+%F %T\"";
      lt = "lsd -Fg --group-directories-first --tree --date \"+%F %T\"";
      lla = "lsd -FglA --group-directories-first --date \"+%F %T\"";
      llt = "lsd -Fgl --group-directories-first --tree --date \"+%F %T\"";
      mv = "mv -iv";
      neofetch = "fastfetch";
      grep = "rg";
      g = "git";
      sudo = "sudo ";
      v = "nvim";
      rebuild-nixos = "sudo ls /dev/null > /dev/null 2>&1 && gamemoderun rebuild-nixos";
      rm = "rm -iv";
      open = "xdg-open";
      y = "yazi";
    };
    initExtra = ''
      bindkey "^[[3~" delete-char

      function osc7-pwd() {
        emulate -L zsh # also sets localoptions for us
        setopt extendedglob
        local LC_ALL=C
        printf '\e]7;file://%s%s\e\' $HOST ''${PWD//(#m)([^@-Za-z&-;_~])/%''${(l:2::0:)$(([##16]#MATCH))}}
      }

      function chpwd-osc7-pwd() {
        (( ZSH_SUBSHELL )) || osc7-pwd
      }
      add-zsh-hook -Uz chpwd chpwd-osc7-pwd

      if [[ "$TERM" == *"foot"* && "$HOST" == *"labo"* ]]; then
        fastfetch --raw ${./sickle.sixel} --logo-width 5 --logo-height 5 --logo-padding-top 1 --logo-padding-left 1
      elif [[ "$TERM" == *"foot"* ]]; then
        fastfetch --raw ${./sickle.sixel} --logo-width 9 --logo-height 6 --logo-padding-top 1 --logo-padding-left 1
      else
        fastfetch
      fi
    '';
  };
}
