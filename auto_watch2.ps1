cd $PSScriptRoot

# ===============================
# CONFIGURAÇÃO GIT (EDITAR)
# ===============================
$GitUser = "Thigo-Soulz"
$GitEmail = "thiago.vilhena46@gmail.com"

# Verificar configuração global Git
$Name = git config --global user.name
$Email = git config --global user.email

if ($Name -ne $GitUser -or $Email -ne $GitEmail) {
    Write-Host "Configurando Git..."

    git config --global user.name $GitUser
    git config --global user.email $GitEmail

    Write-Host "Git configurado!"
}
else {
    Write-Host "Conta Git já configurada."
}

Write-Host "Monitoramento em tempo real iniciado..."

$projectPath = $PSScriptRoot

# Criar FileWatcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $projectPath
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Ação de auto commit
$action = {
    try {
        Set-Location $using:projectPath

        git add .

        # Verificar mudanças
        if (git diff --cached --quiet) {
            return
        }

        git commit -m "Auto commit - alteracao detectada"
        git push

        Write-Host "Backup salvo automaticamente!"
    }
    catch {
        Write-Host "Erro no auto commit"
    }
}

# Eventos monitorados
Register-ObjectEvent $watcher Changed -Action $action
Register-ObjectEvent $watcher Created -Action $action
Register-ObjectEvent $watcher Deleted -Action $action
Register-ObjectEvent $watcher Renamed -Action $action

# Manter script rodando
while ($true) {
    Start-Sleep 1
}