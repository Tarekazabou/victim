#!/bin/bash
set -e

RUNNER_VERSION="2.334.0"
RUNNER_HASH="048024cd2c848eb6f14d5646d56c13a4def2ae7ee3ad12122bee960c56f3d271"
REPO_URL="https://github.com/Tarekazabou/victim"
RUNNER_TOKEN="BNFUSRTA5MLEYRV7OVPA5NLJ7CK7U"   # <-- fill in fresh token, never share this
RUNNER_DIR="$HOME/actions-runner"

# 1. Clean up any old runner service
if [ -f "$RUNNER_DIR/svc.sh" ]; then
  echo "Removing old service..."
  cd "$RUNNER_DIR"
  sudo ./svc.sh uninstall 2>/dev/null || true
  cd ~
fi

# 2. Remove old runner directories
rm -rf "$RUNNER_DIR" "$HOME/actions-runner2"

# 3. Create fresh runner folder
mkdir -p "$RUNNER_DIR" && cd "$RUNNER_DIR"

# 4. Download
curl -o runner.tar.gz -L \
  "https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"

# 5. Validate hash
echo "${RUNNER_HASH}  runner.tar.gz" | shasum -a 256 -c

# 6. Extract
tar xzf runner.tar.gz && rm runner.tar.gz

# 7. Configure (non-interactive, replaces existing)
./config.sh \
  --url "$REPO_URL" \
  --token "$RUNNER_TOKEN" \
  --name "$(hostname)" \
  --labels "self-hosted,Linux,X64" \
  --work "_work" \
  --replace \
  --unattended

# 8. Install & start as background systemd service
sudo ./svc.sh install
sudo ./svc.sh start
sudo ./svc.sh status