{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  inputs,
  ...
}:
with lib;
  mkIf config.normal.browser.searxng.enable {
    environment.systemPackages = with pkgs; [
      ## Search engine
      # A local search engine that gather other search engine results.
      # It anonimise searches by removing cookies and special params.
      # Furthermore no metadata collection (trackers, blueprint..)
      searxng
      # searxng dependencies
      redis
    ];

    sops.secrets."searx" = {
      owner = "root";
      group = "searx";
      mode = "0440";
      path = "/var/lib/searx/secret";
    };
    services.searx = {
      enable = true;
      package = pkgs-unstable.searxng;
      redisCreateLocally = true;
      environmentFile = "/var/lib/searx/secret";
      settings = {
        use_default_settings = true;
        general = {
          debug = true;
          instance_name = "SearXNG";
        };
        # Server configuration
        server = {
          base_url = "https://deku.lan";
          bind_address = "::1";
          port = 8888;
          secret_key = config.sops.secrets.searx.path;
          public_instance = false;
          limiter = true;
          image_proxy = true;
        };
        # User interface
        ui = {
          static_use_hash = true;
          hotkeys = "vim";
        };
        # Search engines
        engines =
          lib.mapAttrsToList (name: value: {inherit name;} // value)
          {
            "yacy images".disabled = true;
            "duckduckgo".disabled = false;
            "brave".disabled = true;
            "bing".disabled = false;
            "mojeek".disabled = true;
            "wikibooks".disabled = false;
          };
        # Search engines settings
        search = {
          safe_search = 2;
          autocomplete = "duckduckgo";
        };
        # Outgoing requests
        outgoing = {
          request_timeout = 5.0;
          max_request_timeout = 15.0;
          pool_connections = 100;
          pool_maxsize = 15;
          enable_http2 = true;
        };
        # Enabled plugins
        enabled_plugins = [
          "Hash plugin"
          "Self Informations"
          "Tracker URL remover"
          "Ahmia blacklist"
          "Basic Calculator"
          "Unit converter plugin"
          # "Tor check plugin"
          # "Open Access DOI rewrite"
          # "Hostnames plugin"
        ];
        # port = yourPort;
        # WARNING: setting secret_key here might expose it to the nix cache
        # see below for the sops or environment file instructions to prevent this
        # secret_key = "Your secret key.";
      };
    };
  }
