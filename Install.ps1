#Requires -RunAsAdministrator

# Make sure PowerShell Core and Windows Terminal are pre-installed
(Get-Command wt) -and (Get-Command pwsh)
Write-Host "Prerequisites satisfied, starting..." -BackgroundColor Green

# Create and save needed folders
$Desktop = [Environment]::GetFolderPath("Desktop")
$WTFolder = Get-Item (Join-Path "$HOME" "AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe")
$KitFolder = New-Item -Path (Join-Path $Desktop "Kit") -ItemType Directory
$SourceFolder = New-Item -Path (Join-Path $HOME "Source") -ItemType Directory
$StartupFolder = [Environment]::GetFolderPath("Startup")
$SshFolder = New-Item -Path (Join-Path $HOME ".ssh") -ItemType Directory

# Configure SSH key
Copy-Item -Path (Join-Path ([Environment]::GetEnvironmentVariable("OneDrive")) "Personal/Credentials/id_rsa") -Destination $SshFolder -Force

# Install scoop
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# Git setup
scoop install git
git config --global user.name "Kiyo5hi"
git config --global user.email "kiyo5hi@riseup.net"

# Add scoop buckets
scoop bucket add extras
scoop bucket add java

# Install scoop packages
scoop install geekuninstaller
scoop install tinynvidiaupdatechecker

# Get dotfiles (Path: User/workspace/dotfiles)
git clone "git@github.com:Kiyo5hi/dotfiles.git" "$SourceFolder/dotfiles"

# Install AutoHotKey
$AhkZipPath = Join-Path $KitFolder "ahk.zip"
Invoke-WebRequest -Uri "https://www.autohotkey.com/download/ahk-v2.zip" -UseBasicParsing -OutFile $AhkZipPath
7z.exe x -o"$(Join-Path $KitFolder "AutoHotkey")" $AhkZipPath
Remove-Item -Path $AhkZipPath

# Create Ahk startup symboliclink (Path: User/workspace/dotfiles)
New-Item -Path (Join-Path $StartupFolder "Kiyoshi.ahk") -ItemType SymbolicLink -Target (Join-Path $SourceFolder "dotfiles/Kiyoshi.ahk")

# Create Windows Terminal settings.json symboliclink
$WTSettingsFile = Join-Path $WTFolder "LocalState/settings.json"
if (Test-Path -Path $WTSettingsFile) {
    Remove-Item -Path $WTSettingsFile
}
New-Item -Path $WTSettingsFile -ItemType SymbolicLink -Target (Join-Path $SourceFolder "dotfiles" "settings.json")

Write-Host "System initialized successfully!" -BackgroundColor Green
# Write-Host "Now installing other needed large packages..."
# scoop install nodejs-lts
# scoop install oraclejdk
