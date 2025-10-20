{
  pkgs,
  config,
  osConfig,
  username,
  ...
}:
let
  key = osConfig.myOptions.ssh.publicKey;
  email = "114330858+sickle-phin@users.noreply.github.com";
  signersFile = "${email} namespaces=\"git\" ${key}";
in
{
  home.packages = [ pkgs.gh ];

  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "${username}";
          email = email;
        };
        init.defaultBranch = "main";
        gpg = {
          format = "ssh";
          ssh.allowedSignersFile = signersFile;
        };
      };
      signing = {
        key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        signByDefault = true;
      };
    };

    lazygit = {
      enable = true;
    };
  };
}
