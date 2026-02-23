@echo off

SET MEU_NOME=Thigo-Soulz
SET MEU_EMAIL=thiago.vilhena46@gmail.com

FOR /F "delims=" %%i IN ('git config user.email') DO SET EMAIL_ATUAL=%%i

IF "%EMAIL_ATUAL%"=="%MEU_EMAIL%" (
    echo Conta correta ja configurada.
) ELSE (
    echo Ajustando para sua conta...
    git config user.name "%MEU_NOME%"
    git config user.email "%MEU_EMAIL%"
)

git add .
git commit -m "Commit automatico garantindo conta"
git push

echo Processo finalizado.
pause