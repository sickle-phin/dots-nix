{ inputs
, pkgs
, lib
, ...
}:
let
  username = "sickle-phin";
in
{
  # ============================= User related =============================

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sickle-phin = {
    isNormalUser = true;
    description = "sickle-phin";
    hashedPassword = "$6$MeGf7PiZtuFLm1QG$RSwwGRIJdyERl5v4EDuJxYrARnlAtbLM5bYcySWZ5yuyRboYbOzeP9S2jF48c3rVwjE/159EOqWkhIf7mhAZX0";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    #openssh.authorizedKeys.keys = [
    #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJx3Sk20pLL1b2PPKZey2oTyioODrErq83xG78YpFBoj admin@ryan-MBP"
    #];
  };
  users.mutableUsers = false;
  # given the users in this list the right to specify additional substituters via:
  #    1. `nixConfig.substituers` in `flake.nix`
  #    2. command line args `--options substituers http://xxx`
  nix.settings.trusted-users = [ username ];

  # customise /etc/nix/nix.conf declaratively via `nix.settings`
  nix.settings = {
    # enable flakes globally
    experimental-features = [ "nix-command" "flakes" ];

    substituters = [
      "https://cache.nixos.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
    builders-use-substitutes = true;
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  fonts = {
    packages = with pkgs; [
      font-awesome
      noto-fonts
      noto-fonts-cjk
      # noto-fonts-emoji

      "${pkgs.fetchzip {
        url = "https://github.com/yuru7/PlemolJP/releases/download/v1.7.1/PlemolJP_NF_v1.7.1.zip";
        sha256 = "0w9p2kmkcycv7nir4p03hywk514jprnb5grc17w9rszcf9lay4cz";
      }}"
      (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    enableDefaultPackages = true;

    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Apple Color Emoji" ];
      sansSerif = [ "Noto Sans CJK JP" "Noto Sans" "Apple Color Emoji" ];
      monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" "Apple Color Emoji" ];
      emoji = [ "Apple Color Emoji" ];
    };
  };
  programs.dconf.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm = {
      wayland.enable = true;
      theme = "breeze";
    };
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.zsh.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GDK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    XCURSOR_SIZE = "24";
    GDK_BACKEND = "wayland,x11";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.power-profiles-daemon = {
    enable = true;
  };
  security.polkit.enable = true;

  services = {
    dbus.packages = [ pkgs.gcr ];

    geoclue2.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };
}
