{ pkgs, ... }:

{
    programs.nushell = {
        enable = true;

        extraEnv = ''
            $env.PROMPT_INDICATOR_VI_NORMAL = " "
            $env.PROMPT_INDICATOR_VI_INSERT = ""
            $env.EDITOR = "nvim"
            $env.VISUAL = "nvim"
            $env.BUN_INSTALL = ($env.HOME | path join ".bun")
            $env.FZF_DEFAULT_OPTS = "--ansi --preview 'bat --color=always --style=header,grid --line-range :100 {}'"

            # paths
            $env.PATH = ($env.PATH | split row (char esep) | append ($env.HOME | path join ".cargo/bin"))
            $env.PATH = ($env.PATH | split row (char esep) | append ($env.BUN_INSTALL | path join "bin"))
        '';

        extraConfig = ''
            $env.config = {
                show_banner: false,
                edit_mode: "vi",

                history: {
                    max_size: 10_000_000,
                    sync_on_enter: true,
                    file_format: "sqlite",
                    isolation: true,
                },

                completions: {
                    case_sensitive: false,
                    quick: true,
                    partial: true,
                    algorithm: "prefix",
                    external: {
                        enable: true,
                        max_results: 100,
                    }
                },

                ls: {
                    use_ls_colors: true,
                    clickable_links: true,
                },

                rm: {
                    always_trash: true,
                },

                hooks: {
                    env_change: {
                        PWD: [
                            { |before, after| ls | print }
                        ]
                    }
                }
            }

            # jj commit wrapper
            def commit [...msg] {
                let message = ($msg | str join " ")
                if ($message | is-empty) {
                    echo "Usage: commit <message>"
                    return 1
                }
                jj commit -m $message
            }

            # fzf previews wrapper
            def --wrapped fzf [...args] {
                with-env { SHELL: "${pkgs.bash}/bin/bash" } {
                    ^fzf ...$args
                }
            }

            # fzf wrapper
            def ff [] {
                let files = (fzf --multi)
                if ($files | is-empty) {
                    return
                }
                nvim ...($files | split row "\n")
            }

            def update [] {
                nix flake update --flake /home/rajveer/.config/nixos
                if $env.LAST_EXIT_CODE == 0 {
                    sudo nixos-rebuild switch --flake /home/rajveer/.config/nixos#nixos
                }
            }
        '';

        shellAliases = {
            # NixOS
            build = "sudo nixos-rebuild switch --flake /home/rajveer/.config/nixos#nixos";

            # Navigation
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";

            # Asus
            ass = "asusctl";
            sup = "supergfxctl";
            int = "supergfxctl -m Integrated";
            hyb = "supergfxctl -m Hybrid";
            dgpu = "supergfxctl -m AsusMuxDgpu";

            # Utils
            ll = "ls -l";
            la = "ls -a";
            cat = "bat --theme=\"OneHalfDark\"";
            grep = "rg";
            j = "zellij";
            hd = "hunk diff";

            # Safety
            rm = "rm -i";
            cp = "cp -i";
            mv = "mv -i";

            # Git
            add = "git add .";
            g = "git";
            push = "git push origin";
            gd = "git diff";

            # jj
            js = "jj status";
            jd = "jj diff";
            jm = "jj bookmark move";
            jp = "jj git push --bookmark";

            # Nvim
            vi = "nvim";
            vim = "nvim";
        };
    };
}
