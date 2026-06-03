{ ... }:
{
  flake.homeModules.aitSSH =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      rz.ssh.hosts = {
        "github.com" = {
          HostName = "github.com";
          User = "git";
          Port = 22;
          IdentityFile = "~/.ssh/github.com";
          IdentitiesOnly = true;
        };

        "gitlab" = {
          HostName = "git-service.ait.ac.at";
          User = "git";
          Port = 22;
          IdentityFile = "~/.ssh/gitlab";
          IdentitiesOnly = true;
        };

        "gitlab-int" = {
          HostName = "gitlab-intern.ait.ac.at";
          User = "git";
          Port = 22;
          IdentityFile = "~/.ssh/gitlab-intern";
          IdentitiesOnly = true;
        };

        "cr-sw1" = {
          HostName = "192.168.3.1";
          User = "stoecklr";
          Port = 22;
          IdentityFile = "~/.ssh/cros";
          IdentitiesOnly = true;
        };

        "cr-sw2" = {
          HostName = "192.168.3.2";
          User = "stoecklr";
          Port = 22;
          IdentityFile = "~/.ssh/cros";
          IdentitiesOnly = true;
        };

        "cr-mon" = {
          HostName = "192.168.4.21";
          User = "stoecklr";
          Port = 22;
          IdentityFile = "~/.ssh/cros";
          IdentitiesOnly = true;
        };

        "fact-gitlab" = {
          HostName = "gitlab.ingress.base-kk.fact.garden-local.innovationcluster.dev";
          User = "git";
          Port = 22;
          IdentityFile = "~/.ssh/fact-gitlab";
          IdentitiesOnly = true;
        };

        "ewms" = {
          HostName = "10.103.251.211";
          User = "stoecklr";
          Port = 22;
          IdentityFile = "~/.ssh/ewms";
          IdentitiesOnly = true;
        };

      };
    };

}
