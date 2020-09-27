@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set KOREA_PATH=C:\Program Files (x86)\FINAL FANTASY XIV - KOREA
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn

echo ���� �䱸 ���� Ȯ�� ��...

rem ������ �������� ���� Ȯ��
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

rem �۾� ���� ���� KOREA_PATH�� �����ϴ��� Ȯ��
if not exist "%KOREA_PATH%" (
    echo �ѱ� ���� ��ΰ� �������� �ʽ��ϴ�.
    echo �⺻ ��θ� ����ϰ� ����� �ʴٸ�,
    echo �� bat ������ ��� �ùٸ� KOREA_PATH�� �������ּ���.
    pause
    exit
) else (
    echo - �ѱ� ���� ��ΰ� �����մϴ�.
)

rem �۾� ���� ���� FontTest ������ �ִ��� Ȯ��
if not exist "%~dp0\FontTest.exe" (
    echo FontTest ���α׷��� ã�� ���߽��ϴ�.
    echo FontTest ���α׷��� �ִ� ������ �� ������ �־��ּ���.
    pause
    exit
) else (
    echo - FontTest ���α׷��� ã�ҽ��ϴ�.
)

rem �۾� ���� ���� �۷ι� ���� ��� ������ �ִ��� Ȯ��
if not exist "%~dp0\backup\000000.win32.index" (
    echo �۷ι� ���� ��� ����[000000.win32.index]�� �������� �ʽ��ϴ�.
    echo �۾��� �����ϱ� ���� make-backup.bat�� �������ּ���.
    pause
    exit
)
if not exist "%~dp0\backup\000000.win32.dat0" (
    echo �۷ι� ���� ��� ����[000000.win32.dat0]�� �������� �ʽ��ϴ�.
    echo �۾��� �����ϱ� ���� make-backup.bat�� �������ּ���.
    pause
    exit
)

rem ��� ������ üũ
FOR /f "delims=" %%a IN (
    'dir /b /a-d "%~dp0\backup\000000.win32.*" '
    ) DO (
    CALL :creationdate "%~dp0\backup\%%a" c crdatetime
    ECHO - �۷ι� ���� ��� ������ �����մϴ�. [%%a] ��� ��¥: !crdatetime:~0,10!
)

echo.
echo * �۷ι� ���� ������Ʈ�� �ѱ� ��Ʈ ��ġ�� Ǯ�� ���� make-backup.bat�� ������ �� ���ٸ�, �� ������ ���� �������ּ���.
pause

rem ������ ������ ����
if not exist "%~dp0\global\" (
    mkdir "%~dp0\global"
)
if not exist "%~dp0\korean\" (
    mkdir "%~dp0\korean"
)
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\000000.win32.index" "%~dp0\global\"
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\000000.win32.dat0" "%~dp0\global\"
copy "%KOREA_PATH%\game\sqpack\ffxiv\000000.win32.index" "%~dp0\korean\"
copy "%KOREA_PATH%\game\sqpack\ffxiv\000000.win32.dat0" "%~dp0\korean\"
echo �۷ι� ���� �����, �ѱ� ���� ���� ���� �Ϸ�
echo.
echo �ѱ� ��Ʈ ��ġ ������ �����մϴ�...
"%~dp0\FontTest"
echo ���� �Ϸ�!

echo.
echo �۷ι� ���� ���Ͽ� �ѱ� ��Ʈ ��ġ�� �����մϴ�.
echo ������ �����ðڽ��ϱ�?
pause
copy "%~dp0\output\000000.win32.index" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
copy "%~dp0\output\000000.win32.dat1" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
echo.
echo �۷ι� ������ �ѱ� ��Ʈ ��ġ ������ �Ϸ��߽��ϴ�.
pause

goto:eof
:creationDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
    'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof
