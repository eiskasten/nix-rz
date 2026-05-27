{ ... }:
{
  flake.nixosModules.nfc =
    { pkgs, ... }:
    {
      hardware.nfc-nci.enable = true;

      environment.systemPackages = with pkgs; [
        libnfc
      ];
    };
}
