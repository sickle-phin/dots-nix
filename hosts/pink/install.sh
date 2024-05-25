#!/usr/bin/env bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ~/dots-nix/hosts/pink/disk-config.nix
