{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri = {
            url = "github:sodiboo/niri-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri-session-manager = {
            url = "github:MTeaHead/niri-session-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia-shell";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        helium-browser = {
            url = "github:oxcl/nix-flake-helium-browser";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, niri, noctalia, ... }@inputs: {
        nixosConfigurations = {
            "nixos" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";

                specialArgs = {
                    inherit inputs;
                };

                modules = [
                    ./configuration.nix

                    home-manager.nixosModules.home-manager

                    niri.nixosModules.niri

                    inputs.niri-session-manager.nixosModules.niri-session-manager
                ];
            };
        };
    };
}
