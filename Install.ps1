#Requires -RunAsAdministrator

# Make sure PowerShell Core and Windows Terminal are pre-installed
(Get-Command wt) -and (Get-Command pwsh)
Write-Host "Prerequisites satisfied, starting..." -BackgroundColor Green

# Create and save needed folders
$Desktop = [Environment]::GetFolderPath("Desktop")
$WTFolder = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"
$KitFolder = New-Item -Path (Join-Path $Desktop "Kit") -ItemType Directory
$SourceFolder = New-Item -Path (Join-Path $HOME "Source") -ItemType Directory
$StartupFolder = $([Environment]::GetFolderPath("Startup"))

# Install scoop
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# Git setup
scoop install git
git config --global user.name "Kiyo5hi"
git config --global user.email "i@k1yoshi.com"

# Add scoop buckets
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts

# Install scoop packages
scoop install oraclejdk
scoop install nodejs-lts
scoop install FiraCode

# Get dotfiles (Path: User/workspace/dotfiles)
git clone "git@github.com:Kiyo5hi/dotfiles.git" "$SourceFolder/dotfiles"

# Install AutoHotKey
$AhkVersion = (Invoke-WebRequest -Uri "https://www.autohotkey.com/download/2.0/version.txt").Content
$AhkZipPath = Join-Path $KitFolder "ahk.zip"
Invoke-WebRequest -Uri "https://www.autohotkey.com/download/2.0/AutoHotkey_$AhkVersion.zip" -UseBasicParsing -OutFile $AhkZipPath
7z.exe x -o"$(Join-Path $KitFolder "AutoHotkey")" $AhkZipPath
Remove-Item -Path $AhkZipPath

# Create Ahk startup symboliclink (Path: User/workspace/dotfiles)
New-Item -Path (Join-Path $StartupFolder "Kiyoshi.ahk") -ItemType SymbolicLink -Target (Join-Path $SourceFolder "dotfiles" "Kiyoshi.ahk")

# Create Windows Terminal settings.json symboliclink
$WTSettingsFile = "$WTFolder/LocalState/settings.json"
if (Test-Path -Path $WTSettingsPath) {
    Remove-Item -Path $WTSettingsPath
}
New-Item -Path $WTSettingsFile -ItemType SymbolicLink -Target (Join-Path $SourceFolder "dotfiles" "settings.json")
