{
  pkgs,
  config,
  osConfig,
  username,
  ...
}:
let
  # key = "";
  email = "114330858+sickle-phin@users.noreply.github.com";

in
# signersFile = pkgs.writeText "git-allowed-signers" ''
#   ${email} namespaces="git" ${key}
# '';
{
  home.packages = [ pkgs.gh ];

  programs.git = {
    enable = true;
    userName = "${username}";
    userEmail = email;
    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
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
      gpg.format = "ssh";
    };
  };
}
