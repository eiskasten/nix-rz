{ ... }:
{
  flake.homeModules.r3sMail =
    { ... }:
    {
      services.protonmail-bridge.enable = true;
    };
}
