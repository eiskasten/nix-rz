{ self, inputs, ... }:
{
  flake.homeModules.dev =
    { ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          core = {
            whitespace = "trailing-space,space-before-tab";
          };

          pull.rebase = false;

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
