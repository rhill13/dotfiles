{ config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Enable flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "temp";
  networking.networkmanager.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    fish
    neovim
    git
    wget
    curl
    firefox
    # BSPWM related packages
    sxhkd         # Simple X hotkey daemon - required for BSPWM
    dmenu         # Application launcher
    polybar       # Status bar
    feh           # Image viewer and wallpaper setter
    dunst         # Notification daemon
    xss-lock      # X screen saver lock
    slock         # Simple X display locker
    pcmanfm       # File manager
    xclip         # Clipboard manager
    flameshot     # Screenshot tool
  ];

  # User account
  users.users.ryan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  # System settings
  time.timeZone = "UTC";
  system.stateVersion = "24.05";

  # Enable sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # X11 and Window Manager
  services.xserver = {
    enable = true;
    layout = "us";
    libinput.enable = true;  # Enable touchpad support
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "none+bspwm";
    windowManager.bspwm.enable = true;
  };
}
