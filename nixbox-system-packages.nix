# Managed by nixbox. Do not edit by hand.
{ pkgs, ... }:
{
	environment.systemPackages = [
		# nixbox:packages:start
		pkgs.git-lfs
		# nixbox:packages:end
	];
}
