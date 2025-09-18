{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib.modules) mkForce;
in
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

    shellAliases = {
      bat = "bat --pager 'less -FR'";
      cat = "bat --pager 'less -FR'";
      cp = "cp -iv";
      du = "dust";
      ls = mkForce "lsd -Fg --group-directories-first --date \"+%F %T\"";
      ll = mkForce "lsd -Fgl --group-directories-first --date \"+%F %T\"";
      la = mkForce "lsd -AFg --group-directories-first --date \"+%F %T\"";
      lt = mkForce "lsd -Fg --group-directories-first --tree --date \"+%F %T\"";
      lla = mkForce "lsd -FglA --group-directories-first --date \"+%F %T\"";
      llt = mkForce "lsd -Fgl --group-directories-first --tree --date \"+%F %T\"";
      mv = "mv -iv";
      neofetch = "fastfetch";
      mozc_tool = "${pkgs.mozc}/lib/mozc/mozc_tool";
      grep = "rg";
      g = "git";
      sudo = "sudo ";
      v = "nvim";
      rebuild-nixos = "sudo ls /dev/null > /dev/null 2>&1 && gamemoderun rebuild-nixos";
      rm = "rm -iv";
      open = "xdg-open";
      y = "LANG=ja_JP.UTF-8 yazi";
      yazi = "LANG=ja_JP.UTF-8 yazi";
    };

    initContent = ''
      source '${config.xdg.cacheHome}/theme/zsh-syntax-highlighting.zsh' 2>/dev/null
      LANG=en_US.UTF-8

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

      if [[ "$TERM" == *"xterm-ghostty"* ]]; then
        fastfetch --kitty ${../../desktop/icons/sickle-phin.png} --logo-width 11 --logo-height 5 --logo-padding-top 1 --logo-padding-right 1
      else
        fastfetch
      fi
    '';
  };
}
