{ self, inputs, ... }:
{
  sops.secrets."accounts/bruckner" = {
    sopsFile = ../secrets/r3s.yaml;
  };
  flake.nixosModules.brucknerModule =
    {
      pkgs,
      lib,
      sops,
      ...
    }:
    {
      sops.templates."bruckner-credentials".content = ''
        user=richi
        password=${sops.secrets."accounts/bruckner"}
      '';
      # For mount.cifs, required unless domain name resolution is not needed.
      environment.systemPackages = [ pkgs.cifs-utils ];
      fileSystems."/mnt/bruckner" = {
        device = "//bruckner.dmz.rz.internal/personal/richi";
        fsType = "cifs";
        options =
          let
            # this line prevents hanging on network split
            automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,user,users";

          in
          [ "${automount_opts},credentials=${sops.secrets."accounts/bruckner".path}" ];
      };
    };
}
