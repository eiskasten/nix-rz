# rz NixOS Configuration

This repository contains the whole Nix configuration of the rz.

## Secret Provisioning

The sops architecture is built in a modular way.
Two different tiers of age keys exist: system wide keys and home keys.
They are encrypted using GPG but not with other age keys.
This results in the necessity that they have to be copied to the target before system activation:

```shell
# Decrypt keys on the current machine
sops unencrypt modules/secrets/age/fucik.txt.sops
sops unencrypt modules/secrets/age/r3s-home.txt.sops

# Copy them to the target system (might be the same system)
doas cp modules/secrets/age/*.txt /var/lib/sops-nix


```
