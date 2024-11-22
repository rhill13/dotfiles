# dotfiles

## Steps
1. Clone into home directoy as `.config`
2. Link hardware configuration `cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/`
3. In `configuration.nix` update hostname and user initialPassword
4. Inside `~/.config/nixos` build the configuration: `sudo nixos-rebuild switch --flake .#thinkpad`
