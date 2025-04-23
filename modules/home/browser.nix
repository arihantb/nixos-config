/**
  This configuration sets up the Zen browser.
*/

{ inputs, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Add the default build of zen-browser flake.
    inputs.zen-browser.packages."${system}".default
  ];
}
