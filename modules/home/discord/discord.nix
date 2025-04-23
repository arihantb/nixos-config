/**
  This configuration sets up the WebCord Discord client with Vencord plugin support.
*/

{ pkgs, ... }:
{
  # Places the local 'gruvbox.css' theme file into the Vencord themes directory for WebCord.
  xdg.configFile."Vencord/themes/gruvbox.theme.css".source = ./gruvbox.css;

  home.packages = with pkgs; [
    # An Electron-based Discord client preconfigured with Vencord.
    webcord-vencord
  ];
}
