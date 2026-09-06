#!/usr/bin/env bash
set -euo pipefail

# Builds the personal fork and installs it as the primary app in /Applications, replacing whatever
# is there. Uses the real bundle id so existing settings carry over. The build ships no Sparkle
# feed, so upstream releases never overwrite it. Re-run after merging upstream.
#
# Usage: script/install_local.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APP_NAME="OpenUsage"
SRC_APP="$ROOT_DIR/dist/$APP_NAME.app"
DEST_APP="/Applications/$APP_NAME.app"

BUNDLE_ID=com.robinebers.openusage "$ROOT_DIR/script/build_and_run.sh" build

echo "==> installing $DEST_APP"
pkill -x "$APP_NAME" >/dev/null 2>&1 || true
rm -rf "$DEST_APP"
cp -R "$SRC_APP" "$DEST_APP"

/usr/bin/open "$DEST_APP"
echo "==> launched $DEST_APP"
