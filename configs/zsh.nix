{ pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [
                "git"
                "fzf"
                "vi-mode"
            ];
        };

        history = {
            size = 10000000;
            save = 10000000;
            path = "$HOME/.zsh_history";
            share = true;
            ignoreDups = true;
            ignoreSpace = true;
            extended = true;
        };

        initContent = ''
            export PROMPT_INDICATOR_VI_NORMAL=" "
            export PROMPT_INDICATOR_VI_INSERT=""
            export EDITOR="nvim"
            export VISUAL="nvim"
            export BUN_INSTALL="$HOME/.bun"
            export FZF_DEFAULT_OPTS="--ansi --preview 'bat --color=always --style=header,grid --line-range :100 {}'"

            path+=("$HOME/.cargo/bin")
            path+=("$BUN_INSTALL/bin")
            typeset -U path
            export PATH

            setopt interactive_comments
            setopt no_beep
            setopt auto_cd
            setopt auto_pushd
            setopt pushd_ignore_dups
            setopt hist_ignore_all_dups
            setopt hist_reduce_blanks
            setopt inc_append_history
            setopt share_history

            bindkey -v

            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
            zstyle ':completion:*' menu select
            zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"

            chpwd() {
                ls
            }

            y() {
                local tmp cwd
                tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return
                yazi "$@" --cwd-file "$tmp"
                cwd="$(command cat "$tmp" 2>/dev/null)"
                if [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
                    cd "$cwd" || return
                fi
                command rm -f "$tmp"
            }

            commit() {
                if [[ "$#" -eq 0 ]]; then
                    echo "Usage: commit <message>"
                    return 1
                fi
                git commit -m "$*"
            }

            fzf() {
                SHELL="${pkgs.bash}/bin/bash" command fzf "$@"
            }

            ff() {
                local files
                files="$(fzf --multi)"
                if [[ -z "$files" ]]; then
                    return
                fi
                print -r -- "$files" | xargs -r nvim
            }

            # if [[ -z "$ZELLIJ" && "$TERM_PROGRAM" == "ghostty" ]]; then
            #     zellij
            # fi
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
            # grep = "rg";

            # Safety
            rm = "rm -i";
            cp = "cp -i";
            mv = "mv -i";

            # Git
            add = "git add .";
            g = "git";
            push = "git push origin";
            gd = "git diff";

            # Nvim
            vi = "nvim";
            vim = "nvim";

            # Zellij
            j = "zellij";
        };
    };

    programs.starship.enableZshIntegration = true;
    programs.zoxide.enableZshIntegration = true;
    programs.carapace.enableZshIntegration = true;
    programs.direnv.enableZshIntegration = true;
}
