{ config, pkgs, ... }: {
  home.username = "ryan";
  home.homeDirectory = "/home/ryan";
  home.stateVersion = "24.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Install user packages
  home.packages = with pkgs; [
    firefox
    # BSPWM related packages
    sxhkd          # Simple X hotkey daemon - required for BSPWM
    dmenu          # Application launcher
    polybar        # Status bar
    feh            # Image viewer and wallpaper setter
    dunst          # Notification daemon
    xss-lock      # X screen saver lock
    slock         # Simple X display locker
    pcmanfm       # File manager
    xclip         # Clipboard manager
    flameshot     # Screenshot tool
  ];

  # Fish shell configuration
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAliases = {
      ll = "ls -la";
      update = "sudo nixos-rebuild switch --flake ~/.config/nixos#thinkpad";
      config = "nvim ~/.config/nixos/home.nix";
    };
  };

  # Kitty terminal configuration
  programs.kitty = {
    enable = true;
    settings = {
      font_size = 11;
      window_padding_width = 5;
      background_opacity = "0.95";
    };
  };

  # Polybar configuration
  services.polybar = {
    enable = true;
    script = "polybar main &";
    config = {
      "bar/main" = {
        width = "100%";
        height = 27;
        background = "#282828";
        foreground = "#ebdbb2";
        padding-left = 0;
        padding-right = 2;
        module-margin = 1;
        font-0 = "DejaVu Sans:size=10;2";
        font-1 = "Font Awesome 6 Free:style=Solid:size=10;2";
        modules-left = "bspwm";
        modules-center = "date";
        modules-right = "memory cpu";
      };
      "module/bspwm" = {
        type = "internal/bspwm";
        pin-workspaces = true;
        label-focused = "%name%";
        label-focused-background = "#504945";
        label-focused-padding = 2;
        label-occupied = "%name%";
        label-occupied-padding = 2;
        label-empty = "%name%";
        label-empty-padding = 2;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };
      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        format-prefix = "CPU ";
        label = "%percentage%%";
      };
      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        format-prefix = "RAM ";
        label = "%percentage_used%%";
      };
    };
  };

  # BSPWM configuration
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {
      border_width = 2;
      window_gap = 12;
      split_ratio = 0.52;
      borderless_monocle = true;
      gapless_monocle = true;
    };
    startupPrograms = [
      "bspc monitor -d home dev web util mus"  # Initialize workspaces
      "feh --bg-fill ./am.png"  # Set wallpaper
      "xss-lock -- slock"                     # Start screen locker
      "dunst"                                 # Start notification daemon
    ];
  };

  # Dunst configuration
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 300;
        height = 300;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        frame_color = "#282828";
        font = "DejaVu Sans 10";
      };
      urgency_low = {
        background = "#282828";
        foreground = "#ebdbb2";
        timeout = 5;
      };
      urgency_normal = {
        background = "#282828";
        foreground = "#ebdbb2";
        timeout = 10;
      };
      urgency_critical = {
        background = "#cc241d";
        foreground = "#ebdbb2";
        timeout = 0;
      };
    };
  };

  # SXHKD configuration for BSPWM
  services.sxhkd = {
    enable = true;
    keybindings = {
      # Terminal
      "super + Return" = "kitty";
      # Application launcher
      "super + space" = "dmenu_run";
      # File manager
      "super + e" = "pcmanfm";
      # Screenshot
      "Print" = "flameshot gui";
      # Kill window
      "super + q" = "bspc node -k";
      # Toggle monocle layout
      "super + m" = "bspc desktop -l next";
      # Lock screen
      "super + l" = "slock";

      # Workspace switching
      "super + {1-5}" = "bspc desktop -f {home,dev,web,util,mus}";
      # Move windows to workspaces
      "super + shift + {1-5}" = "bspc node -d {home,dev,web,util,mus}";
    };
  };

  # Neovim configuration
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "rhill13";
    userEmail = "ryanhill1128@gmail.com";
  };
}
