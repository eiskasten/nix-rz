{ self, inputs, ... }:
{
  flake.nixosModules.fucikHardware =
    {
      pkgs,
      lib,
      config,
      modulesPath,
      ...
    }:
    let
      rootLabel = "fucik-root";
      bootLabel = "fucik-boot";
      swapLabel = "fucik-swap";
    in
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      virtualisation.vmVariant = {
        virtualisation = {
          cores = 4;
          memorySize = 4096;
          forwardPorts = [
            {
              host.port = 2022;
              guest.port = 22;
              from = "host";
            }
          ];
        };
      };

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "nvme"
        "usbhid"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "kvm-intel" ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-label/${rootLabel}";
        fsType = "btrfs";
        options = [ "subvol=@system" ];
      };

      fileSystems."/home" = {
        device = "/dev/disk/by-label/${rootLabel}";
        fsType = "btrfs";
        options = [ "subvol=@home" ];
      };

      fileSystems."/swap" = {
        device = "/dev/disk/by-label/${rootLabel}";
        fsType = "btrfs";
        options = [ "subvol=@swap" ];
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-label/${bootLabel}";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      boot.initrd.luks.devices."home-richi".device =
        "/dev/disk/by-uuid/5e96e7d1-c056-4da9-aa64-c156f148727f";

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    };
}
