{ self, inputs, ... }:
{
  flake.nixosModules.myHomeManagerModule =
    { pkgs, ... }:
    {
      imports = [ inputs.home-manager.nixosModules.default ];
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
}
