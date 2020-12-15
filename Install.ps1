# Make sure PowerShell Core and Windows Terminal are pre-installed
$PwshPath = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\PowerShell"
$WTPath = "C:\Users\i\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe"
$PrereqSatisfied = (Test-Path -Path $PwshPath) -and (Test-Path -Path $WTPath)

if ( $PrereqSatisfied) {
    throw "You have to pre-install PowerShell Core and Windows Terminal before running this script!"
}

Write-Host "Prerequisites satisfied, starting..." -BackgroundColor Green

# Get admin privilege
Start-Process -FilePath "pwsh.exe" -Verb runAs

# Install scoop
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
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

# Create "User/workspace" Folder
Set-Location -Path ([Environment]::GetFolderPath("User"))
$WorkspaceFolder = New-Item -Path "workspace" -ItemType Directory

# Create "Desktop/Kit" folder
Set-Location -Path ([Environment]::GetFolderPath("Desktop"))
$KitFolder = New-Item -Path "Kit" -ItemType Directory
Set-Location $KitFolder

# Install AutoHotKey (Path: Desktop/Kit)
$AhkVersion = (Invoke-WebRequest -Uri "https://www.autohotkey.com/download/2.0/version.txt").Content
Invoke-WebRequest -Uri "https://www.autohotkey.com/download/2.0/AutoHotkey_$AhkVersion.zip" -UseBasicParsing -OutFile ahk.zip
7z.exe x -oAutoHotkey "ahk.zip"
Remove-Item "ahk.zip"

# Get dotfiles (Path: User/workspace/dotfiles)
Set-Location -Path $WorkspaceFolder
git clone "git@github.com:Kiyo5hi/dotfiles.git"
Set-Location -Path "dotfiles"

# Create Ahk startup symboliclink (Path: User/workspace/dotfiles)
New-Item -Path "$([Environment]::GetFolderPath("Startup"))/Kiyoshi.ahk" -ItemType SymbolicLink -Target "$($WorkspaceFolder)dotfiles/Kiyoshi.ahk"

# Create Windows Terminal settings.json symboliclink
$WTSettingsPath = "$WTPath/LocalState/settings.json"
$TestResult = Test-Path -Path $WTSettingsPath
if ($TestResult) {
    Remove-Item -Path $WTSettingsPath
}
New-Item -Path "$WTPath/LocalState/settings.json" -ItemType SymbolicLink -Target "$($WorkspaceFolder)dotfiles/settings.json"
