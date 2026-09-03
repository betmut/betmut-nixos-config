{inputs, config, hm-pkgs, ...}:{

  stylix.targets.firefox.profileNames = [ "darwin-user" ];
  programs.firefox = {
    enable = true;
    package = hm-pkgs.firefox;
    languagePacks = [ "en-US" "id"];
    policies = {
      # Telemetry, Studies & Experiments
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFeedbackCommands = true;
      DisableDefaultBrowserAgent = true;

      # Enhanced Tracking Protection & Fingerprinting
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
        Category = "strict";
      };

      # Network & Connection Privacy
      NetworkPrediction = false;            # Disables DNS prefetching and speculative connections
      HttpsOnlyMode = "force_enabled";      # Forces HTTPS on all connections

      # Search & History Leaks
      SearchSuggestEnabled = false;         # Prevents typing in the address bar from sending keystrokes to search engines
      DisableFormHistory = true;            # Prevents saving form submissions and search history

      # Automatic Cleanup on Exit (Optional)
      #SanitizeOnShutdown = {
      #  Cache = true;
      # Cookies = false;
      # History = false;
      # Sessions = false;
      #};

      # Permission Prompts (Block unwanted website requests)
      #Permissions = {
      #  Location = { BlockNewRequests = true; };
      #  Notifications = { BlockNewRequests = true; };
      #  Camera = { BlockNewRequests = true; };
      #  Microphone = { BlockNewRequests = true; };
      #};

      # Low-level hardened preferences (about:config)
      Preferences = {
        "privacy.query_stripping.enabled" = true;                      # Strip tracking params from URLs (utm_*, etc.)
        "privacy.query_stripping.enabled.pbmode" = true;
        "beacon.enabled" = false;                                      # Disable navigator.sendBeacon tracking
        "browser.send_pings" = false;                                  # Block hyperlink auditing / ping attributes
        "dom.event.clipboardevents.enabled" = false;                   # Stop websites from detecting copy/cut/paste events
        "media.peerconnection.ice.default_address_only" = true;        # Prevent WebRTC local IP leaks
        # "privacy.resistFingerprinting" = true;                       # Strongest anti-fingerprinting (can break site styling/timezones)
      };

      DisableAppUpdate = true;
      BackgroundAppUpdate = false;
      AppAutoUpdate = false;
      WebsiteFilter = {
        Block = [
          "*://*.tiktok.com/*"
          "*://*.facebook.com/*"
          "*://*.instagram.com/*"
          "*://*.quora.com/*"
          "*://quora.com/*"
          "*://x.com/*"
        ];
      };
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://cloudflare-dns.com/dns-query";
        Locked = true;
        Fallback = true;
      };
      Cookies = {
        AllowSession = [
          "https://class.ipb.ac.id"
        ];
        Behavior = "reject-foreign";
        BehaviorPrivateBrowsing = "partition-foreign";
      };
    };

    profiles = {
      darwin = {
        id = 0;
        isDefault = true;
        name = "darwin";
        # bookmarks, extensions, search engines...
        search = {
          force = true;
          default = "google";
          engines = {

            nix-packages = {
              name = "NixOS Search Packages";
              urls = [
                {
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
                }
              ];
              icon = "${hm-pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nixos-search" ];
            };
              
            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [
                { 
                  template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; 
                }
              ];
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = [ "@nixos-wiki" ];
            };

            github = {
              name = "GitHub";
              urls = [
                { 
                  template = "https://github.com/{searchTerms}"; 
                }
              ];
              iconMapObj."16" = "https://a.favicon.im/github.com";
              definedAliases = [ "@github" ];
            };
          };  
        };
        extensions = {
          packages = with inputs.firefox-addons.packages."aarch64-darwin"; [
            ghostery
            enhanced-h264ify
            gruvbox-dark-theme
            zotero-connector
          ];
        };
      };
    };
  };
}