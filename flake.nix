{
  description = "NixOS from scratch";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
    };

    mango = {
        url = "github:DreamMaoMao/mangowc";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      mango,
      ...
    }@inputs:
    {
      nixosConfigurations.futari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/hitori # Host-specific config (imports shared configuration.nix)
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nayuta = import ./hosts/hitori/home.nix;
              backupFileExtension = "backup";

              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };
      nixosConfigurations.futari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/futari
          inputs.mango.nixosModules.mango 
          home-manager.nixosModules.home-manager
          {
              home-manager ={
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.nayuta = import ./hosts/futari/home.nix;
                  backupFileExtension = "backup";

                  extraSpecialArgs = { inherit inputs; };
              };
          }
        ];
      };
    };
}
