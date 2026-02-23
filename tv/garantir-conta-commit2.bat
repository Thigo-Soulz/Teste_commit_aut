@echo off

cd /d %~dp0

git config --global user.name "Thigo-Soulz"
git config --global user.email "thiago.vilhena46@gmail.com"

:LOOP

git add .

git diff --cached --quiet
IF %ERRORLEVEL% NEQ 0 (
    git commit -m "Auto commit a cada 5 minutos"
    git push
)

echo Backup verificado...

timeout /t 300 > nul

goto LOOP