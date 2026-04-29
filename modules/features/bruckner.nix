{ self, inputs, ... }:
{
  flake.nixosModules.brucknerModule =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      sops.secrets."accounts/bruckner" = {
        sopsFile = ../secrets/r3s.yaml;
      };
      sops.templates."bruckner-credentials".content = ''
        user=richi
        password=${config.sops.placeholder."accounts/bruckner"}
      '';
      # For mount.cifs, required unless domain name resolution is not needed.
      environment.systemPackages = [ pkgs.cifs-utils ];
      fileSystems."/mnt/bruckner" = {
        device = "//bruckner.dmz.rz.internal/personal/richi";
        fsType = "cifs";
        options = [
          "x-systemd.automount"
          "noauto"
          "x-systemd.idle-timeout=60"
          "x-systemd.device-timeout=5s"
          "x-systemd.mount-timeout=5s"
          # "user"
          # "users"
          "vers=3.0"
          "uid=1000"
          "gid=100"

          "credentials=${config.sops.templates."bruckner-credentials".path}"
        ];
      };

      # Otherwise the vmVariant is too dumb to include it from the host.
      # could have checked that it's cifs...
      # note that omitting .virtualisation WORKS WITHOUT THE COMPILER COMPLAINING, WTF
      #
      # total hours wasted for this damned line two-liner: 4
      virtualisation.vmVariant.virtualisation = {
        fileSystems."/mnt/bruckner" = config.fileSystems."/mnt/bruckner";
      };
    };
}
