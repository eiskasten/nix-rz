{ self, inputs, ... }:
{
  imports = [
    inputs.home-manager.flakeModules.home-manager
    inputs.stylix.nixosModules.stylix
  ];
  config.systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];
}
