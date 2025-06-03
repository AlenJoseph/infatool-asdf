#!/bin/bash

set -e

ASDF_VERSION="v0.17.0"
ASDF_DIR="$HOME/.asdf"
BIN_DIR="$HOME/.local/bin"

log() {
  echo -e "\033[1;32m➡ $1\033[0m"
}

error() {
  echo -e "\033[1;31m❌ $1\033[0m"
  exit 1
}

log "📦 Installing required system packages..."
sudo apt update
sudo apt install -y git golang-go build-essential curl unzip

log "📁 Cloning asdf $ASDF_VERSION..."
rm -rf "$ASDF_DIR"
git clone https://github.com/asdf-vm/asdf.git "$ASDF_DIR" --branch "$ASDF_VERSION"

log "🔨 Building asdf using Go..."
cd "$ASDF_DIR"
make

log "📂 Installing binary to $BIN_DIR..."
mkdir -p "$BIN_DIR"
cp ./asdf "$BIN_DIR/"

if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  log "🔧 Adding $BIN_DIR to PATH in ~/.bashrc..."
  echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
  export PATH="$HOME/.local/bin:$PATH"
fi

log "✅ Verifying asdf installation..."
if ! command -v asdf >/dev/null 2>&1; then
  error "asdf not found in PATH!"
fi

echo "🎉 Installed asdf version: $(asdf --version)"

# Plugin install function
install_plugin() {
  local name=$1
  local repo=$2

  if asdf plugin list | grep -q "^$name$"; then
    log "🔁 $name plugin already installed, skipping..."
  else
    log "➕ Installing $name plugin..."
    asdf plugin add "$name" "$repo"
  fi

  log "⬇ Installing latest $name..."
  asdf install "$name" latest
  asdf global "$name" latest
}

# Install plugins
install_plugin terraform https://github.com/asdf-community/asdf-hashicorp.git
install_plugin terragrunt https://github.com/ohmer/asdf-terragrunt.git
install_plugin kubectl https://github.com/asdf-community/asdf-kubectl.git
install_plugin helm https://github.com/Antiarchitect/asdf-helm.git
install_plugin sops https://github.com/feniix/asdf-sops.git
install_plugin awscli https://github.com/MetricMike/asdf-awscli.git

log "✅ All tools installed and set globally:"
asdf current
