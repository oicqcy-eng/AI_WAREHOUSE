@echo off
chcp 65001 >nul
title MES Worklog Server
cd /d %~dp0
echo ============================================
echo   MES Worklog Input Service
echo   Browser will open automatically...
echo   Close this window to stop the service.
echo ============================================
node agent\mes-report-agent\tools\worklog-server.js
pause
