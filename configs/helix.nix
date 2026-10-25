{ pkgs, ... }:

let
	# Broot draws on the terminal and returns the selected path to Helix.
	treeConfig = (pkgs.formats.toml { }).generate "helix-broot.toml" {
		modal = true;
		default_flags = "-hi";
		verbs = [
			{ invocation = "open-in-helix"; key = "enter"; apply_to = "file"; internal = ":print_path"; }
		];
	};
	fileTree = pkgs.writeShellApplication {
		name = "helix-file-tree";
		runtimeInputs = [ pkgs.broot ];
		text = ''
			selection=$(broot --conf ${treeConfig} "$PWD" < /dev/tty 2> /dev/tty) || selection=
			# Broot restores the main screen on exit; return to Helix's alternate screen.
			printf '\033[?1049h\033[?2004h' > /dev/tty
			if [[ -n "$selection" ]]; then
				printf '%s:1:1' "$selection"
			fi
		'';
	};
	treeKeys = [
		":open %sh{${fileTree}/bin/helix-file-tree}"
		":redraw"
		":set mouse false"
		":set mouse true"
		# Cancelling prints no path. Clear :open's empty-path status message.
		":echo ''"
	];
	leaderKeys = {
		e = treeKeys;
		E = "file_explorer_in_current_directory";
		f = ":format";
		g = {
			g = ":sh jj --no-pager log";
			s = ":sh jj --no-pager status";
			d = ":sh jj --no-pager diff";
		};
		q = "diagnostics_picker";
		space = "buffer_picker";
		"/" = "search";
		s = {
			f = "file_picker";
			g = "global_search";
			d = "workspace_diagnostics_picker";
			s = "command_palette";
			w = "@miw*<space>sg";
			r = "last_picker";
			k = "command_palette";
			h = ":tutor";
			n = ":config-open";
			"/" = "global_search";
		};
	};

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

			# File tree and system clipboard
			fileTree
			wl-clipboard
			jujutsu
		];

		settings = {
			theme = "ayu_dark";

			editor = {
				line-number = "relative";
				mouse = true;
				cursorline = true;
				scrolloff = 10;
				idle-timeout = 250;
				auto-format = false;
				default-yank-register = "+";
				end-of-line-diagnostics = "hint";
				gutters = [ "diagnostics" "spacer" "line-numbers" "spacer" "diff" ];

				cursor-shape = {
					insert = "bar";
					select = "underline";
				};

				file-picker = {
					hidden = false;
					git-ignore = false;
				};
				search = { smart-case = true; wrap-around = true; };
				inline-diagnostics.cursor-line = "hint";
				# Match Neovim's hidden statusline contents. Helix still reserves the row.
				statusline = { left = [ ]; center = [ ]; right = [ ]; };

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

			keys.normal = {
				space = leaderKeys;
				F2 = "rename_symbol";
				g = {
					O = "symbol_picker";
					W = "workspace_symbol_picker";
					r = {
						n = "rename_symbol";
						a = "code_action";
						r = "goto_reference";
						i = "goto_implementation";
						d = "goto_definition";
						D = "goto_declaration";
						t = "goto_type_definition";
					};
				};
			};
			keys.select.space = leaderKeys;
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

			# Neovim's tabstop/shiftwidth/expandtab defaults, with manual formatting.
			language = map (language: {
				indent = { tab-width = 4; unit = "    "; };
			} // language) [
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
				{ name = "hcl"; }
				{ name = "tfvars"; }
				{ name = "nix"; }
				{ name = "bash"; }
				{ name = "toml"; }
				{ name = "markdown"; }
				{ name = "json5"; formatter = biomeFormatter [ ]; }
			];
		};
	};
}
