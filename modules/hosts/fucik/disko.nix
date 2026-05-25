{ inputs, ... }:
{
  flake.nixosModules.fucikDisko =
    { ... }:
    {
      imports = [
        inputs.disko.nixosModules.disko
      ];

      disko.devices = {
        disk = {
          fucik-internal = {
            device = "/dev/nvme0n1";
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  type = "EF00";
                  size = "2G";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };
                fucik-system = {
                  size = "100%";
                  content = {
                    type = "luks";
                    name = "crypted";
                    # disable settings.keyFile if you want to use interactive password entry
                    passwordFile = "/tmp/secret.key"; # Interactive
                    settings = {
                      allowDiscards = true;
                      # keyFile = "/tmp/secret.key";
                    };
                    # additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                    content = {
                      type = "btrfs";
                      extraArgs = [ "-f" ];
                      subvolumes = {
                        "/fucik-nixos" = {
                          mountpoint = "/";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "/home" = {
                          mountpoint = "/home";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "/nix" = {
                          mountpoint = "/nix";
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                        };
                        "/swap" = {
                          mountpoint = "/.swapvol";
                          swap.swapfile.size = "16G";
                        };
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}
