{ self, inputs, ... }:
{
  flake.nixosModules.mailModule =
    { pkgs, lib, ... }:
    {
      programs.evolution.enable = true;
    };
}
