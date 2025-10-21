#!/bin/sh

# Run this script from the root directory of your cloned git repository.
echo "--- Starting Forgejo Configuration Setup ---"

# --- Configuration ---
# Assumes this script is run from the root of the cloned git repository.
REPO_PATH=$(pwd)
echo "Configuration repository path detected as: ${REPO_PATH}"

# --- Forgejo app.ini Symlink ---
# Corrected paths based on the FreeBSD package structure.
FORGEJO_CONFIG_SOURCE="${REPO_PATH}/app.ini"
FORGEJO_CONFIG_DEST="/usr/local/etc/forgejo/conf/app.ini"
FORGEJO_CONFIG_DIR="/usr/local/etc/forgejo/conf"

# 1. Check if source app.ini exists
if [ ! -f "${FORGEJO_CONFIG_SOURCE}" ]; then
  echo "[ERROR] 'app.ini' not found in this directory. Exiting."
  exit 1
fi

# 2. Ensure destination directory exists and has correct ownership
echo "Verifying destination directory..."
mkdir -p "${FORGEJO_CONFIG_DIR}"
chown git:git "${FORGEJO_CONFIG_DIR}"

# 3. Create the symlink, forcing an overwrite if the destination exists.
echo "Creating symlink for app.ini..."
ln -sf "${FORGEJO_CONFIG_SOURCE}" "${FORGEJO_CONFIG_DEST}"

# 4. Set ownership on the link itself (good practice)
# The -h flag ensures we change the link, not the file it points to
chown -h git:git "${FORGEJO_CONFIG_DEST}"
