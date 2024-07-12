{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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
      mv = "mv -iv";
      grep = "rg";
      g = "git";
      j = "just";
      v = "nvim";
      rm = "rm -iv";
    };
    initExtra = ''
      bindkey "^[[3~" delete-char

      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi

      if [[ "$TERM" == *"wezterm"* ]]; then
          fastfetch --iterm /etc/var/lib/sddm/icons/sickle-phin.face.icon --logo-width 10 --logo-height 5 --logo-padding-top 1
      else
          fastfetch
      fi
    '';
  };
}
