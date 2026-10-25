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

		sidra = {
			url = "github:wimpysworld/sidra";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		llm-agents = {
			url = "github:numtide/llm-agents.nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixbox = {
			url = "github:SINGH-RAJVEER/nixbox/dev";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-t3code = {
			url = "github:limwa/nix-t3code";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		delta-nix = {
			url = "github:zed-industries/delta-nix";
			inputs.nixpkgs.follows = "nixpkgs";
		};
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
