/**
  This configuration sets up a modern `cat` clone with syntax highlighting and Git integration.
*/

{ pkgs, ... }:
{
  programs.bat = {
    # Enable the 'bat'.
    enable = true;

    config = {
      # Sets pager behavior: forward-only, raw control characters (no scrollback).
      pager = "less -FR";

      # Gruvbox Dark theme for syntax highlighting.
      theme = "gruvbox-dark";
    };

    extraPackages = with pkgs.bat-extras; [
      # Show colorful diffs.
      batdiff

      # Grep wrapper with highlighting.
      batgrep

      # Colorized man pages.
      batman

      # Smart piping logic for viewing more types of files.
      batpipe

      # Watch for changes in one or more files.
      batwatch

      # Makes bat output prettier for binary/non-source files.
      prettybat
    ];
  };
}
