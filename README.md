# `arch-setup`
This repo contains the scripts and the dotfiles I currently use as my daily driver.
It contains some scripts to bootstrap the installation of a new instance of my Arch Linux configuration.

# The OS
Arch Linux with a slightly more hardened config than the usual Arch Linux install. 

## Hardening steps
### Kernel and memory allocator
These scripts use `linux-hardened` as kernel and `hardened_malloc` as memory allocator.

### Disk encryption
Full Disk Encryption is enabled using LUKS + btrfs.

### Secure boot
These scripts don't cover that, but I also manually configure Secure Boot with `sbctl`, 
to account for Evil Maid attacks (w/ Microsoft keys, because I already bricked a laptop
using my own keys only).

I would like to add SELinux one day, but I don't know how well Arch Linux does support it.

### NTS
Sets up NTS (secure network time protocol) with cloudflare's servers using `chrony`.

### DNS-over-TLS
Sets up DNS over TLS with `systemd-resolved`.

### The DE
This repo sets up `sway`, `firefox`, `mpv`, `imv`, `zathura`, `spotifyd` and few other utilities.

### Terminal emulator
I use foot and fish + tide as shell.

## Installation
 * Download the latest archiso.
 * Clone this repo.
 * Run `./install-base.sh`
 * Reboot into the newly created Arch system.
 * Clone the repo again and run `./install-packages.sh`
 * Profit!

## Todo
Make archinstall phase simple as `curl https://arch.tortel.li | sh`.