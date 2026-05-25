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
      programs.ssh = {
        enable = true;
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            port = 22;
            identityFile = "~/.ssh/community/github.com";
            identitiesOnly = true;
          };
          "schubert" = {
            hostname = "schubert.internal";
            user = "richi";
            identityFile = "~/.ssh/rz/schubert";
            identitiesOnly = true;
          };
          "haydn" = {
            hostname = "haydn.internal";
            user = "richi";
            identityFile = "~/.ssh/rz/haydn";
            identitiesOnly = true;
          };

          "mvl.at" = {
            hostname = "mvl.at";
            user = "richi";
            port = 2622;
            identityFile = "~/.ssh/community/mvl";
            identitiesOnly = true;
          };
          "aur.archlinux.org" = {
            hostname = "aur.archlinux.org";
            user = "aur";
            identityFile = "~/.ssh/community/aur";
            identitiesOnly = true;
          };
          "florentiner.armada.stoeckl.dev" = {
            hostname = "florentiner.armada.stoeckl.dev";
            user = "root";
            port = 2299;
            identityFile = "~/.ssh/commercial/armada";
            identitiesOnly = true;
          };
          "gladiator.armada.stoeckl.dev" = {
            hostname = "gladiator.armada.stoeckl.dev";
            user = "root";
            port = 2299;
            identityFile = "~/.ssh/commercial/armada";
            identitiesOnly = true;
          };
          "triglav.armada.stoeckl.dev" = {
            hostname = "triglav.armada.stoeckl.dev";
            user = "root";
            port = 2299;
            identityFile = "~/.ssh/commercial/armada";
            identitiesOnly = true;
          };
          "dvorak" = {
            hostname = "dvorak.internal";
            user = "root";
            identityFile = "~/.ssh/rz/dvorak";
            identitiesOnly = true;
          };
        };

      };
      home.activation.generateSshKeys = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"

        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (
            host: cfg:
            let
              keyFile = builtins.replaceStrings [ "~" ] [ config.home.homeDirectory ] cfg.identityFile;
            in
            ''
              if [ ! -f "${keyFile}" ]; then
                echo "Generating SSH key for ${host}"
                ${pkgs.openssh}/bin/ssh-keygen \
                  -t ed25519 \
                  -f "${keyFile}" \
                  -C "${config.home.username}@${host}" \
                  -N ""
              fi

              chmod 600 "${keyFile}"
              chmod 644 "${keyFile}.pub"
            ''
          ) config.programs.ssh.matchBlocks
        )}
      '';
    };
}
