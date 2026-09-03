#!/bin/bash
# 1-Click Badge Script for Mac/Linux
# Usage: git clone <your-fork> && cd badge-test && bash scripts/earn-badges.sh
# Requires: git and gh CLI + gh auth login
set -e
echo "🎯 Earning GitHub Badges - Quickdraw, YOLO, Pair Extraordinaire, Pull Shark"

command -v git >/dev/null || { echo "❌ git not found"; exit 1; }
command -v gh >/dev/null || { echo "❌ gh CLI not found. Install from https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "❌ Not logged in. Run: gh auth login"; exit 1; }

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "📦 Repo: $REPO"

echo ""
echo "1/3 Quickdraw..."
ISSUE_URL=$(gh issue create --title "Quickdraw badge" --body "Closing for Quickdraw")
ISSUE_NUMBER=$(echo $ISSUE_URL | rev | cut -d'/' -f1 | rev)
sleep 2
gh issue close $ISSUE_NUMBER --reason "completed"
echo "✅ Quickdraw done - issue #$ISSUE_NUMBER closed"

echo ""
echo "2/3 YOLO + Pair Extraordinaire..."
git checkout -B badge-v1
echo "Hello badge v1 - $(date)" > badge-v1.txt
git add badge-v1.txt
git commit -m "Add badge v1

Co-authored-by: Contrib <contrib@users.noreply.github.com>"
git push -u origin badge-v1 --force
gh pr create --title "Badge PR 1 - YOLO & Pair Extraordinaire" --body "YOLO + Pair Extraordinaire" --base main --head badge-v1
sleep 5
gh pr merge badge-v1 --merge --admin --delete-branch=false
echo "✅ YOLO + Pair Extraordinaire done"

echo ""
echo "3/3 Pull Shark..."
git checkout main
git pull origin main
git checkout -B badge-v2
echo "Hello badge v2 - $(date)" > badge-v2.txt
git add badge-v2.txt
git commit -m "Add badge v2"
git push -u origin badge-v2 --force
gh pr create --title "Badge PR 2 - Pull Shark" --body "2nd PR for Pull Shark" --base main --head badge-v2
sleep 5
gh pr merge badge-v2 --merge --admin --delete-branch=false
echo "✅ Pull Shark done"

echo ""
echo "🎉 All done! Check https://github.com/$(gh api user -q .login)?tab=achievements in 30 mins"
