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
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , agenix
    , ...
    }@inputs:
    {
      nixosConfigurations.hitori = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/hitori # Host-specific config
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
          email  = "nayutadere@gmail.com";
        };

        modules = [
          ./hosts/shorekeeper
          agenix.nixosModules.default
          {
            age.secrets = {
              vpn-env = {
                file = ./secrets/vpn.env.age;
              };
              homepage-env = {
                file = ./secrets/homepage.env.age;
              };
              authelia-jwt = {
                file  = ./secrets/authelia-jwt.age;
                owner = "authelia-main";
                mode  = "0440";
              };
              authelia-storage = {
                file  = ./secrets/authelia-storage.age;
                owner = "authelia-main";
                mode  = "0440";
              };
              authelia-session = {
                file  = ./secrets/authelia-session.age;
                owner = "authelia-main";
                mode  = "0440";
              };
            };
          }
        ];
      };
    };
}
