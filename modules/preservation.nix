{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkIf;
in
{
  config = mkIf config.preservation.enable {
    environment.systemPackages = [
      # sudo ncdu -x
      pkgs.ncdu
    ];

    fileSystems."/persistent".neededForBoot = true;

    preservation.preserveAt."/persistent" = {
      directories = [
        {
          directory = "/etc/NetworkManager/system-connections";
          mode = "0700";
        }

        "/root/.cache/nix"

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
          directory = "/var/lib/AccountsService";
          mode = "0775";
        }
        "/var/lib/alsa"
        {
          directory = "/var/lib/bluetooth";
          mode = "0700";
        }
        "/var/lib/btrfs"
        "/var/lib/cups"
        {
          directory = "/var/lib/dms-greeter";
          mode = "0750";
          user = "greeter";
          group = "greeter";
        }
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
        "/var/lib/nftables"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
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
        "/var/lib/waydroid"
        "/var/log"
        "/var/tmp"
      ];

      files = [
        "/etc/adjtime"
        {
          file = "/etc/machine-id";
          inInitrd = true;
          how = "symlink";
          configureParent = true;
        }
      ];

      users.${username} = {
        commonMountOptions = [
          "x-gvfs-hide"
        ];

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
            directory = ".android";
            mode = "0750";
          }
          {
            directory = ".gnupg";
            mode = "0700";
          }
          ".mozilla"
          {
            directory = ".pki";
            mode = "0700";
          }
          ".thunderbird"
          ".ollama"
          {
            directory = ".ssh";
            mode = "0700";
          }
          ".steam"

          ".cache/bat"
          ".cache/BraveSoftware"
          ".cache/DankMaterialShell"
          ".cache/dms"
          ".cache/dms-clipboard"
          ".cache/fastfetch"
          ".cache/fontconfig"
          ".cache/gtk-4.0"
          ".cache/lua-language-server"
          ".cache/mesa_shader_cache"
          ".cache/mpv"
          ".cache/nix"
          ".cache/nvim"
          ".cache/pre-commit"
          ".cache/qtshadercache-x86_64-little_endian-lp64"
          ".cache/quickshell"
          ".cache/thunderbird"
          ".cache/uv"
          ".cache/wal"
          ".cache/waydroid-helper"
          ".cache/yarn"
          ".cache/yt-dlp"
          ".cache/zen"

          ".config/bat"
          ".config/btop/themes"
          ".config/BraveSoftware"
          ".config/cava"
          ".config/DankMaterialShell"
          ".config/dconf"
          ".config/dgop"
          ".config/gh"
          ".config/ghostty/themes"
          ".config/github-copilot"
          ".config/gtk-3.0"
          ".config/gtk-4.0"
          ".config/hypr/dms"
          ".config/libreoffice"
          ".config/mozc"
          ".config/nvim"
          ".config/pulse"
          ".config/qt5ct"
          ".config/qt6ct"
          ".config/Slack"
          ".config/teams-for-linux"
          ".config/vesktop"
          ".config/yazi"
          ".config/zen"
          ".config/zsh"

          ".local/share/applications"
          ".local/share/color-schemes"
          ".local/share/containers"
          ".local/share/direnv"
          ".local/share/fcitx5/themes/matugen"
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
          ".local/share/uv"
          ".local/share/vulkan"
          ".local/share/waydroid"
          ".local/share/waydroid-helper"
          ".local/share/zoxide"

          ".local/state/DankMaterialShell"
          ".local/state/home-manager"
          ".local/state/lazygit"
          ".local/state/nix"
          ".local/state/nix-output-monitor"
          ".local/state/nvim"
          ".local/state/wireplumber"
          ".local/state/zsh"
        ]
        ++ optionals (config.myOptions.gpu.vendor == "nvidia") [
          {
            directory = ".nv";
            mode = "0700";
          }
          ".local/cache/nvidia"
        ];

        files = [
        ];
      };
    };

    systemd = {
      tmpfiles.settings.preservation =
        let
          permission = {
            user = username;
            group = "users";
            mode = "0755";
          };
        in
        {
          "/home/${username}/.cache".d = permission;
          "/home/${username}/.config".d = permission;
          "/home/${username}/.local".d = permission;
          "/home/${username}/.local/share".d = permission;
          "/home/${username}/.local/state".d = permission;
        };

      suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      services.systemd-machine-id-commit = {
        unitConfig.ConditionPathIsMountPoint = [
          ""
          "/persistent/etc/machine-id"
        ];
        serviceConfig.ExecStart = [
          ""
          "systemd-machine-id-setup --commit --root /persistent"
        ];
      };
    };
  };
}
