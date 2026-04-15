{ self, inputs, ... }:
{
  flake.nixosModules.networking =
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
    };
}
