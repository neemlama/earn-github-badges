#!/bin/bash
# 1-Click Badge Script for Mac/Linux - 6 Badges
# Usage: git clone <your-fork> && cd earn-github-badges && bash scripts/earn-badges.sh
set -e
echo "🎯 Earning 6 GitHub Badges - Quickdraw, YOLO, Pair Extraordinaire, Pull Shark x4, Galaxy Brain"

command -v git >/dev/null || { echo "❌ git not found"; exit 1; }
command -v gh >/dev/null || { echo "❌ gh CLI not found. https://cli.github.com"; exit 1; }
gh auth status >/dev/null 2>&1 || { echo "❌ Not logged in. Run: gh auth login"; exit 1; }

REPO=$(gh repo view --json nameWithOwner -q .nameWithOwner)
echo "📦 Repo: $REPO"

echo ""
echo "1/6 Quickdraw..."
ISSUE_URL=$(gh issue create --title "Quickdraw badge" --body "Closing for Quickdraw")
ISSUE_NUMBER=$(echo $ISSUE_URL | rev | cut -d'/' -f1 | rev)
sleep 2
gh issue close $ISSUE_NUMBER --reason "completed"
echo "✅ Quickdraw done"
sleep 5

echo ""
echo "2/6 YOLO + Pair Extraordinaire..."
git checkout -B badge-v1
echo "Hello badge v1 - $(date)" > badge-v1.txt
git add badge-v1.txt
git commit -m "Add badge v1

Co-authored-by: Contrib <contrib@users.noreply.github.com>"
git push -u origin badge-v1 --force
gh pr create --title "Badge PR 1 - YOLO & Pair Extraordinaire" --body "YOLO + Pair Extraordinaire" --base main --head badge-v1
sleep 7
gh pr merge badge-v1 --merge --admin --delete-branch
echo "✅ YOLO + Pair Extraordinaire done"
sleep 5

for i in 2 3 4; do
  echo ""
  echo "$((i+1))/6 Pull Shark PR $i..."
  git checkout main
  git pull origin main
  git checkout -B badge-v$i
  echo "Hello badge v$i - $(date)" > badge-v$i.txt
  git add badge-v$i.txt
  git commit -m "Add badge v$i"
  git push -u origin badge-v$i --force
  gh pr create --title "Badge PR $i - Pull Shark" --body "$i PR for Pull Shark" --base main --head badge-v$i
  sleep 7
  gh pr merge badge-v$i --merge --admin --delete-branch
  echo "✅ Pull Shark PR $i done (branch auto-deleted)"
  sleep 5
done

echo ""
echo "6/6 Galaxy Brain..."
HAS_DISCUSSIONS=$(gh api repos/$REPO --jq .has_discussions)
if [ "$HAS_DISCUSSIONS" != "true" ]; then
  echo "⚠️ Discussions not enabled. Enable: Settings -> General -> Features -> Discussions"
else
  echo "Discussions enabled. Galaxy Brain automated via Actions workflow."
  echo "Local script skips GraphQL to stay safe - use Actions for full Galaxy Brain."
fi

echo ""
echo "🎉 All done! Check https://github.com/$(gh api user -q .login)?tab=achievements in 30 mins"
echo "Safe: 4 PRs + delays + own fork = no flag"
