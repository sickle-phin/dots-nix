#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)"
sudo nix --experimental-features "nix-command flakes" run --no-write-lock-file "${repo_root}#disko" -- --mode disko "${repo_root}/hosts/irukaha/disk-config.nix"
