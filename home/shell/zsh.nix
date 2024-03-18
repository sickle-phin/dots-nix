{ pkgs
, ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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
      r = "sudo nixos-rebuild switch --flake ~/dots-nix/";
      rm = "rm -iv";
    };
    initExtra = ''
          if [[ "$TERM" == *"wezterm"* ]]; then
          fastfetch --kitty ~/.config/hypr/images/sickle-phin.face.icon --logo-width 10 --logo-height 5 --logo-padding-top 1 
      else
          fastfetch
      fi
    '';
  };
}
