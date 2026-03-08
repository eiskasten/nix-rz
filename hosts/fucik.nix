{
  nixpkgs,
  home-manager,
  stylix,
  ...
}@inputs:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = { inherit inputs; };

  modules = [
    stylix.nixosModules.stylix
    ../users.nix
    ../desktop

    # make home-manager as a module of nixos
    # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.r3s = import ../home;

      # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
      home-manager.extraSpecialArgs = { inherit inputs; };
    }
  ];
}
