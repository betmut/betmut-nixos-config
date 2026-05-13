#!/usr/bin/env bash

if [ -n "$IN_NIX_SHELL" ]; then
    export PS1="export PS1='\[\033[1;34m\](nix-dev) \[\033[1;32m\][\u@\h] $ \[\033[00m\]'; return"
fi