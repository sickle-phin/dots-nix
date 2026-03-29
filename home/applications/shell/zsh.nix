{
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    autocd = true;
    history = {
      path = "${config.xdg.stateHome}/zsh/zsh_history";
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

    initContent = ''
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

      function fzf() { 
        (
          source ${config.xdg.configHome}/fzfrc
          $(whence -p fzf) "$@"
        )
      }

      if [[ "$TERM" == *"xterm-ghostty"* ]]; then
        fastfetch --kitty ${../../desktop/icons/sickle-phin.png} --logo-width 11 --logo-height 5 --logo-padding-top 1 --logo-padding-right 1
      else
        fastfetch
      fi
    '';
  };
}
