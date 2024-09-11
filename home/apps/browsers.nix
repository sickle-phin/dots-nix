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
      languagePacks = [ "ja" ];
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        settings = {
          "app.update.auto" = false;
          "intl.accept_languages" = "ja, en-US, en";
          "intl.locale.requested" = "ja";

          # reference: https://github.com/arkenfox/user.js/blob/master/user.js
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

          "network.proxy.socks_remote_dns" = true;
          "network.file.disable_unc_paths" = true;
          "network.gio.supported-protocols" = "";

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

          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "signon.formlessCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;

          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.privacy_level" = 2;
          "browser.shell.shortcutFavicons" = false;

          "security.ssl.require_safe_negotiation" = true;
          "security.tls.enable_0rtt_data" = false;
          "security.OCSP.enabled" = 1;
          "security.OCSP.require" = true;
          "security.cert_pinning.enforcement_level" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;

          "network.http.referer.XOriginTrimmingPolicy" = 2;

          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;

          "dom.disable_window_move_resize" = true;

          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "browser.uitour.url" = "";
          "devtools.debugger.remote-enabled" = false;
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";
          "network.IDN_show_punycode" = true;
          "pdfjs.disabled" = false;
          "pdfjs.enableScripting" = false;
          "browser.tabs.searchclipboardfor.middleclick" = true;
          "browser.contentanalysis.enabled" = false;
          "browser.contentanalysis.default_result" = 0;
          "browser.download.useDownloadDir" = false;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.manager.addToRecentDocs" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "extensions.enabledScopes" = 5;
          "extensions.postDownloadThirdPartyPrompt" = false;

          "browser.contentblocking.category" = "strict";

          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown_v2.cache" = true;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
          "privacy.clearSiteData.cache" = true;
          "privacy.clearSiteData.cookiesAndStorage" = false;
          "privacy.clearSiteData.historyFormDataAndDownloads" = true;
          "privacy.clearSiteData.siteSettings" = false;
          "privacy.cpd.cache" = true;
          "privacy.clearHistory.cache" = true;
          "privacy.cpd.formdata" = true;
          "privacy.cpd.history" = true;
          "privacy.clearHistory.historyFormDataAndDownloads" = true;
          "privacy.cpd.cookies" = false;
          "privacy.cpd.sessions" = true;
          "privacy.cpd.offlineApps" = false;
          "privacy.clearHistory.cookiesAndStorage" = false;
          "privacy.sanitize.timeSpan" = 0;

          # reference https://github.com/yokoffing/Betterfox
          "content.notify.interval" = 100000;
          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "browser.cache.jsbc_compression_level" = 3;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheExpiration" = 3600;
          "network.ssl_tokens_cache_capacity" = 10240;
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "dom.security.sanitizer.enabled" = true;

          "apz.overscroll.enabled" = true;
          "general.smoothScroll" = true;
          "general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS" = 12;
          "general.smoothScroll.msdPhysics.enabled" = true;
          "general.smoothScroll.msdPhysics.motionBeginSpringConstant" = 600;
          "general.smoothScroll.msdPhysics.regularSpringConstant" = 650;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaMS" = 25;
          "general.smoothScroll.msdPhysics.slowdownMinDeltaRatio" = "2";
          "general.smoothScroll.msdPhysics.slowdownSpringConstant" = 250;
          "general.smoothScroll.currentVelocityWeighting" = "1";
          "general.smoothScroll.stopDecelerationWeighting" = "1";
          "mousewheel.default.delta_multiplier_y" = 250;

          "browser.tabs.hoverPreview.enabled" = true;
          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;
          "browser.warnOnQuit" = false;
          "browser.quitShortcut.disabled" = if pkgs.stdenv.isLinux then true else false;
          "browser.tabs.allow_transparent_browser" = true;
          "browser.theme.dark-private-windows" = true;
          "browser.toolbars.bookmarks.visibility" = false;
          "trailhead.firstrun.didSeeAboutWelcome" = false; # Disable welcome splash
          "dom.forms.autocomplete.formautofill" = false; # Disable autofill
          "dom.payments.defaults.saveAddress" = false; # Disable address save
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
