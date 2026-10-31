@echo off
REM Official Ward 11 Ghodsuwa Server Launcher
echo Starting Nepal Government Official Portal — Ward 11 Ghodsuwa...
cd /d "C:\Users\aadar\Documents\ward-website"
echo.
echo Normal Panel: http://localhost:3000/
echo Admin Panel:  http://localhost:3000/admin
echo Hidden Super Admin: http://localhost:3000/assets/maintenance-console (use x-data-sync: audit_complete header)
echo.
node server.js
pause
