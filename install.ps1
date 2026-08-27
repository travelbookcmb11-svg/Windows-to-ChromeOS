#windows-to-chromeos
#chromeos windows customization
#program version  1.0.0

$ErrorActionPreference = "Stop"

Write-Host "================================================"
Write-Host                   CustomOS"
Write-Host "================================================"
Write-Host ""

#Check Windows
if ($env:OS -ne "Windows_NT") {
  Write-Host "this only works on WindowsOS"
  exit 1
  }

  #Create backup directory
  $BackupPath = Join-Path $env:USERPROFILE "windows-to-chromeos"

  if (!(Test-Path $BackupPath)) {
    New-Item -ItemType Directory -Path $BackupPath | Out-Null
    )

Write-Host "[1/5] Creating backup..."

# Backup Explorer Settings
 
reg export "HKCU\Software\Microsoft\CurrentVersion\Explorer"
 "$BackupPath\Explorer.reg" /y | Out-Null

# Backup Personalization settings
reg export "HKCU\Software\Microsoft\CurrentVersion\Themes"
 "$BackupPath\Themes.reg" /y | Out-Null

Write-Host "Backup created at:"
Write-Host $BackupPath
Write-Host ""

# ChromeOS-style taskbar alignment
Write-Host "[2/5] Configuring taskbar..."

$ExplorerAdvanced = "HKCU:
\Software\Microsoft\CurrentVersion\Explorer\Advanced"

if (!(Test-Path $ExplorerAdvanced)) {
   New-item -path $ExplorerAdvanced -force | Out-null
)

#
