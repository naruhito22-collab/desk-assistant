# Run after installing the Desk Assistant PWA in Microsoft Edge.
# This script creates a Windows Startup shortcut that opens the installed site in an app-style window.
$Url = Read-Host 'Enter the published GitHub Pages URL (https://...)'
if ($Url -notmatch '^https://') { throw 'HTTPS URL required' }
$edge = Join-Path ${env:ProgramFiles(x86)} 'Microsoft\Edge\Application\msedge.exe'
if (!(Test-Path $edge)) { $edge = Join-Path $env:ProgramFiles 'Microsoft\Edge\Application\msedge.exe' }
if (!(Test-Path $edge)) { throw 'Microsoft Edge not found' }
$startup = [Environment]::GetFolderPath('Startup')
$shortcut = (New-Object -ComObject WScript.Shell).CreateShortcut((Join-Path $startup 'Desk Assistant.lnk'))
$shortcut.TargetPath = $edge
$shortcut.Arguments = '--app="' + $Url + '"'
$shortcut.WorkingDirectory = Split-Path $edge
$shortcut.Description = 'Start Desk Assistant at Windows sign-in'
$shortcut.Save()
Write-Host 'Startup shortcut created:' $shortcut.FullName
