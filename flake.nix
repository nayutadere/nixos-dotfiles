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

    agenix = {
      url = "github:ryantm/agenix";
    };

    copyparty = {
      url = "github:9001/copyparty";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
      copyparty,
      ...
    }@inputs:
    {
      nixosConfigurations.hitori = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; }; # Add this line

        modules = [
          ./hosts/hitori
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nayuta = import ./hosts/hitori/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
      nixosConfigurations.futari = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/futari
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.nayuta = import ./hosts/futari/home.nix;
              backupFileExtension = "backup";

              extraSpecialArgs = { inherit inputs; };
            };
          }
        ];
      };

      # `nix develop` gives you the `agenix` command for editing secrets.
      devShells.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.mkShell {
        packages = [ agenix.packages.x86_64-linux.default ];
      };

      nixosConfigurations.shorekeeper = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs;
          domain = "bocchide.re";
          email = "nayutadere@gmail.com";
        };

        modules = [
          ./hosts/shorekeeper
        ];
      };
    };
}
