{ pkgs
, config
, ...
}: {
  programs = {
    google-chrome = {
      enable = true;
      commandLineArgs = [
        "--enable-wayland-ime"
        "--gtk-version=4"
      ];
    };

    vivaldi = {
      enable = true;
      commandLineArgs = [
        "--enable-wayland-ime"
        "--gtk-version=4"
      ];
    };

    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "app.update.auto" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.warnOnQuit" = false;
          "browser.quitShortcut.disabled" = if pkgs.stdenv.isLinux then true else false;
          "browser.theme.dark-private-windows" = true;
          "browser.toolbars.bookmarks.visibility" = false;
          "browser.startup.page" = 3; # Restore previous session
          "browser.newtabpage.enabled" = false; # Make new tabs blank
          "trailhead.firstrun.didSeeAboutWelcome" = false; # Disable welcome splash
          "dom.forms.autocomplete.formautofill" = false; # Disable autofill
          "dom.payments.defaults.saveAddress" = false; # Disable address save
          "extensions.formautofill.creditCards.enabled" = false; # Disable credit cards
          "general.autoScroll" = true; # Drag middle-mouse to scroll
          "services.sync.prefs.sync.general.autoScroll" = false; # Prevent disabling autoscroll
          "extensions.pocket.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userChrome.css
          "layout.css.color-mix.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true; # Enable hardware video acceleration
          "cookiebanners.ui.desktop.enabled" = false; # Reject cookie popups
          "devtools.command-button-screenshot.enabled" = true; # Scrolling screenshot of entire page
          "svg.context-properties.content.enabled" = true; # Sidebery styling
        };
      };
    };
  };
}
