#!/usr/bin/env bash

update_config() {
  local file="configuration.nix"

  # Memastikan file ada sebelum diproses
  if [ ! -f "$file" ]; then
    echo "Error: File $file not found!"
    return 1
  fi

  if [[ "$OSTYPE" = linux* ]]; then
    echo "Changing configuration to Linux..."
    # Searching 'darwin' and replace it with 'linux'
    sed -i 's/darwin/linux/g' "$file" && git add $file
  else
    echo "Changing configuration to Darwin (macOS)..."
    # Searching 'linux' and replace it with 'darwin'
    sed -i 's/linux/darwin/g' "$file" && git add $file
  fi

  echo "Done!"
  grep -E "linux|darwin" "$file"
}

update_config