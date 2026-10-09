#!/usr/bin/env bash

# Automatically launch Nushell in interactive sessions
if [[ $- == *i* ]] && command -v nu >/dev/null 2>&1; then
    exec nu
fi