{ pkgs
, ...
}: {
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;

    userName = "sickle-phin";
    userEmail = "114330858+sickle-phin@users.noreply.github.com ";
    delta.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
