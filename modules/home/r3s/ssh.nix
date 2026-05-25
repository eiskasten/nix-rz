{ ... }:
{
  flake.homeModules.r3sSSH =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      sshHosts = {
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

      keygenScript = pkgs.writeShellScript "generate-missing-ssh-keys" ''
        set -eu

        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (
            host: cfg:
            let
              keyFile = builtins.replaceStrings [ "~" ] [ config.home.homeDirectory ] cfg.IdentityFile;
            in
            ''
              mkdir -p "$(dirname "${keyFile}")"
              chmod 700 "$(dirname "${keyFile}")"

              if [ ! -f "${keyFile}" ]; then
                echo "Generating SSH key for ${host}: ${keyFile}"
                ${pkgs.openssh}/bin/ssh-keygen \
                  -t ed25519 \
                  -f "${keyFile}" \
                  -C "${config.home.username}@${host}" \
                  -N ""
              fi

              chmod 600 "${keyFile}"
              [ -f "${keyFile}.pub" ] && chmod 644 "${keyFile}.pub"
            ''
          ) (lib.filterAttrs (_: cfg: cfg ? IdentityFile && cfg.IdentityFile != null) sshHosts)
        )}
      '';
    in
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "*" = {
            ForwardAgent = false;
            AddKeysToAgent = "yes";
            Compression = false;
            ServerAliveInterval = 0;
            ServerAliveCountMax = 3;
            HashKnownHosts = false;
            UserKnownHostsFile = "~/.ssh/known_hosts";
            ControlMaster = "no";
            ControlPath = "~/.ssh/master-%r@%n:%p";
            ControlPersist = "no";
          };
        }
        // sshHosts;
      };

      services.ssh-agent.enable = true;

      systemd.user.services.generate-missing-ssh-keys = {
        Unit = {
          Description = "Generate missing SSH keys referenced by Home Manager SSH config";
        };

        Service = {
          Type = "oneshot";
          ExecStart = "${keygenScript}";
        };
      };

      systemd.user.timers.generate-missing-ssh-keys = {
        Unit = {
          Description = "Periodically generate missing SSH keys";
        };

        Timer = {
          OnBootSec = "30s";
          OnUnitActiveSec = "1h";
          Unit = "generate-missing-ssh-keys.service";
        };

        Install = {
          WantedBy = [ "timers.target" ];
        };
      };
    };
}
