# 1-Click Badge Script for Windows (PowerShell)
# Usage: Clone your fork, then run: .\scripts\earn-badges.ps1
# Requires: git and gh CLI (https://cli.github.com) + gh auth login

$ErrorActionPreference = "Stop"

Write-Host "🎯 Earning GitHub Badges - Quickdraw, YOLO, Pair Extraordinaire, Pull Shark" -ForegroundColor Cyan

# Check tools
try { git --version | Out-Null } catch { Write-Host "❌ git not found. Install git first." -ForegroundColor Red; exit 1 }
try { gh --version | Out-Null } catch { Write-Host "❌ gh CLI not found. Install from https://cli.github.com" -ForegroundColor Red; exit 1 }

$auth = gh auth status 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Not logged in. Run: gh auth login" -ForegroundColor Red
    exit 1
}

$repo = gh repo view --json nameWithOwner -q .nameWithOwner
if (-not $repo) {
    Write-Host "❌ Not in a git repo. Run this inside your cloned fork." -ForegroundColor Red
    exit 1
}
Write-Host "📦 Repo: $repo" -ForegroundColor Green

# 1. Quickdraw
Write-Host "`n1/3 Quickdraw - Creating & closing issue..." -ForegroundColor Yellow
$issueUrl = gh issue create --title "Quickdraw badge" --body "Closing for Quickdraw"
$issueNumber = ($issueUrl -split "/")[-1]
Start-Sleep -Seconds 2
gh issue close $issueNumber --reason "completed"
Write-Host "✅ Quickdraw done - issue #$issueNumber closed" -ForegroundColor Green

# 2. YOLO + Pair Extraordinaire
Write-Host "`n2/3 YOLO + Pair Extraordinaire..." -ForegroundColor Yellow
git checkout -B badge-v1
"Hello badge v1 - $(Get-Date)" | Set-Content -Path "badge-v1.txt"
git add badge-v1.txt
git commit -m "Add badge v1

Co-authored-by: Contrib <contrib@users.noreply.github.com>"
git push -u origin badge-v1 --force
gh pr create --title "Badge PR 1 - YOLO & Pair Extraordinaire" --body "YOLO + Pair Extraordinaire" --base main --head badge-v1
Start-Sleep -Seconds 5
gh pr merge badge-v1 --merge --admin --delete-branch=false
Write-Host "✅ YOLO + Pair Extraordinaire done" -ForegroundColor Green

# 3. Pull Shark
Write-Host "`n3/3 Pull Shark..." -ForegroundColor Yellow
git checkout main
git pull origin main
git checkout -B badge-v2
"Hello badge v2 - $(Get-Date)" | Set-Content -Path "badge-v2.txt"
git add badge-v2.txt
git commit -m "Add badge v2"
git push -u origin badge-v2 --force
gh pr create --title "Badge PR 2 - Pull Shark" --body "2nd PR for Pull Shark" --base main --head badge-v2
Start-Sleep -Seconds 5
gh pr merge badge-v2 --merge --admin --delete-branch=false
Write-Host "✅ Pull Shark done" -ForegroundColor Green

Write-Host "`n🎉 All done! Check https://github.com/$(gh api user -q .login)?tab=achievements in 30 mins" -ForegroundColor Cyan
