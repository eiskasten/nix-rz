{ self, inputs, ... }:
{
  flake.nixosModules.networkModule =
    { config, pkgs, ... }:
    {
      programs = {
        seahorse.enable = true;
        wireshark = {
          enable = true;
          usbmon.enable = true;
          package = pkgs.wireshark;
        };
      };

      networking.networkmanager.enable = true;

      time.timeZone = "Europe/Vienna";

      services.openssh.enable = true;
      networking.firewall.enable = true;
      sops.secrets."net/wifi/kurti-wlan" = { };
      networking.networkmanager.ensureProfiles.profiles = {
        kurti-wlan = {
          connection = {
            id = "kurti-wlan";
            type = "wifi";
          };

          wifi = {
            mode = "infrastructure";
            ssid = "Kurti Wlan";
          };

          wifi-security = {
            key-mgmt = "wpa-psk";
          };

          ipv4 = {
            dns = "1.1.1.1";
            method = "auto";
          };

          ipv6 = {
            addr-gen-mode = "stable-privacy";
            method = "auto";
          };
        };
      };
      networking.networkmanager.ensureProfiles.secrets.entries = [
        {
          file = config.sops.secrets."net/wifi/kurti-wlan".path;
          key = "psk";
          matchId = "Kurti Wlan";
          matchSetting = "wifi-security";
          matchType = "wifi";
        }

      ];
    };
}
