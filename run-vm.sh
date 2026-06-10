#!/usr/bin/env bash

nixos-rebuild build-vm --flake .#desktop --impure && ./result/bin/run-nixos-coolguy-vm 
