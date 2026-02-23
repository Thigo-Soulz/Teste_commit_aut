cd $PSScriptRoot

Write-Host "Monitoramento em tempo real iniciado..."

# ===============================
# CONFIGURAÇÃO GIT
# ===============================

$GitUser = "Thigo-Soulz"
$GitEmail = "thiago.vilhena46@gmail.com"

git config --global user.name $GitUser
git config --global user.email $GitEmail

$projectPath = $PSScriptRoot

# ===============================
# FUNÇÃO AUTO COMMIT
# ===============================

function AutoCommit {

    try {

        Set-Location $projectPath

        git add .

        # Evita commit vazio
        if (git diff --cached --quiet) {
            return
        }

        git commit -m "Auto commit - alteracao detectada"
        git push

        Write-Host "Backup salvo automaticamente!"

    }
    catch {
        Write-Host $_.Exception.Message
    }
}

# ===============================
# FILE WATCHER
# ===============================

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $projectPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

Register-ObjectEvent $watcher Changed -Action { AutoCommit }
Register-ObjectEvent $watcher Created -Action { AutoCommit }
Register-ObjectEvent $watcher Deleted -Action { AutoCommit }
Register-ObjectEvent $watcher Renamed -Action { AutoCommit }

# Manter script rodando
while ($true) {
    Start-Sleep 1
}