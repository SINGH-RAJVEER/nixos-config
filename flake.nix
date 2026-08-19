{
    description = "NixOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

        home-manager = {
            url = "github:nix-community/home-manager/master";
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

    outputs = { self, nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations = {
            "nixos" = nixpkgs.lib.nixosSystem {
                specialArgs = {
                    inherit inputs;
                };
                modules = [
                    ./configuration.nix

                    home-manager.nixosModules.home-manager

                    inputs.niri-session-manager.nixosModules.niri-session-manager
                ];
            };
        };
    };
}
