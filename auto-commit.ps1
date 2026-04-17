# Auto-commit script for Kussco Housing project
# This script automatically commits any changes to the repository

$repoPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $repoPath

Write-Host "Auto-commit script started at $(Get-Date)" -ForegroundColor Green
Write-Host "Repository: $repoPath" -ForegroundColor Cyan

# Get the current branch
$branch = git rev-parse --abbrev-ref HEAD

# Check for uncommitted changes
$status = git status --porcelain
if ($status) {
    Write-Host "Found uncommitted changes. Committing..." -ForegroundColor Yellow
    
    # Add all changes
    git add .
    
    # Create a commit with timestamp
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $commitMessage = "Auto-commit: $timestamp"
    
    git commit -m $commitMessage
    
    Write-Host "Commit created: $commitMessage" -ForegroundColor Green
    
    # Push to remote
    Write-Host "Pushing to remote..." -ForegroundColor Yellow
    git push origin $branch
    
    Write-Host "Successfully pushed to remote!" -ForegroundColor Green
} else {
    Write-Host "No changes to commit." -ForegroundColor Cyan
}

Write-Host "Auto-commit script completed at $(Get-Date)" -ForegroundColor Green
