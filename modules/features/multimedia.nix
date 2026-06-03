{ ... }:
{
  flake.nixosModules.multimediaModule =
    { pkgs, lib, ... }:
    {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };
    };
}
