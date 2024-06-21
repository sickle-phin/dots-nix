{ pkgs
, ...
}: {
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;

    userName = "sickle-phin";
    userEmail = "114330858+sickle-phin@users.noreply.github.com ";
    delta = {
      enable = true;
      catppuccin.enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
      core.askpass = "git-gui--askpass";
    };
  };
}
