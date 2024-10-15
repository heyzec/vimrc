{ config, ... }:
{
  services.home-assistant = {
    enable = true;

    extraComponents = [
      "xiaomi_ble"
      "zha"
      "mqtt"
    ];
    extraPackages = ps: with ps; [
      getmac
      pyatv
    ];

    # Your configuration.yaml as a Nix attribute set.
    config = {
      default_config = {};
      homeassistant = {
        internal_url = "https://heyzec.dedyn.io";
        external_url = "https://heyzec.dedyn.io";
      };
      http = {
        # Setup for reverse proxy to properly accept connections
        use_x_forwarded_for = true;
        trusted_proxies = [ "127.0.0.1" "::1" ];
      };
      automation = "!include automations.yaml";
    };
  };

  services.mosquitto = {
    enable = true;
    listeners = [
      {
        acl = [ "pattern readwrite #" ];
        omitPasswordAuth = true;
        settings.allow_anonymous = true;
      }
    ];
  };

  services.zigbee2mqtt = {
    enable = true;
    settings = {
      homeassistant = config.services.home-assistant.enable;
      frontend = true;
    };
  };

  networking.firewall.allowedTCPPorts = [ 1883 8123 8080 ];
  services.caddy.virtualHosts."ha.heyzec.dedyn.io".extraConfig = ''
    reverse_proxy * localhost:8123
  '';
}
