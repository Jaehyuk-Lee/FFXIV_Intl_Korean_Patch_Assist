@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn

NET SESSION >nul 2>&1
IF NOT %ERRORLEVEL% EQU 0 (
    echo ������ ������ �ʿ��մϴ�.
    echo ������ �������� �ٽ� �������ּ���.
    pause
    exit
) ELSE (
    echo - ������ �������� �����߽��ϴ�. 
)

rem �۾� ���� ���� GLOBAL_PATH�� �����ϴ��� Ȯ��
if not exist "%GLOBAL_PATH%" (
    echo �۷ι� ���� ��ΰ� �������� �ʽ��ϴ�.
    echo �⺻ ��θ� ����ϰ� ����� �ʴٸ�,
    echo �� bat ������ ��� �ùٸ� GLOBAL_PATH�� �������ּ���.
    pause
    exit
) else (
    echo - �۷ι� ���� ��ΰ� �����մϴ�.
)

rem �۾� ���� ���� �۷ι� ���� ��� ������ �ִ��� Ȯ��
if not exist "%~dp0\backup\0a0000.win32.index" (
    echo - ��� ������ 0a0000.win32.index ��� ������ �������� �ʽ��ϴ�.
    echo ���� �۾��� �����մϴ�.
    pause
    exit
)
if not exist "%~dp0\backup\0a0000.win32.dat0" (
    echo - ��� ������ 0a0000.win32.dat0 ��� ������ �������� �ʽ��ϴ�.
    echo ���� �۾��� �����մϴ�.
    pause
    exit
)

rem ��� ������ üũ
FOR /f "delims=" %%a IN (
    'dir /b /a-d "%~dp0\backup\0a0000.win32.*" '
    ) DO (
    CALL :creationdate "%~dp0\backup\%%a" c crdatetime
    ECHO - �۷ι� ���� ��� ������ �����մϴ�. [%%a] ��� ��¥: !crdatetime:~0,10!
)

echo ����� ���� �۷ι� ���� ������ �̿��� �۷ι� ���� �ѱ��� ��ġ�� ����մϴ�.
pause

copy "%~dp0\backup\0a0000.win32.dat0" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
copy "%~dp0\backup\0a0000.win32.index" "%GLOBAL_PATH%\game\sqpack\ffxiv\"

goto:eof
:creationDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
    'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof
