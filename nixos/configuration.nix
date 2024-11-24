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
    neovim
    git
    wget
    curl
    ly
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
    
    windowManager.bspwm.enable = true;
    
    # Disable default display manager
    displayManager.lightdm.enable = true;
  };
}
