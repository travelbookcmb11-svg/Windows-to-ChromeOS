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

# Center taskbar icons on supported Windows versions
Set-ItemProperty
  -Path $ExplorerAdvanced
  -Name "TaskbarAl"
  -Type Dword
  -Value 0

# Disable taskbar search box where supported
Set-ItemProperty
  -Path $ExplorerAdvanced
  -Name "TaskbarDa"
  -Type Dword
  -Value 0

  Write-Host "Taskbar configured."
  Write-Host ""

  # Enable dark/light Windows app preference
  Write-Host " [3/5] Configuring appearance..."

  $Personalize = "HKCU:
  \Software\Microsoft\Windows\CurrentVersion\Themes\Personalize"

  if (!(Test-Path $Personalize)) {
     New-Item -Path $Personalize -Force | Out-Null
     }

# Light appearance
Set-ItemProperty
  -Path $Personalize
  -Name "AppsUseLightTheme"
  -Type DWord
  -Value 1

  Set-ItemProperty
  -Path $Personalize
  -Name "SystemUsesLightTheme"
  -Type DWord
  -Value 1

Write-Host "Appearance Configured."
Write-Host ""

#Restart Explorer
Write-Host "[4/5] Restarting Windows Explorer..."

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
Start-Process explorer.exe

Write-Host "Explorer restarted."
Write-Host ""

#Finished
Write-Host "[5/5] Installation complete!"
Write-Host ""
Write-Host "Windows-to-Chromeos Version 1.0.0 has been installed."
Write-Host ""
Write-Host "Backup location:"
Write-Host "$BackupPath
Write-Host ""
Write-Host "======================================================================"
Write-Host "          Windows-to-chromeos"
Write-Host "======================================================================"

Read-Host "Press Enter to Exit"
