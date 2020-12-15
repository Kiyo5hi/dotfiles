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

# Get dotfiles
Set-Location -Path $WorkspaceFolder
git clone "git@github.com:Kiyo5hi/dotfiles.git"
