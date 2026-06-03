{ self, inputs, ... }:
{
  flake.homeModules.dev =
    { pkgs, ... }:
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

      programs.bat.enable = true;
      programs.htop.enable = true;
      programs.man.enable = true;

      home.packages = [
        pkgs.mtr
        pkgs.curl
        pkgs.wireshark
      ];
    };

}
