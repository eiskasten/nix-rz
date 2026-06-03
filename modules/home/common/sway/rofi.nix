{ ... }:
{
  flake.homeModules.rofi =
    { ... }:
    {
      programs.rofi = {
        enable = true;
        pass.enable = true;
      };
    };
}
