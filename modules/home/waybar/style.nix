{ ... }:
{
  programs.waybar.style = builtins.readFile ./colors.css + ''
    * {
      font-family: Maple Mono;
      font-size: 16px;
      font-weight: bold;
    }

    window#waybar {
      background-color: @fg;
      border-bottom-color: #7d6a40;
      border-bottom-style: solid;
      border-bottom-width: 5px;
      border-radius: 0px 0px 15px 15px;
      color: @bg0;
      transition-duration: 0.5s;
      transition-duration: 0.5s;
      transition-property: background-color;
    }

    tooltip {
      background: @blue;
      border-bottom: 5px solid #366660;
      border-radius: 8px;
      color: @bg0;
    }

    #workspaces {
      padding: 0;
    }

    #workspaces button {
      color: @red;
    }

    #workspaces button.empty {
      color: @fg;
    }

    #workspaces button.active {
      background-color: @blue;
      border-bottom-color: #366660;
      border-bottom-style: solid;
      border-bottom-width: 5px;
      border-radius: 8px;
      color: @bg0;
      margin-bottom: -5px;
    }

    .module,
    #custom-launcher,
    #custom-power,
    #custom-notifications,
    #clock,
    #cpu,
    #memory,
    #disk,
    #pulseaudio,
    #bluetooth,
    #network,
    #battery {
      background-color: @bg0;
      border-bottom-color: #161a1d;
      border-bottom-style: solid;
      border-bottom-width: 5px;
      border-radius: 8px;
      color: @fg;
      margin-bottom: 12px;
      margin-top: 7px;
      padding-left: 10px;
      padding-right: 10px;
    }

    #custom-launcher {
      background-color: @orange;
      border-bottom-color: #814c33;
      color: @bg0;
      margin-left: 10px;
      padding: 0 20px 0 20px;
    }

    #custom-notifications {
      background-color: @purple;
      border-bottom-color: #663c51;
      color: @bg0;
      padding: 0 20px 0 20px;
    }

    #custom-power {
      background-color: @red;
      border-bottom-color: #951c1f;
      color: @bg0;
      margin-right: 10px;
      padding: 0 20px 0 20px;
    }
  '';
}
