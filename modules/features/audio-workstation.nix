{ inputs, ... }:
{
  flake.nixosModules.audioWorkstationModule =
    { pkgs, ... }:
    {
      inputs.musnix.enable = true;
      environment.systemPackages = [
        pkgs.ardour
        pkgs.musescore
        pkgs.guitarix
        pkgs.carla
        pkgs.helvum
      ];

    };
}
