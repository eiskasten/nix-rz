{ self, inputs, ... }:
{
  flake.nixosConfigurations.fucik = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.fucikConfiguration
    ];
  };
}
