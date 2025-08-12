{ ... }:
{
  programs.waybar.settings.mainBar = {
    height = 60;
    layer = "top";
    margin-top = 0;
    margin-bottom = 0;
    margin-left = 20;
    margin-right = 20;
    position = "top";
    spacing = 10;

    modules-left = [
      "custom/launcher"
      "cpu"
      "memory"
      "disk"
      "clock"
      "tray"
    ];

    modules-center = [
      "hyprland/workspaces"
    ];

    modules-right = [
      "pulseaudio"
      "backlight"
      "bluetooth"
      "network"
      "battery"
      "custom/notifications"
      "custom/power"
    ];

    "custom/launcher" = {
      format = "󱄅";
      on-click = "rofi -show drun";
      tooltip = true;
      tooltip-format = "Apps Menu";
    };

    "hyprland/workspaces" = {
      active-only = false;
      disable-scroll = true;
      format = "{icon}";
      on-click = "activate";
      persistent-workspaces = {
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
      };
    };

    clock = {
      calendar = {
        mode = "month";
        mode-mon = true;
        format = {
          today = "<span color='red'><b>{}</b></span>";
        };
      };
      format = "󰥔 {:%I:%M:%S %p}";
      format-alt = "󰃭 {:%A, %B %d, %Y}";
      interval = 1;
      tooltip-format = "<tt>{calendar}</tt>";
    };

    cpu = {
      format = "󰻠 {usage}%";
      format-alt = "󰻠 {avg_frequency}GHz";
      interval = 1;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 950] kitty --override font_size=14 --title float_kitty btop'";
    };

    memory = {
      format = "󰍛 {percentage}%";
      format-alt = "󰍛 {used:0.1f}GiB";
      interval = 1;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 950] kitty --override font_size=14 --title float_kitty btop'";
      tooltip = true;
      tooltip-format = "Swap: {swapPercentage}%";
    };

    disk = {
      format = "󰋊 {percentage_used}%";
      format-alt = "󰋊 {used}/{total}";
      interval = 60;
      on-click-right = "hyprctl dispatch exec '[float; center; size 950 950] nemo'";
      tooltip = true;
      tooltip-format = "Free: {free}";
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-icons = [
        "󰕿"
        "󰖀"
        "󰕾"
      ];
      format-muted = "󰝟 Mute";
      on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      on-click-right = "hyprctl dispatch exec '[float; center; size 450 300] pavucontrol'";
      reverse-scrolling = true;
      scroll-step = 5;
      smooth-scrolling-threshold = 5;
      tooltip = true;
      tooltip-format = "{desc}";
    };

    backlight = {
      device = "nvidia_0";
      format = "{icon} {percent}%";
      format-icons = [
        "󰃚"
        "󰃛"
        "󰃜"
        "󰃝"
        "󰃞"
        "󰃟"
        "󰃠"
      ];
      reverse-scrolling = true;
      scroll-step = 5;
      smooth-scrolling-threshold = 5;
      tooltip = true;
    };

    bluetooth = {
      format = "󰂯 {status}";
      format-connected = "󰂱 {device_alias}";
      format-connected-battery = "󰂱 {device_alias} ({device_battery_percentage})%";
      format-disabled = "󰂲";
      on-click-right = "hyprctl dispatch exec '[float; center; size 350 350] blueman-manager'";
      tooltip = true;
      tooltip-format = "{device_enumerate}";
      tooltip-format-connected = "MAC: {controller_address}";
    };

    network = {
      format = "󰇧 {ipaddr}";
      format-alt = "{icon} {essid}";
      format-disconnected = "󰇨";
      format-ethernet = "󰈀 {ipaddr}/{cidr}";
      format-icons = [
        "󰤯"
        "󰤟"
        "󰤢"
        "󰤥"
        "󰤨"
      ];
      format-wifi = "{icon} {signalStrength}%";
      on-click-right = "hyprctl dispatch exec '[float; center; size 350 350] nm-connection-editor'";
      tooltip = true;
      tooltip-format = "{ipaddr}";
      tooltip-format-disconnected = "Disconnected";
      tooltip-format-wifi = "{essid} ({ipaddr})";
      tooltip-format-wifi-alt = "{ipaddr}";
    };

    battery = {
      format = "{icon} {capacity}%";
      format-charging = "{icon} {capacity}%";
      format-critical = "󱟩 {capacity}%";
      format-full = "󰁹 {capacity}%";
      format-icons = {
        charging = [
          "󰢜"
          "󰂆"
          "󰂇"
          "󰂈"
          "󰢝"
          "󰂉"
          "󰢞"
          "󰂊"
          "󰂋"
          "󰂅"
        ];
        discharging = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
      format-time = "{H}h {M}m";
      format-warning = "󱃍 {capacity}%";
      interval = 5;
      on-click-right = "hyprctl dispatch exec '[float; center; size 350 350] gnome-control-center power'";
      states = {
        warning = 20;
        critical = 10;
      };
      tooltip = true;
      tooltip-format = "{time}";
    };

    "custom/notifications" = {
      escape = true;
      exec = "swaync-client -swb";
      exec-if = "which swaync-client";
      format = "{icon}";
      format-icons = {
        dnd-inhibited-none = "󰅸";
        dnd-inhibited-notification = "󱅫";
        dnd-none = "󰪑";
        dnd-notification = "󰂛";
        inhibited-none = "󰅸";
        inhibited-notification = "󱅫";
        none = "󰂜";
        notification = "󰂚";
      };
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      return-type = "json";
      tooltip = true;
      tooltip-format = "Notifications";
    };

    "custom/power" = {
      format = "󰐥";
      on-click = "power-menu";
      tooltip = true;
      tooltip-format = "Power Menu";
    };
  };
}
