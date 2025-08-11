{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
{
  programs = {
    brave = {
      enable = true;
      commandLineArgs = [
        "--enable-features=AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,VaapiOnNvidiaGPUs"
        "--extension-content-verification=enforce_strict"
        "--extensions-install-verification=enforce_strict"
        "--no-default-browser-check"
        "--no-pings"
        "--component-updater=require_encryption"
        "--no-crash-upload"
        "--no-service-autorun"
        "--password-store=gnome-libsecret"
      ];
      extensions = [
        { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # Dark Reader
        { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium C
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
        { id = "ophjlpahpchlmihnnnihgmmeilfjmjjc"; } # LINE
      ];
    };

    firefox = {
      enable = true;
      languagePacks = [ "ja" ];
      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;
        search = {
          force = true;
          default = "ddg";
          privateDefault = "ddg";
          engines = {
            SearXNG = {
              urls = [
                {
                  template = "https://priv.au";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                    {
                      name = "categories";
                      value = "general";
                    }
                  ];
                }
              ];
              icon = "${pkgs.fetchurl {
                url = "https://docs.searxng.org/_static/searxng-wordmark.svg";
                sha256 = "sha256-TwwPUNL+IRRjLY7Xmd466F474vglkvpJUYa+fBwDzFI=";
              }}";
              definedAliases = [ "@sx" ];
            };
          };
        };
        settings = {
          "app.update.auto" = false;
          "intl.accept_languages" = "ja, en-US, en";
          "intl.locale.requested" = "ja";
          "browser.toolbars.bookmarks.visibility" = false;
          "sidebar.verticalTabs" = true;

          # reference: https://github.com/yokoffing/Betterfox
          # reference: https://github.com/arkenfox/user.js/blob/master/user.js
          "nglayout.initialpaint.delay" = 1000;
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
          "network.http.pacing.requests.enabled" = osConfig.myOptions.isLaptop;
          "network.dnsCacheExpiration" = 3600;
          "network.ssl_tokens_cache_capacity" = 10240;
          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "dom.security.sanitizer.enabled" = true;
          "gfx.webrender.all" = true;
          "media.hardware-video-decoding.force-enabled" = true;
          # only windows now
          "gfx.webrender.super-resolution.nvidia" = lib.mkIf (osConfig.myOptions.gpu == "nvidia") true;
          "gfx.webrender.overlay-vp-auto-hdr" = lib.mkIf (osConfig.myOptions.gpu == "nvidia") true;
          "gfx.webrender.overlay-vp-super-resolution" = lib.mkIf (osConfig.myOptions.gpu == "nvidia") true;

          "browser.privatebrowsing.vpnpromourl" = "";
          "browser.shell.checkDefaultBrowser" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.warnOnQuit" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.profiles.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "layout.css.color-mix.enabled" = true;
          "browser.compactmode.show" = true;
          "browser.uidensity" = 1;
          "browser.display.focus_ring_on_anything" = true;
          "browser.display.focus_ring_style" = 0;
          "browser.display.focus_ring_width" = 0;
          "layout.css.prefers-color-scheme.content-override" = 2;
          "browser.theme.dark-private-windows" = false;
          "cookiebanners.service.mode" = 1;
          "cookiebanners.service.mode.privateBrowsing" = 1;
          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = -1;
          "full-screen-api.warning.timeout" = 0;
          "extensions.pocket.enabled" = false;
          "browser.download.open_pdf_attachments_inline" = true;
          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
          "browser.tabs.closeWindowWithLastTab" = false;
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.quitShortcut.disabled" = true;
          "devtools.command-button-screenshot.enabled" = true;

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
          "general.autoScroll" = true;
          "services.sync.prefs.sync.general.autoScroll" = false;

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
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.urlbar.groupLabels.enabled" = false;
          "browser.urlbar.autoFill" = true;
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.searches" = true;
          "browser.urlbar.suggest.history" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.quickactions.enabled" = false;
          "browser.urlbar.shortcuts.quickactions" = false;
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;
          "browser.urlbar.trending.featureGate" = false;
          "browser.urlbar.addons.featureGate" = false;
          "browser.urlbar.mdn.featureGate" = false;
          "browser.urlbar.pocket.featureGate" = false;
          "browser.urlbar.weather.featureGate" = false;
          "browser.urlbar.yelp.featureGate" = false;
          "browser.urlbar.trimHttps" = true;
          "browser.urlbar.untrimOnUserInteraction.featureGate" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.formfill.enable" = false;
          "browser.search.separatePrivateDefault" = true;
          "browser.search.separatePrivateDefault.ui.enabled" = true;

          "signon.rememberSignons" = false;
          "signon.autofillForms" = false;
          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;
          "signon.formlessCapture.enabled" = false;
          "signon.privateBrowsingCapture.enabled" = false;
          "network.auth.subresource-http-auth-allow" = 1;
          "editor.truncate_user_pastes" = false;

          "browser.cache.disk.enable" = false;
          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "media.memory_cache_max_size" = 65536;
          "browser.sessionstore.privacy_level" = 2;
          "browser.sessionstore.interval" = 60000;
          "browser.shell.shortcutFavicons" = false;

          "security.ssl.require_safe_negotiation" = true;
          "security.tls.enable_0rtt_data" = false;
          "security.OCSP.enabled" = 0;
          "security.OCSP.require" = false;
          "security.cert_pinning.enforcement_level" = 2;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "dom.security.https_only_mode" = true;
          "dom.security.https_only_mode_error_page_user_suggestions" = true;
          "dom.security.https_only_mode_send_http_background_request" = false;
          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;

          "network.http.referer.XOriginTrimmingPolicy" = 2;

          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;

          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;

          "dom.disable_window_move_resize" = true;

          "network.cookie.sameSite.noneRequiresSecure" = true;
          "browser.download.start_downloads_in_tmp_dir" = true;
          "browser.helperApps.deleteTempFileOnExit" = true;
          "browser.uitour.enabled" = false;
          "browser.uitour.url" = "";
          "privacy.globalprivacycontrol.enabled" = true;
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
          "extensions.webextensions.restrictedDomains" = "";

          "browser.contentblocking.category" = "strict";
          "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";

          "privacy.history.custom" = true;
          "privacy.sanitize.sanitizeOnShutdown" = true;
          "privacy.clearOnShutdown_v2.historyFormDataAndDownloads" = false;
          "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
          "privacy.clearOnShutdown_v2.cache" = true;
          "privacy.clearOnShutdown_v2.siteSettings" = false;
          "privacy.clearSiteData.historyFormDataAndDownloads" = true;
          "privacy.clearSiteData.cookiesAndStorage" = false;
          "privacy.clearSiteData.cache" = true;
          "privacy.clearSiteData.siteSettings" = false;
          "privacy.clearHistory.historyFormDataAndDownloads" = true;
          "privacy.clearHistory.cookiesAndStorage" = false;
          "privacy.clearHistory.cache" = true;
          "privacy.clearHistory.siteSettings" = false;
          "privacy.sanitize.timeSpan" = 0;

          "privacy.window.maxInnerWidth" = 1600;
          "privacy.window.maxInnerHeight" = 900;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.spoof_english" = 1;
          "browser.display.use_system_colors" = false;
          "browser.link.open_newwindow" = 3;
          "browser.link.open_newwindow.restriction" = 0;

          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.urlbar.showSearchTerms.enabled" = false;

          "WaveFox.Tabs.Shape" = 10;
          "WaveFox.Linux.Transparency.Enabled" = 0;
          "WaveFox.Toolbar.Transparency" = 4;
          "browser.tabs.inTitlebar" = 1;
          "userChrome.TabSeparators.Saturation.Medium.Enabled" = true;
          "svg.context-properties.content.enabled" = true;
          "WaveFox.Icons" = 2;
          "userChrome.icon.panel_full" = true;
          "userChrome.icon.library" = true;
          "userChrome.icon.panel" = true;
          "userChrome.icon.menu" = true;
          "userChrome.icon.context_menu" = true;
          "userChrome.icon.global_menu" = true;
          "userChrome.icon.global_menubar" = true;
          "userChrome.icon.1-25px_stroke" = true;
          "userChrome.icon.account_image_to_right" = true;
          "userChrome.icon.account_label_to_right" = true;
          "userChrome.icon.menu.full" = true;
          "userChrome.icon.global_menu.mac" = true;
          "WaveFox.WebPage.Floating.Enabled" = true;
          "WaveFox.WebPage.Transparency" = 0;
          "browser.tabs.allow_transparent_browser" = 1;
          "WaveFox.WebPage.Background.Saturation" = 3;
        };
      };
    };
  };

  home.file.".mozilla/firefox/default/chrome".source = "${inputs.wavefox}/chrome";
}
