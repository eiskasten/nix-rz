{ ... }:
{
  flake.nixosModules.fucikFacterModule =
    { config, lib, ... }:
    {
      config = lib.mkIf (!config.virtualisation.isVmVariant or false) {
        hardware.facter.reportPath = ./facter.json;
      };
    };
}
