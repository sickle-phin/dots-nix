{ pkgs
, config
, ...
}: {
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
      r = "sudo nixos-rebuild switch --flake ~/dots-nix#pink";
      rm = "rm -iv";
    };
    initExtra = ''
      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"
      fi
      
      if [[ "$TERM" == *"wezterm"* ]]; then
          fastfetch --iterm ~/.config/hypr/images/sickle-phin.face.icon --logo-width 10 --logo-height 5 --logo-padding-top 1
      else
          fastfetch
      fi
    '';
  };
}
