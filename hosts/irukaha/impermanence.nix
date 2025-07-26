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
      {
        directory = "/etc/NetworkManager/system-connections";
        mode = "0700";
      }
      "/etc/ssh"

      {
        directory = "/var/cache/cups";
        mode = "0710";
        group = "lp";
      }
      {
        directory = "/var/cache/fwupd";
        mode = "0700";
      }
      {
        directory = "/var/cache/ldconfig";
        mode = "0700";
      }
      "/var/cache/libvirt"
      {
        directory = "/var/cache/private";
        mode = "0700";
      }
      {
        directory = "/var/cache/tuigreet";
        user = "greeter";
        group = "greeter";
      }

      "/var/lib/alsa"
      {
        directory = "/var/lib/bluetooth";
        mode = "0700";
      }
      "/var/lib/btrfs"
      "/var/lib/cups"
      {
        directory = "/var/lib/fwupd";
        user = "fwupd-refresh";
        group = "fwupd-refresh";
      }
      {
        directory = "/var/lib/iwd";
        mode = "0700";
      }
      "/var/lib/libvirt"
      "/var/lib/NetworkManager"
      "/var/lib/nixos"
      "/var/lib/plymouth"
      "/var/lib/power-profiles-daemon"
      {
        directory = "/var/lib/private";
        mode = "0700";
      }
      "/var/lib/qemu"
      "/var/lib/sbctl"
      "/var/lib/systemd"
      {
        directory = "/var/lib/tailscale";
        mode = "0700";
      }
      "/var/log"
      "/var/tmp"
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
        ".thunderbird"
        {
          directory = ".ssh";
          mode = "0700";
        }
        ".steam"

        ".config/bat"
        ".config/BraveSoftware"
        ".config/btop"
        ".config/dconf"
        ".config/gh"
        ".config/github-copilot"
        ".config/Kvantum"
        ".config/libreoffice"
        ".config/mozc"
        ".config/pulse"
        ".config/Slack"
        ".config/teams-for-linux"
        ".config/vesktop"
        ".config/wezterm"
        ".config/zsh"

        ".local/cache/bat"
        ".local/cache/BraveSoftware"
        # ".local/cache/cliphist"
        ".local/cache/fastfetch"
        ".local/cache/fontconfig"
        ".local/cache/gtk-4.0"
        ".local/cache/Hyprland Polkit Agent"
        ".local/cache/lua-language-server"
        ".local/cache/mesa_shader_cache_db"
        ".local/cache/mozilla"
        ".local/cache/mpv"
        ".local/cache/nix"
        ".local/cache/nix-output-monitor"
        ".local/cache/nvidia"
        ".local/cache/nvim"
        ".local/cache/pre-commit"
        ".local/cache/qtshadercache-x86_64-little_endian-lp64"
        ".local/cache/silicon"
        ".local/cache/swww"
        ".local/cache/thunderbird"
        ".local/cache/theme"
        ".local/cache/yarn"
        ".local/cache/yt-dlp"

        ".local/share/applications"
        ".local/share/containers"
        ".local/share/direnv"
        ".local/share/icons"
        {
          directory = ".local/share/keyrings";
          mode = "0700";
        }
        ".local/share/mime"
        ".local/share/nix"
        ".local/share/nvim"
        ".local/share/org.localsend.localsend_app"
        ".local/share/PrismLauncher"
        ".local/share/Steam"
        ".local/share/vulkan"
        ".local/share/zoxide"

        ".local/state/home-manager"
        ".local/state/lazygit"
        ".local/state/nix"
        ".local/state/nvim"
        ".local/state/wireplumber"
        ".local/state/zsh"
      ];

      files = [
        ".local/cache/fuzzel"
      ];
    };
  };
}
