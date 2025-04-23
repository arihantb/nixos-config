/**
  This configuration sets up a fuzzy finder for smarter searching with enhanced preview UI.
*/

{ ... }:
{
  programs.fzf = {
    # Enable a powerful fuzzy finder.
    enable = true;

    # Adds Zsh shell integration for features like fuzzy history search, file search, etc..
    enableZshIntegration = true;

    # Replaces the default FZF file search with `fd`, including hidden files but excluding `.git` folders.
    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";

    fileWidgetOptions = [
      # Customises the FZF file preview widget.
      "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
    ];

    # Uses `fd` to list directories, including hidden folders but excluding `.git` folders.
    changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";

    changeDirWidgetOptions = [
      # Preview tree view of selected directory while using the change-dir widget.
      "--preview 'eza --tree --color=always {} | head -200'"
    ];

    # Gruvbox theme for FZF.
    defaultOptions = [
      "--color=fg:-1,fg+:#FBF1C7,bg:-1,bg+:#282828"
      "--color=hl:#98971A,hl+:#B8BB26,info:#928374,marker:#D65D0E"
      "--color=prompt:#CC241D,spinner:#689D6A,pointer:#D65D0E,header:#458588"
      "--color=border:#665C54,label:#aeaeae,query:#FBF1C7"
      "--border='double' --border-label='' --preview-window='border-sharp' --prompt='> '"
      "--marker='>' --pointer='>' --separator='─' --scrollbar='│'"
      "--info='right'"
    ];
  };
}
