{ pkgs
, ...
}: {
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      cat = "bat";
      du = "dust";
      ls = "lsd -F";
      grep = "rg";
      v = "nvim";
      r = "sudo nixos-rebuild switch --flake ~/dots-nix/";
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
