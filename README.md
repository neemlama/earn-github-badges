# earn-github-badges 🏆
Fastest way to earn 6 GitHub Achievements - 1 Click! Safe & No Flag

Earn **Quickdraw**, **YOLO**, **Pair Extraordinaire**, **Pull Shark x4**, **Galaxy Brain** in ~3 minutes.

### Option 1: Easiest - No Code (Recommended)

**⚠️ One-time Settings (Required - 30 sec):**

Before first run, enable these in YOUR FORK:

**A. Enable Discussions (for Galaxy Brain):**
`Your Fork` -> `Settings` -> `General` -> `Features` -> ✅ Check `Discussions` -> Save

**B. Allow Actions to create PRs (fixes `createPullRequest` error):**
`Your Fork` -> `Settings` -> `Actions` -> `General` -> Scroll to `Workflow permissions` -> ✅ Check `Allow GitHub Actions to create and approve pull requests` -> `Save`

Then run:

1. **Fork** this repo (click `Fork` top-right)
2. Go to `Actions` tab in your fork -> `I understand my workflows, go ahead and enable them`
3. Click workflow `Earn GitHub Badges (1-Click) - 6 Badges` -> `Run workflow` -> `Run workflow`
4. Wait 2-3 mins for ✅ green check
5. Done! Check `https://github.com/YOUR_USERNAME?tab=achievements` (takes ~30 mins)

> No install needed! Uses `GITHUB_TOKEN` automatically. Rate-safe: delays + own fork = no flag.

### Option 2: Local Script (Windows / Mac / Linux)

```bash
# 1. Fork, then:
git clone https://github.com/YOUR_USERNAME/earn-github-badges.git
cd earn-github-badges

# 2. Login (first time)
gh auth login

# 3. Run:
# Windows:
.\scripts\earn-badges.ps1

# Mac/Linux:
bash scripts/earn-badges.sh
```

### What it does (Rate-Safe)

| Step | Badge | How | Delay |
|------|-------|-----|-------|
| 1 | **Quickdraw** | Create issue and close in 2 sec | 5s |
| 2 | **YOLO + Pair Extraordinaire** | `badge-v1` with `Co-authored-by`, PR merge without review | 7s |
| 3 | **Pull Shark** | `badge-v2` PR + merge | 7s |
| 4 | **Pull Shark** | `badge-v3` PR + merge | 7s |
| 5 | **Pull Shark** | `badge-v4` PR + merge (safe max 4) | 7s |
| 6 | **Galaxy Brain** | 2 Discussions + answers + mark as accepted (if enabled) | 5s |

**Total: 4 PRs + 1 Issue + 2 Discussions = 6 Badges. All in OWN fork, no spam.**

### Why No Flag?

- ✅ Max 4 PRs per run (not 50)
- ✅ `sleep 5-7s` between API calls (no abuse)
- ✅ Real commits, real PRs, own fork only
- ✅ Run once per fork
- ❌ Never fake stars (Starstruck) - that's what gets flagged

### Troubleshooting

**Error: `GitHub Actions is not permitted to create or approve pull requests (createPullRequest)`**
Fix: `Settings` -> `Actions` -> `General` -> `Workflow permissions` -> ✅ `Allow GitHub Actions to create and approve pull requests` -> `Save` -> Re-run workflow. This is OFF by default in all forks.

**Error: `Galaxy Brain` skipped / `has_discussions: false`**
Fix: `Settings` -> `General` -> `Features` -> ✅ `Discussions` -> Save. Re-run workflow. Or ignore - you still get 5 badges without it.

**Error: `Workflow not showing`**
Fix: `Actions` tab -> `I understand my workflows, go ahead and enable them`

**Badges not showing after run?**
Wait 30-60 mins, hard refresh `https://github.com/YOUR_USERNAME?tab=achievements`. GitHub is slow. Re-run once if needed (branches use `--force` so safe to re-run).

### Manual Fallback

If workflow fails: Create Issue->Close=Quickdraw, Branch v1 with co-author->PR->Merge=YOLO+Pair, Branches v2-v4->PR->Merge=Pull Shark

---
⭐ Star this repo if it helped you!
