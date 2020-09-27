@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set KOREA_PATH=C:\Program Files (x86)\FINAL FANTASY XIV - KOREA
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn

echo 실행 요구 조건 확인 중...

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

rem 작업 시작 전에 KOREA_PATH가 존재하는지 확인
if not exist "%KOREA_PATH%" (
    echo 한국 서버 경로가 존재하지 않습니다.
    echo 기본 경로를 사용하고 계시지 않다면,
    echo 이 bat 파일을 열어서 올바른 KOREA_PATH로 수정해주세요.
    pause
    exit
) else (
    echo - 한국 서버 경로가 존재합니다.
)

rem 작업 시작 전에 FontTest 파일이 있는지 확인
if not exist "%~dp0\FontTest.exe" (
    echo FontTest 프로그램을 찾지 못했습니다.
    echo FontTest 프로그램이 있는 폴더에 이 파일을 넣어주세요.
    pause
    exit
) else (
    echo - FontTest 프로그램을 찾았습니다.
)

rem 작업 시작 전에 글로벌 서버 백업 파일이 있는지 확인
if not exist "%~dp0\backup\000000.win32.index" (
    echo 글로벌 서버 백업 파일[000000.win32.index]이 존재하지 않습니다.
    echo 작업을 시작하기 전에 make-backup.bat을 실행해주세요.
    pause
    exit
)
if not exist "%~dp0\backup\000000.win32.dat0" (
    echo 글로벌 서버 백업 파일[000000.win32.dat0]이 존재하지 않습니다.
    echo 작업을 시작하기 전에 make-backup.bat을 실행해주세요.
    pause
    exit
)

rem 백업 생성일 체크
FOR /f "delims=" %%a IN (
    'dir /b /a-d "%~dp0\backup\000000.win32.*" '
    ) DO (
    CALL :creationdate "%~dp0\backup\%%a" c crdatetime
    ECHO - 글로벌 서버 백업 파일이 존재합니다. [%%a] 백업 날짜: !crdatetime:~0,10!
)

echo.
echo * 글로벌 서버 업데이트로 한글 폰트 패치가 풀린 이후 make-backup.bat을 실행한 적 없다면, 그 파일을 먼저 실행해주세요.
pause

rem 폴더가 없으면 생성
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
echo 글로벌 서버 백업본, 한국 서버 파일 복사 완료
echo.
echo 한글 폰트 패치 파일을 생성합니다...
"%~dp0\FontTest"
echo 생성 완료!

echo.
echo 글로벌 서버 파일에 한글 폰트 패치를 적용합니다.
echo 정말로 덮어씌우시겠습니까?
pause
copy "%~dp0\output\000000.win32.index" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
copy "%~dp0\output\000000.win32.dat1" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
echo.
echo 글로벌 서버에 한글 폰트 패치 적용을 완료했습니다.
pause

goto:eof
:creationDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
    'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof
