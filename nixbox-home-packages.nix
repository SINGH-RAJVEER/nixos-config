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
		pkgs.libreoffice
		pkgs.lmstudio
		pkgs.mission-center
		pkgs.mpv
		pkgs.obsidian
		pkgs.onlyoffice-desktopeditors
		pkgs.opencode
		pkgs.opencode-desktop
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
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.nixbox-cli # github:SINGH-RAJVEER/nixbox
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.nixbox-tui # github:SINGH-RAJVEER/nixbox
		inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default # github:noctalia-dev/noctalia
		inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.chatgpt # github:numtide/llm-agents.nix
		inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop # github:numtide/llm-agents.nix
		inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # github:oxcl/nix-flake-helium-browser
		# nixbox:flake-packages:end
	];
}
