{ config, pkgs, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
            enable = true;
            theme = "robbyrussell";
            plugins = [ "git" ];
        };

        # History configuration
        history = {
            size = 10000000;
            save = 10000000;
            path = "$HOME/.zsh_history";
            share = true;
            ignoreDups = true;
            ignoreSpace = true;
            extended = true;
        };

        shellAliases = {
            # NixOS management (most frequently used)
            build = "sudo nixos-rebuild switch --flake ~/.config/nixos#nixos";
            update = "nix flake update ~/.config/nixos#nixos && sudo nixos-rebuild switch --flake ~/.config/nixos#nixos";

            # Directory navigation
            ".." = "cd ..";
            "..." = "cd ../..";
            "...." = "cd ../../..";

            # System info shortcuts
            ass = "asusctl";
            sup = "supergfxctl";
            int = "supergfxctl -m Integrated";
            hyb = "supergfxctl -m Hybrid";
            dgpu = "supergfxctl -m AsusMuxDgpu";

            # Safety aliases
            rm = "rm -i";
            mv = "mv -i";
            cp = "cp -i";

            # General aliases from .zshrc
            ls = "eza --icons --color=always";
            grep = "rg";
            cat = "bat --theme=\"OneHalfDark\"";
            add = "git add .";
            vim = "nvim";
            vi = "nvim";
            curl = "xh";
            j = "zellij";

            # Git
            push = "git push origin master";
        };

        # Additional shell configuration
        initExtra = ''
            bindkey -v

            setopt AUTO_CD              # Change directory without cd
            setopt AUTO_PUSHD           # Make cd push old directory onto stack
            setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
            setopt PUSHD_MINUS          # Swap +/- directions for pushd

            setopt HIST_VERIFY          # Show command with history expansion before running
            setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks

            setopt COMPLETE_IN_WORD     # Complete from both ends of word
            setopt ALWAYS_TO_END        # Move cursor to end after completion
            setopt AUTO_MENU            # Show menu on tab press

            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
            zstyle ':completion:*' menu select
            zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"


            # commit function
            commit() {
              if [ -z "$*" ]; then
                echo "Usage: commit <message>"
                return 1
              fi
              git commit -m "$*"
            }

            # cargo
            export PATH="$HOME/.cargo/bin:$PATH"

            # bun
            export BUN_INSTALL="$HOME/.bun"
            export PATH="$BUN_INSTALL/bin:$PATH"

            # starship
            eval "$(starship init zsh)"

            # zoxide
            eval "$(zoxide init zsh)"

            # fzf
            export FZF_DEFAULT_OPTS="--ansi --preview 'bat --color=always --style=header,grid --line-range :100 {}'"

            ff() {
              local files
              files=($(fzf --multi))
              if [[ -n "$files" ]]; then
                nvim "''${files[@]}"
              fi
            }

            # yazi
            y() {
              local tmp="$(mktemp -t \"yazi-cwd.XXXXXX\")" cwd
              yazi "$@" --cwd-file="$tmp"
              IFS= read -r -d '' cwd < "$tmp"
              [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
              rm -f -- "$tmp"
            }

            # Run ls after every cd
            chpwd() {
              ls
            }
        '';
    };
}
