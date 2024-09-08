{
  lib,
  pkgs,
  osConfig,
  ...
}:
with lib;
{
  programs = {
    brave = {
      enable = true;
      commandLineArgs = [
        "--enable-wayland-ime"
      ];
      extensions = [
        { id = "bkkmolkhemgaeaeggcmfbghljjjoofoh"; } # Catppuccin Chrome Theme - Mocha
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium C
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      ];
    };

    firefox = {
      enable = true;
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          # reference: https://github.com/arkenfox/user.js/blob/master/user.js
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

          "network.prefetch-next" = false;
          "network.dns.disablePrefetch" = true;
          "network.dns.disablePrefetchFromHTTPS" = true;
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;
          "network.http.speculative-parallel-limit" = 0;
          "browser.places.speculativeConnect.enabled" = false;

          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.urlbar.quicksuggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.searches" = false;
          "browser.urlbar.trending.featureGate" = false;
          "browser.urlbar.addons.featureGate" = false;
          "browser.urlbar.mdn.featureGate" = false;
          "browser.urlbar.pocket.featureGate" = false;
          "browser.urlbar.weather.featureGate" = false;
          "browser.urlbar.yelp.featureGate" = false;
          "browser.formfill.enable" = false;
          "browser.search.separatePrivateDefault" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;

          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;

          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.privacy_level" = 2;

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
          "gfx.webrender.super-resolution.nvidia" = mkIf (osConfig.myOptions.gpu == "nvidia") true;
          "gfx.webrender.overlay-vp-auto-hdr" = mkIf (osConfig.myOptions.gpu == "nvidia") true;
          "gfx.webrender.overlay-vp-super-resolution" = mkIf (osConfig.myOptions.gpu == "nvidia") true;
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
