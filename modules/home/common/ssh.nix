{ ... }:
{
  flake.homeModules.ssh =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      sshHosts = config.rz.ssh.hosts;
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
      options.rz.ssh = {
        hosts = lib.mkOption {
          type = lib.types.attrs;
          default = { };
          description = "Custom SSH host definitions.";
        };
      };
      config = {
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
    };
}
