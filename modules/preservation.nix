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

          ".config/bat"
          ".config/BraveSoftware"
          ".config/dconf"
          ".config/gh"
          ".config/github-copilot"
          ".config/libreoffice"
          ".config/mozc"
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
          ".local/cache/lua-language-server"
          ".local/cache/mesa_shader_cache"
          ".local/cache/mozilla"
          ".local/cache/mpv"
          ".local/cache/nix"
          ".local/cache/nix-output-monitor"
          ".local/cache/nvim"
          ".local/cache/pre-commit"
          ".local/cache/qtshadercache-x86_64-little_endian-lp64"
          ".local/cache/silicon"
          ".local/cache/swww"
          ".local/cache/thunderbird"
          ".local/cache/uv"
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
          ".local/share/uv"
          ".local/share/vulkan"
          ".local/share/zoxide"

          ".local/state/home-manager"
          ".local/state/lazygit"
          ".local/state/nix"
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
          "/home/${username}/.config".d = permission;
          "/home/${username}/.local".d = permission;
          "/home/${username}/.local/cache".d = permission;
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
