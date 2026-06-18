{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkForce mkIf;
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
        {
          directory = "/var/tmp";
          mode = "1777";
        }
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
          {
            directory = ".pki";
            mode = "0700";
          }
          ".thunderbird"
          # ".ollama"
          {
            directory = ".ssh";
            mode = "0700";
          }
          ".steam"

          ".cache/bat"
          ".cache/DankMaterialShell"
          {
            directory = ".cache/danksearch";
            mode = "0700";
          }
          ".cache/dms"
          {
            directory = ".cache/fastfetch";
            mode = "0744";
          }
          ".cache/fontconfig"
          {
            directory = ".cache/google-chrome";
            mode = "0700";
          }
          ".cache/gtk-4.0"
          ".cache/lua-language-server"
          {
            directory = ".cache/mesa_shader_cache";
            mode = "0700";
          }
          ".cache/mpv"
          ".cache/nix"
          ".cache/nvim"
          ".cache/prek"
          ".cache/protonfixes"
          ".cache/qtshadercache-x86_64-little_endian-lp64"
          ".cache/quickshell"
          ".cache/thunderbird"
          ".cache/uv"
          ".cache/wal"
          ".cache/waydroid-helper"
          ".cache/yarn"
          ".cache/yt-dlp"
          {
            directory = ".cache/zen";
            mode = "0700";
          }

          ".config/bat"
          ".config/btop/themes"
          ".config/cava"
          ".config/DankMaterialShell"
          ".config/dconf"
          ".config/dgop"
          ".config/easyeffects"
          ".config/gh"
          ".config/ghostty/themes"
          {
            directory = ".config/github-copilot";
            mode = "0700";
          }
          {
            directory = ".config/google-chrome";
            mode = "0700";
          }
          ".config/gtk-3.0"
          ".config/gtk-4.0"
          ".config/hypr/dms"
          ".config/imv"
          ".config/Kvantum/matugen"
          ".config/libreoffice"
          ".config/nvim"
          ".config/qt6ct"
          {
            directory = ".config/Slack";
            mode = "0700";
          }
          # ".config/teams-for-linux"
          ".config/vesktop"
          ".config/yazi"
          ".config/zen"
          ".config/zsh"

          ".local/share/applications"
          ".local/share/color-schemes"
          ".local/share/containers"
          {
            directory = ".local/share/dankcal";
            mode = "0700";
          }
          ".local/share/direnv"
          ".local/share/fcitx5/themes/matugen"
          ".local/share/icons/hicolor"
          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
          ".local/share/nix"
          {
            directory = ".local/share/nvim";
            mode = "0700";
          }
          ".local/share/org.localsend.localsend_app"
          # ".local/share/PrismLauncher"
          {
            directory = ".local/share/Steam";
            mode = "0700";
          }
          ".local/share/Terraria"
          ".local/share/uv"
          ".local/share/vulkan"
          ".local/share/waydroid"
          ".local/share/waydroid-helper"
          ".local/share/zoxide"

          ".local/state/DankMaterialShell"
          ".local/state/hazkey"
          ".local/state/home-manager"
          ".local/state/lazygit"
          ".local/state/nix"
          ".local/state/nix-output-monitor"
          {
            directory = ".local/state/nvim";
            mode = "0700";
          }
          {
            directory = ".local/state/wireplumber";
            mode = "0700";
          }
          ".local/state/zsh"
        ]
        ++ optionals (config.myOptions.gpu.vendor == "amd") [
          {
            directory = ".cache/radv_builtin_shaders";
            mode = "0700";
          }
        ]
        ++ optionals (config.myOptions.gpu.vendor == "nvidia") [
          {
            directory = ".nv";
            mode = "0700";
          }
          {
            directory = ".cache/nvidia";
            mode = "0700";
          }
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
            mode = "0700";
          };
        in
        {
          "/home/${username}/.cache".d = mkForce permission;
          "/home/${username}/.config".d = mkForce permission;
          "/home/${username}/.local".d = mkForce permission;
          "/home/${username}/.local/share".d = mkForce permission;
          "/home/${username}/.local/state".d = mkForce permission;
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
