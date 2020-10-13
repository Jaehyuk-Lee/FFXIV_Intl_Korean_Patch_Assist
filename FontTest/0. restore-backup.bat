@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn

rem 관리자 권한으로 실행 확인
NET SESSION >nul 2>&1
IF NOT %ERRORLEVEL% EQU 0 (
    echo 관리자 권한이 필요합니다.
    echo 관리자 권한으로 다시 실행해주세요.
    pause
    exit
) ELSE (
    echo - 관리자 권한으로 실행했습니다. 
)

rem 작업 시작 전에 GLOBAL_PATH가 존재하는지 확인
if not exist "%GLOBAL_PATH%" (
    echo 글로벌 서버 경로가 존재하지 않습니다.
    echo 기본 경로를 사용하고 계시지 않다면,
    echo 이 bat 파일을 열어서 올바른 GLOBAL_PATH로 수정해주세요.
    pause
    exit
) else (
    echo - 글로벌 서버 경로가 존재합니다.
)

rem 작업 시작 전에 글로벌 서버 백업 파일이 있는지 확인
if not exist "%~dp0\backup\000000.win32.index" (
    echo - 백업 폴더에 000000.win32.index 백업 파일이 존재하지 않습니다.
    echo 복구 작업을 중지합니다.
    pause
    exit
)
if not exist "%~dp0\backup\000000.win32.dat0" (
    echo - 백업 폴더에 000000.win32.dat0 백업 파일이 존재하지 않습니다.
    echo 복구 작업을 중지합니다.
    pause
    exit
)

rem 백업 생성일 체크
FOR /f "delims=" %%a IN (
    'dir /b /a-d "%~dp0\backup\000000.win32.*" '
    ) DO (
    CALL :creationdate "%~dp0\backup\%%a" w modifytime
    ECHO - 글로벌 서버 백업 파일이 존재합니다. [%%a] 백업 날짜: !modifytime:~0,10!
)

echo 백업해 놓은 글로벌 서버 파일을 이용해 글로벌 서버 한글 폰트 패치 이전으로 되돌립니다.
pause

copy "%~dp0\backup\000000.win32.dat0" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
copy "%~dp0\backup\000000.win32.index" "%GLOBAL_PATH%\game\sqpack\ffxiv\"

goto:eof
:creationDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
    'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof
