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
      ls = "lsd -F";
      ll = "lsd -Fl --date \"+%F %T UTC%z\"";
      la = "lsd -AF";
      lt = "lsd -F --tree";
      lla = "lsd -FlA --date \"+%F %T UTC%z\"";
      llt = "lsd -Fl --tree --date \"+%F %T UTC%z\"";
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
      elif [[ "$TERM" == *"foot"* ]]; then
          fastfetch --raw ${./sickle.sixel} --logo-width 9 --logo-height 6 --logo-padding-top 1 --logo-padding-left 1
      else
          fastfetch
      fi
    '';
  };
}