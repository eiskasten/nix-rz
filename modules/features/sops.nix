{ ... }:
{
  flake.nixosModules.sopsModule =
    let
      ageKeyChain = "/var/lib/sops-nix/age-keychain.txt";
    in
    {
      sops.age.generateKey = false;
      sops.defaultSopsFile = ../../secrets/nixos/net.yaml;

      sops.age.keyFile = ageKeyChain;

      systemd.services.sops-age-keychain = {
        requiredBy = [ "sops-nix.service" ];
        before = [ "sops-nix.service" ];

        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
        };

        script = ''
          set -eu

          install -d -m 0700 /var/lib/sops-nix
          install -d -m 0700 /var/lib/sops-nix/keys

          tmp="$(mktemp ${ageKeyChain}.XXXXXX)"
          chmod 0600 "$tmp"

          find /var/lib/sops-nix/keys \
            -maxdepth 1 \
            -type f \
            -name '*.txt' \
            -exec cat {} + > "$tmp"

          mv "$tmp" ${ageKeyChain}
          chmod 0600 ${ageKeyChain}
        '';
      };

    };
}
