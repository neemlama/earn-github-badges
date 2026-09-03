# badge-test 🏆
Fastest way to earn 4 GitHub Achievements - 1 Click!

Earn **Quickdraw**, **YOLO**, **Pair Extraordinaire**, **Pull Shark** in under 2 minutes.

### Option 1: Easiest - No Code (Recommended for beginners)

1. **Fork** this repo (click `Fork` button top-right)
2. Go to your fork -> `Actions` tab -> Click `I understand my workflows, go ahead and enable them`
3. Click `Earn GitHub Badges (1-Click)` -> Click `Run workflow` -> `Run workflow`
4. Wait 1-2 minutes for ✅ green check
5. Done! Check your badges at `https://github.com/YOUR_USERNAME?tab=achievements` (takes ~30 mins to appear)

> No install needed! Workflow uses your `GITHUB_TOKEN` automatically.

### Option 2: Local Script (Windows / Mac / Linux)

```bash
# 1. Fork this repo on GitHub, then:
git clone https://github.com/YOUR_USERNAME/badge-test.git
cd badge-test

# 2. Login to GitHub CLI (only first time)
gh auth login

# 3. Run script:
# Windows PowerShell:
.\scripts\earn-badges.ps1

# Mac/Linux:
bash scripts/earn-badges.sh
```

### What it does

| Step | Badge | How |
|------|-------|-----|
| 1 | **Quickdraw** | Creates an issue and closes it within seconds |
| 2 | **YOLO + Pair Extraordinaire** | Creates branch `badge-v1` with `Co-authored-by` commit, opens PR and merges without review |
| 3 | **Pull Shark** | Creates branch `badge-v2`, opens 2nd PR and merges (2 merged PRs = Pull Shark) |

### Manual Method

If automation fails, do it manually:
1. Create Issue -> Close immediately = Quickdraw
2. Branch `v1` -> Add file -> Commit with `Co-authored-by: Name <email>` -> Push -> PR -> Merge without review = Pair Extraordinaire + YOLO
3. Branch `v2` -> Add file -> Push -> PR -> Merge = Pull Shark

---
⭐ Star this repo if it helped you!
