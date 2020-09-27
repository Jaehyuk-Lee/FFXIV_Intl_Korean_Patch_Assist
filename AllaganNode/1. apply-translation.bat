@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn
set KOREA_PATH=C:\Program Files (x86)\FINAL FANTASY XIV - KOREA

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

rem �۾� ���� ���� translations ������ �ִ��� Ȯ��
if not exist "%~dp0\input\translations" (
    echo input ���� �ȿ� translations ������ �������� �ʽ��ϴ�.
    echo �۾��� �����ϱ� ���� �ش� ������ input ���� �ȿ� �־��ֽʽÿ�.
    echo �ش� ������ ���� ���� ���Դϴ�. ���ٸ� ����� ��η� ���Ͻʽÿ�.
    pause
    exit
) else (
    echo - translations ������ �����մϴ�.
)

rem �۾� ���� ���� AllaganNode ������ �ִ��� Ȯ��
if not exist "%~dp0\AllaganNode.exe" (
    echo AllaganNode ���α׷��� ã�� ���߽��ϴ�.
    echo AllaganNode ���α׷��� �ִ� ������ �� ������ �־��ּ���.
    pause
    exit
) else (
    echo - AllaganNode ���α׷��� ã�ҽ��ϴ�.
)

rem �۾� ���� ���� �۷ι� ���� ��� ������ �ִ��� Ȯ��
if not exist "%~dp0\backup\0a0000.win32.index" (
    echo �۷ι� ���� ��� ����[0a0000.win32.index]�� �������� �ʽ��ϴ�.
    echo �۾��� �����ϱ� ���� make-backup.bat�� �������ּ���.
    pause
    exit
)
if not exist "%~dp0\backup\0a0000.win32.dat0" (
    echo �۷ι� ���� ��� ����[0a0000.win32.dat0]�� �������� �ʽ��ϴ�.
    echo �۾��� �����ϱ� ���� make-backup.bat�� �������ּ���.
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

echo.
echo * �۷ι� ���� ������Ʈ�� �ѱ��� ��ġ�� Ǯ�� ���� make-backup.bat�� ������ �� ���ٸ�, �ݵ�� ���� �������ּ���.
echo * ���߿� �Ǽ��� �ϼ̴ٸ� �� ������ �ݰ� �ٽ� �����ϼ���.
pause

rem input ������ ������ ����
if not exist "%~dp0\input\" (
    mkdir "%~dp0\input"
)

echo.
copy "%KOREA_PATH%\game\sqpack\ffxiv\0a0000.win32.index" "%~dp0\input\"
copy "%KOREA_PATH%\game\sqpack\ffxiv\0a0000.win32.dat0" "%~dp0\input\"
echo �ѱ� ���� 0a0000.win32.index, 0a0000.win32.dat0 ���� ���� �Ϸ�
echo.
echo AllaganNode ���� ��...
echo �ε��� �Ϸ�Ǹ� "0"�� �Է��Ͻʽÿ�.
"%~dp0\AllaganNode"

copy "%GLOBAL_PATH%\game\sqpack\ffxiv\0a0000.win32.index" "%~dp0\input\"
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\0a0000.win32.dat0" "%~dp0\input\"
echo �۷ι� ���� 0a0000.win32.index, 0a0000.win32.dat0 ���� ���� �Ϸ�
echo.
echo AllaganNode ���� ��...
echo �ε��� �Ϸ�Ǹ� "0"�� �Է��Ͻʽÿ�.
"%~dp0\AllaganNode"
echo.

echo.
echo AllaganNode ���� ��...
echo �ε��� �Ϸ�Ǹ� "swap"�� �Է��ϰ� "ko"�� �Է��� ����,
echo �ַ� ����ϴ� Ŭ���̾�Ʈ �� �Է��ϼ���. (��: ja, en, de, fr... �� �� ���� �Է�)
"%~dp0\AllaganNode"
echo.

echo.
echo AllaganNode ���� ��...
echo �ε��� �Ϸ�Ǹ� "1"�� �Է��ϰ� �Ʊ� �Է��� �۷ι� ���� �� �Է��ϼ���.
"%~dp0\AllaganNode"
echo.

echo.
echo AllaganNode ���� ��...
echo �ε��� �Ϸ�Ǹ� "2"�� �Է��ϰ� �Ʊ� �Է��� �۷ι� ���� �� �Է��ϼ���.
"%~dp0\AllaganNode"
echo.

echo.
echo �۷ι� ���� ���Ͽ� �ѱ��� ��ġ�� �����մϴ�.
echo ������ �����ðڽ��ϱ�?
echo * ���� �� ������ ����ٸ� restore-backup.bat�� �����ؼ� ����� ������ �����ϼ���.
pause
copy "%~dp0\output\0a0000.win32.dat1" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
copy "%~dp0\output\0a0000.win32.index" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
echo.
echo �۷ι� ������ �ѱ��� ��ġ ������ �Ϸ��߽��ϴ�.
pause

goto:eof
:creationDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
    'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof
