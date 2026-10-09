#!/usr/bin/env bash

NIX_SHELL_CUSTOM_PROMPT="export PS1='\[\033[1;34m\]❄️ (nix-dev) \[\033[1;32m\][\u@\h] $ \[\033[00m\]'; return"

nix-shell-packages() {
  nix-shell -p "$@" --command $NIX_SHELL_CUSTOM_PROMPT
}