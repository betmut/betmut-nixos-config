#!/usr/bin/env bash

nix-shell-packages() {
  nix-shell -p "$@" --command $NIX_SHELL_CUSTOM_PROMPT
}