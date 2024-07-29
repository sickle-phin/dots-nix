{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      catppuccin.enable = true;
    };
    history = {
      path = "$XDG_STATE_HOME/zsh_history";
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
      grep = "rg";
      g = "git";
      j = "just";
      sudo = "sudo ";
      v = "nvim";
      rm = "rm -iv";
      y = "yazi";
    };
    initExtra = ''
      bindkey "^[[3~" delete-char

      export FZF_DEFAULT_OPTS=" \
        --color=bg+:#313244,spinner:#f5e0dc,hl:#f38ba8 \
        --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
        --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

      if [[ "$TERM" == *"wezterm"* ]]; then
          fastfetch --iterm ${../../../system/sickle-phin.face.icon} --logo-width 10 --logo-height 5 --logo-padding-top 1
      elif [[ "$TERM" == *"foot"* && "$HOST" == *"labo"* ]]; then
          fastfetch --raw ${./sickle.sixel} --logo-width 5 --logo-height 5 --logo-padding-top 1 --logo-padding-left 1
      elif [[ "$TERM" == *"foot"* ]]; then
          fastfetch --raw ${./sickle.sixel} --logo-width 9 --logo-height 6 --logo-padding-top 1 --logo-padding-left 1
      else
          fastfetch
      fi
    '';
  };
}
