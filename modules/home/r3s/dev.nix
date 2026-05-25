{ self, inputs, ... }:
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

          core = {
            whitespace = "trailing-space,space-before-tab";
          };

          init.defaultBranch = "main";
          commit.gpgSign = true;
          log.showSignature = true;
          url = {
            "github:" = {
              insteadOf = "https://github.com/";
            };
          };
        };

        lfs.enable = true;
      };
    };
}
