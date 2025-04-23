/**
  This configuration sets up Git with personalized settings.
*/

{ pkgs, ... }:
{
  programs.git = {
    # Enables the Git.
    enable = true;

    # Sets the global Git username.
    userName = "arihantb";

    # Sets the global Git email.
    userEmail = "arihantbedagkar@gmail.com";

    extraConfig = {
      # Default branch name on new repo.
      init.defaultBranch = "main";

      # Stores credentials in plain text.
      credential.helper = "store";

      # Shows base version during merge conflicts.
      merge.conflictstyle = "diff3";

      # Uses default color scheme for moved lines.
      diff.colorMoved = "default";
    };

    delta = {
      # A better pager for Git.
      enable = true;

      options = {
        # Show line numbers in diffs.
        line-numbers = true;

        # Side-by-side diff layout.
        side-by-side = true;

        # Fancy diff formatting.
        diff-so-fancy = true;

        # Keyboard navigation for diff hunks.
        navigate = true;
      };
    };
  };

  # Config for lazygit.
  xdg.configFile."lazygit/config.yml".text = ''
    gui:
      border: single
  '';

  home.packages = with pkgs; [
    # TUI for Git commands.
    lazygit
  ];
}
