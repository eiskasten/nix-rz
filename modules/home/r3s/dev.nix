{ ... }:
{
  flake.homeModules.r3sDev =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "Richard Stöckl";
            email = "richard.stoeckl@aon.at";
          };
        };
      };
    };
}
