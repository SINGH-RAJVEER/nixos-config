{ pkgs, ... }:

let
	biomeFormatter = extraArgs: {
		command = "biome";
		args = [
			"format"
			"--stdin-file-path=%{buffer_name}"
			"--javascript-formatter-indent-style=tab"
		] ++ extraArgs;
	};

	webServers = [
		{ name = "typescript-language-server"; except-features = [ "format" ]; }
		"biome"
		"tailwindcss-ls"
	];
in
{
	programs.helix = {
		enable = true;

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
			golangci-lint-langserver
		];

		settings = {
			theme = "ayu_dark";

			editor = {
				line-number = "relative";
				mouse = true;
				cursorline = true;
				scrolloff = 10;
				default-yank-register = "+";
				end-of-line-diagnostics = "hint";
				gutters = [ "diagnostics" "spacer" "line-numbers" "spacer" "diff" ];

				cursor-shape = {
					insert = "bar";
					select = "underline";
				};

				file-picker.hidden = false;

				indent-guides.render = true;

				lsp = {
					display-messages = true;
					display-progress-messages = true;
				};

				soft-wrap.enable = true;

				whitespace = {
					render = {
						tab = "all";
						nbsp = "all";
					};
					characters = {
						tab = "»";
						nbsp = "␣";
					};
				};
			};
		};

		languages = {
			language-server = {
				basedpyright.config.basedpyright.analysis = {
					autoImportCompletions = true;
					diagnosticMode = "workspace";
					typeCheckingMode = "standard";
				};

				lua-language-server.config.Lua.completion.callSnippet = "Replace";
			};

			# Formatting is manual (:format), matching conform's <leader>f in Neovim.
			language = [
				{
					name = "python";
					language-servers = [
						"basedpyright"
						{ name = "ruff"; except-features = [ "format" "hover" ]; }
					];
					formatter = { command = "black"; args = [ "-" "--quiet" ]; };
					auto-format = false;
				}
				{
					name = "javascript";
					language-servers = webServers;
					formatter = biomeFormatter [ ];
					auto-format = false;
				}
				{
					name = "jsx";
					language-servers = webServers;
					formatter = biomeFormatter [ ];
					auto-format = false;
				}
				{
					name = "typescript";
					language-servers = webServers;
					formatter = biomeFormatter [ "--trailing-commas=none" ];
					auto-format = false;
				}
				{
					name = "tsx";
					language-servers = webServers;
					formatter = biomeFormatter [ "--trailing-commas=none" ];
					auto-format = false;
				}
				{
					name = "json";
					formatter = biomeFormatter [ ];
					auto-format = false;
				}
				{
					name = "jsonc";
					formatter = biomeFormatter [ ];
					auto-format = false;
				}
				{
					name = "css";
					formatter = biomeFormatter [ ];
					auto-format = false;
				}
				{
					name = "graphql";
					formatter = biomeFormatter [ ];
					auto-format = false;
				}
				{
					name = "go";
					formatter.command = "goimports";
					auto-format = false;
				}
				{
					name = "lua";
					formatter = { command = "stylua"; args = [ "-" ]; };
					auto-format = false;
				}
				{
					name = "rust";
					auto-format = false;
				}
				{
					name = "java";
					formatter = { command = "google-java-format"; args = [ "-" ]; };
					auto-format = false;
				}
			];
		};
	};
}
