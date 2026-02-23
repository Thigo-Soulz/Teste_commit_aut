@echo off
cd /d "%~dp0"
powershell -ExecutionPolicy Bypass -File auto_watch2.ps1
pause