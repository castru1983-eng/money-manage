# ==============================================================================
# Auto Backup Script for Money Management System
# ==============================================================================

$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir
$backupDir = Join-Path $projectRoot "backups"

if (-not (Test-Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
}

$supabaseUrl = "https://vdrtmtqdhmeroakwwsiv.supabase.co"
$supabaseKey = "sb_publishable_F-LXdSZKmj58_32w2vESFQ_Fjt0CHgD"

$headers = @{
    apikey        = $supabaseKey
    Authorization = "Bearer $supabaseKey"
}

$dateStr = Get-Date -Format "yyyy-MM-dd"
$backupFile = Join-Path $backupDir "backup_$dateStr.json"
$latestFile = Join-Path $backupDir "backup_latest.json"

Write-Host "Connecting to Supabase and fetching backup data..." -ForegroundColor Cyan

try {
    $uri = "$supabaseUrl/rest/v1/rooms?select=*"
    $response = Invoke-RestMethod -Uri $uri -Method Get -Headers $headers

    $backupPayload = [PSCustomObject]@{
        backupDate = (Get-Date).ToString("yyyy-MM-dd HH:mm:ss")
        totalRooms = $response.Count
        rooms      = $response
    }

    $jsonContent = $backupPayload | ConvertTo-Json -Depth 20

    [System.IO.File]::WriteAllText($backupFile, $jsonContent, [System.Text.Encoding]::UTF8)
    [System.IO.File]::WriteAllText($latestFile, $jsonContent, [System.Text.Encoding]::UTF8)

    Write-Host "Backup completed successfully!" -ForegroundColor Green
    Write-Host "Saved to: $backupFile" -ForegroundColor Yellow
    Write-Host "Saved to: $latestFile" -ForegroundColor Yellow
} catch {
    Write-Host "Backup failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
