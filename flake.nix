{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        # home-manager
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # lanzaboote
        lanzaboote = {
            url = "github:nix-community/lanzaboote/v0.4.1";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # howdy
        nixpkgs-howdy.url = "github:fufexan/nixpkgs/howdy";

        # niri
        niri.url = "github:sodiboo/niri-flake";

        # noctalia
        noctalia.url = "github:noctalia-dev/noctalia-shell";

        # zen-browser
        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, niri, noctalia, lanzaboote, ... }@inputs: {
        nixosConfigurations = {
            "nixos" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit inputs;
                };
                modules = [
                    ./configuration.nix

                    home-manager.nixosModules.home-manager

                    lanzaboote.nixosModules.lanzaboote

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

