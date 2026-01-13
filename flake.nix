{
	description = "NixOS from scratch";
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-25.05";
		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    nix-gaming.url = "github:fufexan/nix-gaming";

    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nix-gaming.follows = "nix-gaming";
    };
    
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
  };

	outputs = { self, nixpkgs, home-manager, aagl, ...}@inputs: {
		nixosConfigurations.flandre = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			
      specialArgs = {inherit inputs;};

      modules = [
        aagl.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          programs.sleepy-launcher.enable = true;

					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.nayuta = import ./home.nix;
						backupFileExtension = "backup";

            extraSpecialArgs = {inherit inputs;};
				  };
				}
			];
		};
	};
}
