{ ... }:
{
  flake.nixosModules.printModule =
    { pkgs, lib, ... }:
    {
      services.printing.enable = true;
    };
}
