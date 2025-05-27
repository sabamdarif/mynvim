#!/bin/bash
#ghostty -e zsh -l -c "cd \"$1\" && /opt/nvim-linux-x86_64/bin/nvim"
ghostty \
  --fullscreen \
  --working-directory="$1" \
  -e zsh -l -c "$(which nvim) \"$1\""
