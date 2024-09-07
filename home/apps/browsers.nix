{ pkgs, ... }:
{
  programs = {
    brave = {
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
          "browser.startup.page" = 3; # Restore previous session
          "browser.startup.homepage" = "about:blank";
          "browser.newtabpage.enabled" = false; # Make new tabs blank
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtabpage.activity-stream.default.sites" = "";
          "browser.provider.use_geoclue" = false;
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.shopping.experience2023.enabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "toolkit.coverage.opt-out" = true;
          "toolkit.coverage.endpoint.base" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "app.shield.optoutstudies.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "browser.safebrowsing.downloads.remote.enabled" = false;
          "browser.warnOnQuit" = false;
          "browser.quitShortcut.disabled" = if pkgs.stdenv.isLinux then true else false;
          "browser.tabs.allow_transparent_browser" = true;
          "browser.theme.dark-private-windows" = true;
          "browser.toolbars.bookmarks.visibility" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = false; # Disable welcome splash
          "dom.forms.autocomplete.formautofill" = false; # Disable autofill
          "dom.payments.defaults.saveAddress" = false; # Disable address save
          "dom.webgpu.enabled" = true; # Enable WebGPU
          "extensions.formautofill.creditCards.enabled" = false; # Disable credit cards
          "general.autoScroll" = true; # Drag middle-mouse to scroll
          "gfx.webrender.all" = true;
          "services.sync.prefs.sync.general.autoScroll" = false; # Prevent disabling autoscroll
          "extensions.pocket.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Allow userChrome.css
          "layout.css.color-mix.enabled" = true;
          "media.ffmpeg.vaapi.enabled" = true; # Enable hardware video acceleration
          "cookiebanners.ui.desktop.enabled" = false; # Reject cookie popups
          "devtools.command-button-screenshot.enabled" = true; # Scrolling screenshot of entire page
          "svg.context-properties.content.enabled" = true; # Sidebery styling
        };
        userChrome = ''
          :root {
            --tabpanel-background-color: transparent;
            background: transparent;
          }
        '';
      };
    };
  };
}
