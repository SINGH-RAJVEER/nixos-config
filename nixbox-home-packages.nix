# Managed by nixbox. Do not edit by hand.
{ inputs, pkgs, ... }:
{
	home.packages = [
		# nixbox:packages:start
		pkgs.bat
		pkgs.brightnessctl
		pkgs.claude-code
		pkgs.codex
		pkgs.devenv
		pkgs.discord
		pkgs.exfatprogs
		pkgs.fd
		pkgs.fzf
		pkgs.gh
		pkgs.git
		pkgs.hunk
		pkgs.jujutsu
		pkgs.lmstudio
		pkgs.mission-center
		pkgs.mpv
		pkgs.obsidian
		pkgs.onlyoffice-desktopeditors
		pkgs.openssl
		pkgs.pavucontrol
		pkgs.pcmanfm
		pkgs.podman-desktop
		pkgs.qbittorrent
		pkgs.ripgrep
		pkgs.seahorse
		pkgs.steam
		pkgs.t3code
		pkgs.thunderbird
		pkgs.tor-browser
		pkgs.xwayland-satellite
		pkgs.zellij
		# nixbox:packages:end
		# nixbox:flake-packages:start
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.default # github:SINGH-RAJVEER/nixbox
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.nixbox-tui # github:SINGH-RAJVEER/nixbox
		inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default # github:noctalia-dev/noctalia
		inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # github:oxcl/nix-flake-helium-browser
		# nixbox:flake-packages:end
	];
}
