{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # howdy
        nixpkgs-howdy.url = "github:fufexan/nixpkgs/howdy";

        # niri
        niri.url = "github:sodiboo/niri-flake";

        # home-manager
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # zen-browser
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, niri, ... }@inputs: {
        nixosConfigurations = {
            "nixos" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./configuration.nix
                    home-manager.nixosModules.home-manager
                    niri.nixosModules.niri
                    {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                    }
                ];
            };
        };
    };
}