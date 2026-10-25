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
		pkgs.spotify
		pkgs.steam
		pkgs.thunderbird
		pkgs.tor-browser
		pkgs.xwayland-satellite
		pkgs.zed-editor-fhs
		pkgs.zellij
		# nixbox:packages:end
		# nixbox:flake-packages:start
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.nixbox-cli-nightly # github:SINGH-RAJVEER/nixbox
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.nixbox-nightly # github:SINGH-RAJVEER/nixbox
		inputs.nixbox.packages.${pkgs.stdenv.hostPlatform.system}.nixbox-tui-nightly # github:SINGH-RAJVEER/nixbox
		inputs.nix-t3code.packages.${pkgs.stdenv.hostPlatform.system}.t3code # github:limwa/nix-t3code
		inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default # github:noctalia-dev/noctalia
		inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.chatgpt # github:numtide/llm-agents.nix
		inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop # github:numtide/llm-agents.nix
		inputs.helium-browser.packages.${pkgs.stdenv.hostPlatform.system}.default # github:oxcl/nix-flake-helium-browser
		inputs.delta-nix.packages.${pkgs.stdenv.hostPlatform.system}.delta # github:zed-industries/delta-nix
		# nixbox:flake-packages:end
	];
}
