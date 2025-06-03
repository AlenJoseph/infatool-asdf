# ASDF + Dev Tools Installer

This script installs the [asdf version manager](https://github.com/asdf-vm/asdf) along with several popular development tools via `asdf` plugins (Terraform, Terragrunt, Kubectl, Helm, SOPS, AWS CLI).

## ✅ What It Does

- Installs system dependencies (`git`, `golang`, `build-essential`, etc.)
- Clones and builds `asdf` from source
- Adds `asdf` to your path
- Installs and sets global versions for:
  - `terraform`
  - `terragrunt`
  - `kubectl`
  - `helm`
  - `sops`
  - `awscli`

## 📦 Requirements

- Ubuntu (or any Debian-based system)
- `sudo` access
- Internet connection

## 🚀 Installation

Run the following commands in your terminal:

```bash
curl -o install_asdf_with_devtools.sh https://raw.githubusercontent.com/AlenJoseph/infatool-asdf/refs/heads/main/install_asdf_with_devtools.sh
chmod +x install_asdf_with_devtools.sh
./install_asdf_with_devtools.sh
