cd $PSScriptRoot

Write-Host "Monitoramento em tempo real iniciado..."

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $PSScriptRoot
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher "Changed" -Action {

    cd $PSScriptRoot

    git add .

    if (git diff --cached --quiet) {
        return
    }

    git commit -m "Auto commit - alteracao detectada"
    git push

    Write-Host "Backup salvo automaticamente!"
}

while ($true) {
    Start-Sleep 1
}