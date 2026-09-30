{ pkgs, ... }: {
	programs.neovim = {
		enable = true;
		withNodeJs = true;
		withPython3 = true;
		withRuby = false;
		sideloadInitLua = true;

		extraPackages = with pkgs; [
			# LSP servers
			lua-language-server
			basedpyright
			typescript-language-server
			tailwindcss-language-server
			terraform
			terraform-ls
			biome
			gopls
			rust-analyzer

			# Formatters
			stylua
			black
			google-java-format
			gotools
			rustfmt

			# Linters
			ruff
			golangci-lint

			# Plugin build and image dependencies
			gnumake
			gcc
			imagemagick

			# Python project and virtual-environment management
			uv
		];

		extraPython3Packages = ps: with ps; [
			pynvim
			jupyter-client
			nbformat
		];
	};

	xdg.configFile."nvim" = {
		source = ./config;
		recursive = true;
	};
}
