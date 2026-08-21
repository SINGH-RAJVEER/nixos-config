{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/master";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        lanzaboote = {
            url = "github:nix-community/lanzaboote/v1.1.0";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        niri-session-manager = {
            url = "github:MTeaHead/niri-session-manager";
            inputs.nixpkgs.follows = "nixpkgs";
            inputs.treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
        };

        noctalia = {
            url = "github:noctalia-dev/noctalia";
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

        sidra.url = "github:wimpysworld/sidra";
    };

    outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs: {
        nixosConfigurations = {
            "nixos" = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                };
                modules = [
                    ./configuration.nix

                    home-manager.nixosModules.home-manager

                    lanzaboote.nixosModules.lanzaboote

                    ({ pkgs, lib, ... }: {

                        environment.systemPackages = [
                            pkgs.sbctl
                        ];

                        boot.loader.systemd-boot.enable = lib.mkForce false;

                        boot.lanzaboote = {
                            enable = true;
                            pkiBundle = "/var/lib/sbctl";
                        };
                    })

                    inputs.niri-session-manager.nixosModules.niri-session-manager
                ];
            };
        };
    };
}
