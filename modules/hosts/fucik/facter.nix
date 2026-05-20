{ ... }:
{
  flake.nixosModules.fucikFacterModule =
    { config, lib, ... }:
    {
      config = lib.mkIf (!config.virtualisation.isVmVariant) {
        hardware.facter.reportPath = ./facter.json;
      };
    };
}
