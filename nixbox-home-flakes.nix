# Managed by nixbox. Do not edit by hand.
{ inputs, pkgs, ... }:
{
	imports = [
		# nixbox:flakes:start
		# nixbox:flakes:end
	];
	home.packages = [
		# nixbox:flake-packages:start
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.default # github:SINGH-RAJVEER/nixbox
		inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default # github:noctalia-dev/noctalia
		inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # github:oxcl/nix-flake-helium-browser
		# nixbox:flake-packages:end
	];
}
