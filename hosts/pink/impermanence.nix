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
      "/etc/nix/inputs"
      "/etc/secureboot"
      "/etc/ssh"

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
      "/etc/adjtime"
      "/etc/machine-id"
    ];

    users.${username} = {
      directories = [
        "dots-nix"

        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Public"
        "Templates"
        "Videos"

        {
          directory = ".gnupg";
          mode = "0700";
        }
        ".icons/default"
        ".mozilla"
        ".pki"
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".steam"

        ".config/Bitwarden"
        ".config/BraveSoftware"
        ".config/dconf"
        ".config/gh"
        ".config/github-copilot"
        ".config/hyprpanel"
        ".config/Kvantum"
        ".config/libreoffice"
        ".config/mozc"
        ".config/OpenRGB"
        ".config/pulse"
        ".config/Slack"
        ".config/teams-for-linux"
        ".config/vesktop"
        ".config/zsh"

        ".local/cache/bat"
        ".local/cache/BraveSoftware"
        # ".local/cache/cliphist"
        ".local/cache/fastfetch"
        ".local/cache/fontconfig"
        ".local/cache/gtk-4.0"
        ".local/cache/Hyprland Polkit Agent"
        ".local/cache/lua-language-server"
        ".local/cache/mesa_shader_cache"
        ".local/cache/mesa_shader_cache_db"
        ".local/cache/mozilla"
        ".local/cache/mpv"
        ".local/cache/nix"
        ".local/cache/nix-output-monitor"
        ".local/cache/nvim"
        ".local/share/PrismLauncher"
        ".local/cache/qtshadercache-x86_64-little_endian-lp64"
        ".local/cache/silicon"
        ".local/cache/swww"
        ".local/cache/theme"
        ".local/cache/thunderbird"
        ".local/cache/yarn"
        ".local/cache/yt-dlp"

        ".local/share/applications"
        ".local/share/com.github.Aylur.ags"
        ".local/share/direnv"
        ".local/share/flatpak"
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/mime"
        ".local/share/neovide"
        ".local/share/nix"
        ".local/share/nvim"
        ".local/share/org.localsend.localsend_app"
        ".local/share/sioyek"
        ".local/share/Steam"
        ".local/share/vulkan"
        ".local/share/zoxide"

        ".local/state/home-manager"
        ".local/state/lazygit"
        ".local/state/nix"
        ".local/state/nvim"
        ".local/state/wireplumber"
        ".local/state/yazi"
        ".local/state/zsh"
      ];
      files = [
      ];
    };
  };
}
