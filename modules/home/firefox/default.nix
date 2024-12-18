{ config, lib, pkgs, inputs, ... }:

{
  options = {
	firefox.enable = lib.mkEnableOption "enable and configure Firefox browser";
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
	  enable = true;
	  package = pkgs.firefox;
	  profiles.bdface = {
		extraConfig = ''
		  user_pref("extensions.autoDisableScopes", 0);
		  user_pref("extensions.enabledScopes", 15); 
		'';
		extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
		  ublock-origin
		  bitwarden
		  return-youtube-dislikes
		  #bypass-paywalls-clean
		  sponsorblock
		  canvasblocker
		];
		search = {
		  default = "DuckDuckGo";
		  privateDefault = "DuckDuckGo";
		  force = true;
		  order = [
		  "DuckDuckGo"
		  "Bing"
		  "Google"
		  "Amazon"
		  ];
		  engines = {
		  "Bing".metaData.hidden = true;
		  "Google".metaData.hidden = true;
		  "Amazon".metaData.hidden = true;
		  };
		};
		settings = {
		  "browser.contentblocking.category" = "strict";
		  "identity.fxaccounts.enabled" = false;
		  "browser.search.update" = false;
		  "browser.urlbar.quicksuggest.enabled" = false;
		  "browser.formfill.enabled" = false;
		  "app.shield.optoutstudies.enabled" = false;
		  "app.normandy.enabled" = false;
		  "extensions.pocket.enabled" = false;
		  "browser.download.open_pdf_attachments_inline" = false;
		  "sidebar.verticalTabs" = true;
		  "datareporting.policy.dataSubmissingEnabled" = false;
		  "datareporting.healthreport.uploadEnabled" = false;
		  "toolkit.telemetry.unified" = false;
		  "toolkit.telemetry.enabled" = false;
		  "toolkit.telemetry.server" = "data:,";
		  "toolkit.telemetry.archive.enabled" = false;
		  "toolkit.telemetry.newProfilePing.enabled" = false;
		  "toolkit.telemetry.updatePing.enabled" = false;
		  "toolkit.telemetry.bhrPing.enabled" = false;
		  "toolkit.telemetry.firstShutDownPing.enabled" = false;
		  "toolkit.telemetry.coverage.opt-out" = true;
		  "toolkit.coverage.opt-out" = true;
		  "toolkit.coverage.endpoint.base" = "";
		  "browser.newtabpage.activity-stream.feeds.telemetry" = false;
		  "browser.newtabpage.activity-stream.telemetry" = false;
		  "breakpad.reportURL" = "";
		  "browser.tabs.crashReporting.sendReport" = false;
		  "extensions.getAddons.showPane" = false;
		  "extensions.htmlaboutaddons.recommendations.enabled" = false;
		  "browser.discovery.enabled" = false;
		  "browser.shell.checkDefaultBrowser" = false;
		  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
		  "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
		  "browser.newtabpage.activity-stream.feeds.topsites" = true;
		  "browser.newtabpage.activity-stream.topSitesRows" = 2;
		  "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
		  "browser.newtabpage.activity-stream.showWeather" = true;
		  "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
		  "browser.preferences.moreFromMozilla" = false;
		  "browser.aboutConfig.showWarning" = false;
		  "browser.aboutwelcome.enabled" = false;
		  "browser.profiles.enabled" = true;
		  "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
		  "browser.compactmode.show" = true;
		  "browser.privateWindowSeparation.enabled" = false;
		  "dom.security.https_first" = true;
		  "signon.rememberSignons" = false;
		  "signon.formlessCapture.enabled" = false;
		  "signon.privateBrowsingCapture.enabled" = false;
		  "extensions.formautofill.creditCards.enabled" = false;
		  "extensions.formautofill.addresses.enabled" = false;
		  "network.auth.subresource-http-auth-allow" = 1;
		  "editor.truncate_user_pastes" = false;
		  "security.mixed_content.block_display_content" = true;
		  "pdfjs.enableScripting" = false;
		  "privacy.userContext.ui.enabled" = true;

		  "content.notify.interval" = 100000;
		  "gfx.canvas.accelerated.cache-items" = 4096;
		  "gfx.canvas.accelerated.cache-size" = 512;
		  "gfx.content.skia-font-cache-size" = 20;
		  "browser.cache.disk.enable" = true;
		  "media.memory_cache_max_size" = 65536;
		  "media.cache_readahead_limit" = 7200;
		  "media.cache_resume_threshold" = 3600;
		  "image.mem.decode_bytes_at_a_time" = 32768;
		  "network.http.max-connections" = 1800;
		  "network.http.max-persistant-connections-per-server" = 10;
		  "network.http.max-urgent-start-excessive-connections-per-host" = 5;
		  "network.http.pacing.requests.enabled" = false;
		  "network.dnsCacheExpiration" = 3600;
		  "network.ssl_tokens_cache_capacity" = 10240;
		  "network.dns.disablePrefetch" = true;
		  "network.dns.disablePrefetchFromHTTPS" = true;
		  "network.prefetch-next" = false;
		  "network.predictor.enabled" = false;
		  "network.predictor.enable.prefetch" = false;
		  "layout.css.grid-template-masonry-value.enabled" = true;
		  "dom.enable_web_task_scheduling" = true;
		};
	  };
	};
  };
}
