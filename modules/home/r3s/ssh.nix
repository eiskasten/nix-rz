{ ... }:
{
  flake.homeModules.r3sSSH =
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
          IdentityFile = "~/.ssh/community/github.com";
          IdentitiesOnly = true;
        };
        "schubert" = {
          HostName = "schubert.internal";
          User = "richi";
          IdentityFile = "~/.ssh/rz/schubert";
          IdentitiesOnly = true;
        };
        "haydn" = {
          HostName = "haydn.internal";
          User = "richi";
          IdentityFile = "~/.ssh/rz/haydn";
          IdentitiesOnly = true;
        };
        "mvl.at" = {
          HostName = "mvl.at";
          User = "richi";
          Port = 2622;
          IdentityFile = "~/.ssh/community/mvl";
          IdentitiesOnly = true;
        };
        "aur.archlinux.org" = {
          HostName = "aur.archlinux.org";
          User = "aur";
          IdentityFile = "~/.ssh/community/aur";
          IdentitiesOnly = true;
        };
        "florentiner.armada.stoeckl.dev" = {
          HostName = "florentiner.armada.stoeckl.dev";
          User = "root";
          Port = 2299;
          IdentityFile = "~/.ssh/commercial/armada";
          IdentitiesOnly = true;
        };
        "gladiator.armada.stoeckl.dev" = {
          HostName = "gladiator.armada.stoeckl.dev";
          User = "root";
          Port = 2299;
          IdentityFile = "~/.ssh/commercial/armada";
          IdentitiesOnly = true;
        };
        "triglav.armada.stoeckl.dev" = {
          HostName = "triglav.armada.stoeckl.dev";
          User = "root";
          Port = 2299;
          IdentityFile = "~/.ssh/commercial/armada";
          IdentitiesOnly = true;
        };
        "dvorak" = {
          HostName = "dvorak.internal";
          User = "root";
          IdentityFile = "~/.ssh/rz/dvorak";
          IdentitiesOnly = true;
        };
      };
    };

}
