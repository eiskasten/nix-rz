{ self, inputs, ... }:
{
  flake.nixosModules.fucikHardware =
    {
      pkgs,
      lib,
      config,
      modulesPath,
      ...
    }:
    {
      imports = [
        self.nixosModules.fucikFacterModule
      ];
      virtualisation.vmVariant = {
        hardware.facter.reportPath = lib.mkForce null;
        virtualisation = {
          cores = 4;
          memorySize = 4096;
          forwardPorts = [
            {
              host.port = 2022;
              guest.port = 22;
              from = "host";
            }
          ];
        };
      };
      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    };
}
