{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager.url = "github:nix-community/home-manager/master";

        lanzaboote.url = "github:nix-community/lanzaboote/v1.1.0";

        noctalia.url = "github:noctalia-dev/noctalia";

        zen-browser.url = "github:0xc000022070/zen-browser-flake";

        helium-browser.url = "github:oxcl/nix-flake-helium-browser";

        sidra.url = "github:wimpysworld/sidra";

		llm-agents.url = "github:numtide/llm-agents.nix";

        nixbox.url = "github:SINGH-RAJVEER/nixbox";
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
                ];
            };
        };
    };
}
