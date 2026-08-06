{ pkgs, ... }:

{
  home.packages = [
    pkgs.jj-starship
  ];

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;

    settings = {
      add_newline = true;
      command_timeout = 1000;

      format = ''
        [╭─](bold green)$directory''${custom.jj}''${custom.jj_files}
        [╰─](bold green)$character
      '';

      directory = {
        style = "bold blue";
        truncation_length = 5;
        truncate_to_repo = false;
      };

      custom.jj = {
        description = "Git and Jujutsu repository information";
        when = "jj-starship detect";
        shell = [ "${pkgs.jj-starship}/bin/jj-starship" ];
        format = "$output";
      };

      custom.jj_files = {
        description = "Jujutsu working-copy file status";

        when = ''
          jj root >/dev/null 2>&1
        '';

        command = ''
          jj status --no-pager --color never |
            awk '
              /^Working copy changes:/ { active = 1; next }
              /^Working copy/ { active = 0 }

              active && /^M / { modified++ }
              active && /^A / { added++ }
              active && /^D / { deleted++ }
              active && /^R / { renamed++ }
              active && /^C / { conflicted++ }

              END {
                if (modified) printf " M:%d", modified
                if (added) printf " A:%d", added
                if (deleted) printf " D:%d", deleted
                if (renamed) printf " R:%d", renamed
                if (conflicted) printf " C:%d", conflicted
              }
            '
        '';

        format = "[$output](bold red)";
        shell = [
          "${pkgs.bash}/bin/bash"
          "--noprofile"
          "--norc"
        ];
      };

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };

      git_branch.disabled = true;
      git_status.disabled = true;
      git_commit.disabled = true;
      git_state.disabled = true;
      git_metrics.disabled = true;
    };
  };
}
