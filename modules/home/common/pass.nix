{ ... }:
{
  flake.homeModules.pass =
    { pkgs, ... }:
    {
      services.pass-secret-service.enable = true;
      programs.password-store.enable = true;
      programs.password-store.settings = {
      };

      programs.browserpass.enable = true;
    };
}
