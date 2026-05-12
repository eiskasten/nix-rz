{ self, inputs, ... }:
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
