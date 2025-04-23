/**
  This configuration sets up a modern and colorful resource monitor and an Intel-compatible GPU monitor.
*/

{ pkgs, ... }:
{
  programs.btop = {
    # Enable the btop resource monitor.
    enable = true;

    settings = {
      # Sets a minimal, terminal-friendly color theme.
      color_theme = "gruvbox_dark";

      # Disables theme background for terminal background transparency.
      theme_background = false;

      # Refreshes system stats every 100 milliseconds.
      update_ms = 1000;

      # Enables rounded UI corners.
      rounded_corners = true;

      # TTY symbol to use for graph creation.
      graph_symbol = "tty";

      # Show info boxes.
      shown_boxes = "cpu mem net proc gpu0";
    };

    package = pkgs.btop.override {
      # Add support for Nvidia CUDA.
      cudaSupport = true;
    };
  };
}
