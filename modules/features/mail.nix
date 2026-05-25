{ self, inputs, ... }:
{
  flake.nixosModules.mail =
    { pkgs, lib, ... }:
    {
      programs.evolution.enable = true;
    };
}
