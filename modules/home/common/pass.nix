{ ... }:
{
  flake.homeModules.pass =
    { pkgs, ... }:
    {
      services.pass-secret-service.enable = true;
      programs.password-store.enable = true;
      programs.password-store.settings = {
      };
      programs.password-store.package = pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);

      programs.browserpass.enable = true;
    };
}
