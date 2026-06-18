#!/bin/sh
# Auto-sync to GitHub: pushes any unpushed commits every 60 seconds

REMOTE_URL="https://Dead666646:${GITHUB_PERSONAL_ACCESS_TOKEN}@github.com/Dead666646/lva-site8.git"

echo "[github-sync] Starting auto-sync loop (every 60s)..."

while true; do
  if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
    echo "[github-sync] ERROR: GITHUB_PERSONAL_ACCESS_TOKEN is not set"
    sleep 60
    continue
  fi

  LOCAL=$(git rev-parse HEAD 2>/dev/null)
  REMOTE=$(git ls-remote "$REMOTE_URL" refs/heads/main 2>/dev/null | awk '{print $1}')

  if [ "$LOCAL" != "$REMOTE" ]; then
    echo "[github-sync] $(date '+%H:%M:%S') New commits detected, pushing..."
    git push "$REMOTE_URL" main 2>&1 | grep -v "Dead666646"
    echo "[github-sync] Done."
  else
    echo "[github-sync] $(date '+%H:%M:%S') Up to date."
  fi

  sleep 60
done
