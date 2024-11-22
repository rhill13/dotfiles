# dotfiles

## Steps
1. Clone into home directoy as `.config`
2. Link hardware configuration `cp /etc/nixos/hardware-configuration.nix ~/.config/nixos/`
3. Build configuration: `sudo nixos-rebuild switch --flake .#thinkpad`
