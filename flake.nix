{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/nixos-25.11.tar.gz";

        # home-manager
        home-manager = {
            url = "https://github.com/nix-community/home-manager/archive/release-25.11.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # howdy
        nixpkgs-howdy.url = "https://github.com/fufexan/nixpkgs/archive/howdy.tar.gz";

        # niri
        niri.url = "https://github.com/sodiboo/niri-flake/archive/main.tar.gz";

        # noctalia
        noctalia.url = "https://github.com/noctalia-dev/noctalia-shell/archive/main.tar.gz";

        # zen-browser
        zen-browser = {
            url = "https://github.com/0xc000022070/zen-browser-flake/archive/main.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        # nyx
        nyx = {
            url = "https://github.com/chaotic-cx/nyx/archive/main.tar.gz";
            inputs.nixpkgs.follows = "nixpkgs";
        };


    };

    outputs = { self, nixpkgs, home-manager, niri, noctalia, nyx, ... }@inputs: {
        nixosConfigurations = {
            "nixos" = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = {
                    inherit inputs;
                };
                modules = [
                    ./configuration.nix

                    # nyx.nixosModules.default

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

