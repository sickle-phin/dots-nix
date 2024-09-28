{
  pkgs,
  osConfig,
  username,
  ...
}:
{
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = "114330858+sickle-phin@users.noreply.github.com";
    signing = {
      key = osConfig.myOptions.signingKey;
      signByDefault = true;
    };
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
    };
  };
}
