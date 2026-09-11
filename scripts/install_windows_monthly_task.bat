@echo off
chcp 65001 >nul
echo ========================================================
echo   共用金與收據系統 - 安裝本機每月1號自動備份排程
echo ========================================================
echo.
set SCRIPT_DIR=%~dp0
set PS_SCRIPT=%SCRIPT_DIR%backup.ps1

echo 正在註冊 Windows 工作排程 (每月 1 號 09:00 自動備份)...
schtasks /Create /SC MONTHLY /D 1 /TN "MoneyManage_Monthly_Backup" /TR "powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File \"%PS_SCRIPT%\"" /ST 09:00 /F

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ 成功註冊 Windows 工作排程！
    echo 系統將在每個月 1 號早上 09:00 自動執行備份，
    echo 備份檔案將自動存入本機的 backups 資料夾。
) else (
    echo.
    echo ⚠️ 註冊排程需要系統管理員權限，請右鍵選擇「以系統管理員身分執行」此檔案。
)

echo.
pause
