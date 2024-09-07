{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  environment.systemPackages = [
    # sudo ncdu -x
    pkgs.ncdu
  ];

  environment.persistence."/persistent" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      "/etc/nix/inputs"
      "/etc/secureboot"

      "/var/log"
      "/var/lib"
      "/var/tmp"
      "/var/cache"
      "/var/db/dhcpcd"
      "/var/db/sudo/lectured"

      "/root/.local/share"
      "/root/.cache"
    ];
    files = [
      "/etc/machine-id"
      "/etc/adjtime"
    ];

    # the following directories will be passed to /persistent/home/$USER
    users.${username} = {
      directories = [
        "dots-nix"
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Public"
        "Templates"
        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }

        # misc
        ".config/Bitwarden"
        ".config/Slack"
        ".config/pulse"
        ".config/teams-for-linux"
        ".config/vesktop"
        ".config/zsh"
        ".pki"
        ".steam"

        # browsers
        ".mozilla"
        ".config/BraveSoftware"

        ".local/share"
        ".local/state"
        ".local/cache"

        ".config/github-copilot"
      ];
      files = [ ];
    };
  };
}
