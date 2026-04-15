{ self, inputs }:
{
  flake.homeModules.r3sDev =
    { ... }:
    {
      programs.git = {
        settings = {
          user = {
            name = "eiskasten";
            email = "richard.stoeckl@aon.at";
          };
        };
      };
    };
}
