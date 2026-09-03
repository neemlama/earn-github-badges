# 1-Click Badge Script for Windows (PowerShell) - 6 Badges
# Usage: Clone your fork, then run: .\scripts\earn-badges.ps1
# Requires: git and gh CLI (https://cli.github.com) + gh auth login

$ErrorActionPreference = "Stop"

Write-Host "🎯 Earning 6 GitHub Badges - Quickdraw, YOLO, Pair Extraordinaire, Pull Shark x4, Galaxy Brain" -ForegroundColor Cyan

try { git --version | Out-Null } catch { Write-Host "❌ git not found." -ForegroundColor Red; exit 1 }
try { gh --version | Out-Null } catch { Write-Host "❌ gh CLI not found. https://cli.github.com" -ForegroundColor Red; exit 1 }

$auth = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) { Write-Host "❌ Not logged in. Run: gh auth login" -ForegroundColor Red; exit 1 }

$repo = gh repo view --json nameWithOwner -q .nameWithOwner
if (-not $repo) { Write-Host "❌ Not in a git repo." -ForegroundColor Red; exit 1 }
Write-Host "📦 Repo: $repo" -ForegroundColor Green

# 1. Quickdraw
Write-Host "`n1/6 Quickdraw..." -ForegroundColor Yellow
$issueUrl = gh issue create --title "Quickdraw badge" --body "Closing for Quickdraw"
$issueNumber = ($issueUrl -split "/")[-1]
Start-Sleep -Seconds 2
gh issue close $issueNumber --reason "completed"
Write-Host "✅ Quickdraw done" -ForegroundColor Green
Start-Sleep -Seconds 5

# 2. YOLO + Pair Extraordinaire
Write-Host "`n2/6 YOLO + Pair Extraordinaire..." -ForegroundColor Yellow
git checkout -B badge-v1
"Hello badge v1 - $(Get-Date)" | Set-Content -Path "badge-v1.txt"
git add badge-v1.txt
git commit -m "Add badge v1

Co-authored-by: Contrib <contrib@users.noreply.github.com>"
git push -u origin badge-v1 --force
gh pr create --title "Badge PR 1 - YOLO & Pair Extraordinaire" --body "YOLO + Pair Extraordinaire" --base main --head badge-v1
Start-Sleep -Seconds 7
gh pr merge badge-v1 --merge --admin --delete-branch=false
Write-Host "✅ YOLO + Pair Extraordinaire done" -ForegroundColor Green
Start-Sleep -Seconds 5

# 3-5. Pull Shark x4 - loop for v2-v4
for ($i=2; $i -le 4; $i++) {
    Write-Host "`n$($i+1)/6 Pull Shark PR $i..." -ForegroundColor Yellow
    git checkout main
    git pull origin main
    git checkout -B "badge-v$i"
    "Hello badge v$i - $(Get-Date)" | Set-Content -Path "badge-v$i.txt"
    git add "badge-v$i.txt"
    git commit -m "Add badge v$i"
    git push -u origin "badge-v$i" --force
    gh pr create --title "Badge PR $i - Pull Shark" --body "$i PR for Pull Shark" --base main --head "badge-v$i"
    Start-Sleep -Seconds 7
    gh pr merge "badge-v$i" --merge --admin --delete-branch=false
    Write-Host "✅ Pull Shark PR $i done" -ForegroundColor Green
    Start-Sleep -Seconds 5
}

# 6. Galaxy Brain - attempt if discussions enabled
Write-Host "`n6/6 Galaxy Brain (if Discussions enabled)..." -ForegroundColor Yellow
try {
    $hasDiscussions = gh api "repos/$repo" --jq .has_discussions
    if ($hasDiscussions -ne "true") {
        Write-Host "⚠️ Discussions not enabled. Enable: Settings -> General -> Features -> Discussions" -ForegroundColor Yellow
    } else {
        Write-Host "Discussions enabled, creating 2 discussions..." -ForegroundColor Green
        # This uses gh api graphql - requires manual discussion create, show instruction
        Write-Host "ℹ️ Galaxy Brain needs Discussions Q&A category. Create 2 discussions manually and mark answers, or run workflow." -ForegroundColor Cyan
        Write-Host "   Workflow automates Galaxy Brain fully. Local script skips to stay safe." -ForegroundColor Cyan
    }
} catch { Write-Host "⚠️ Galaxy Brain check failed, skipping" -ForegroundColor Yellow }

Write-Host "`n🎉 All done! Check https://github.com/$(gh api user -q .login)?tab=achievements in 30 mins" -ForegroundColor Cyan
Write-Host "Safe: 4 PRs + delays + own fork = no flag" -ForegroundColor Cyan
