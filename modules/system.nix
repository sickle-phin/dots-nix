{ inputs
, pkgs
, lib
, config
, ...
}:
let
  username = "sickle-phin";
in
{
  users.users.sickle-phin = {
    isNormalUser = true;
    description = "sickle-phin";
    hashedPassword = "$6$MeGf7PiZtuFLm1QG$RSwwGRIJdyERl5v4EDuJxYrARnlAtbLM5bYcySWZ5yuyRboYbOzeP9S2jF48c3rVwjE/159EOqWkhIf7mhAZX0";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.zsh;
    #openssh.authorizedKeys.keys = [
    #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx3Sk20pLL1b2PPKZey2oTyioODrErq83xG78YpFBoj admin@ryan-MBP"
    #];
  };
  users.users.root = {
    hashedPassword = "$6$8iM5vVsSZpG16VT2$Q1OFNAEthuu9kKWKnZR7SOtSxnjOqJ40gaE2Wo8UtEObuSVID.sdF8nVDdGwp8.Vnua05O9HjeGxhiVXMZHsS.";
  };
  users.mutableUsers = false;
  # given the users in this list the right to specify additional substituters via:
  #    1. `nixConfig.substituers` in `flake.nix`
  #    2. command line args `--options substituers http://xxx`
  nix = {
    settings = {
      trusted-users = [ username ];
      experimental-features = [ "nix-command" "flakes" ];

      substituters = [
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];

      builders-use-substitutes = true;
      auto-optimise-store = true;
    };
    gc = {
      automatic = lib.mkDefault true;
      dates = lib.mkDefault "weekly";
      options = lib.mkDefault "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n = {
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      # noto-fonts-emoji
      font-awesome
      migu
      plemoljp-nf
      wqy_zenhei
      (nerdfonts.override { fonts = [ "RobotoMono" ]; })
    ];
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Apple Color Emoji" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" "Apple Color Emoji" ];
        monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" "Apple Color Emoji" ];
        emoji = [ "Apple Color Emoji" ];
      };

      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <description>Change default fonts for Steam client</description>
          <match>
            <test name="prgname">
              <string>steamwebhelper</string>
            </test>
            <test name="family" qual="any">
              <string>sans-serif</string>
            </test>
            <edit mode="prepend" name="family">
              <string>Migu 1P</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
  programs.dconf.enable = true;

  services = {
    xserver.enable = true;
    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "sickle-phin";
      sddm = {
        enable = true;
        wayland.enable = true;
        enableHidpi = true;
        theme = "chili";
        settings.Theme = {
          FacesDir = "/var/lib/AccountsService/icons";
          CursorTheme = "breeze_cursors";
        };
      };
    };
  };

  system.activationScripts.script.text = ''
    mkdir -p /var/lib/AccountsService/icons
    cp /home/sickle-phin/dots-nix/home/desktop/hyprland/images/sickle-phin.face.icon /var/lib/AccountsService/icons
  '';

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.zsh.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = false;
    settings = {
      #X11Forwarding = true;
      #PermitRootLogin = "no"; # disable root login
      #PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
    allowedUDPPorts = [ config.services.tailscale.port ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cpufrequtils
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    sysstat
    lm_sensors # for `sensors` command
    # minimal screen capture tool, used by i3 blur lock to take a screenshot
    # print screen key is also bound to this tool in i3 config
    scrot
    xfce.thunar # xfce4's file manager
    nnn # terminal file manager
    sbctl
    libnotify
    sddm-chili-theme
    breeze-gtk
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true;
  };
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  services = {
    dbus.packages = [ pkgs.gcr ];
    upower.enable = true;

    geoclue2.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;

      lowLatency.enable = true;
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
  powerManagement.cpuFreqGovernor = "schedutil";

  zramSwap = {
    enable = true;
    # one of "lzo", "lz4", "zstd"
    algorithm = "zstd";
    priority = 5;
    memoryPercent = 50;
  };

}
