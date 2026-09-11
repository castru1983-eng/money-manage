@echo off
chcp 65001 >nul
echo 正在移除 Windows 工作排程...
schtasks /Delete /TN "MoneyManage_Monthly_Backup" /F
if %ERRORLEVEL% EQU 0 (
    echo ✅ 已成功移除自動備份排程。
) else (
    echo ⚠️ 找不到該排程或需要系統管理員權限。
)
pause
