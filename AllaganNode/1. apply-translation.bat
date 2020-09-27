@echo off
SETLOCAL ENABLEDELAYEDEXPANSION
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn
set KOREA_PATH=C:\Program Files (x86)\FINAL FANTASY XIV - KOREA

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

rem 작업 시작 전에 translations 파일이 있는지 확인
if not exist "%~dp0\input\translations" (
    echo input 폴더 안에 translations 파일이 존재하지 않습니다.
    echo 작업을 시작하기 전에 해당 파일을 input 폴더 안에 넣어주십시오.
    echo 해당 파일은 따로 배포 중입니다. 없다면 어둠의 경로로 구하십시오.
    pause
    exit
) else (
    echo - translations 파일이 존재합니다.
)

rem 작업 시작 전에 AllaganNode 파일이 있는지 확인
if not exist "%~dp0\AllaganNode.exe" (
    echo AllaganNode 프로그램을 찾지 못했습니다.
    echo AllaganNode 프로그램이 있는 폴더에 이 파일을 넣어주세요.
    pause
    exit
) else (
    echo - AllaganNode 프로그램을 찾았습니다.
)

rem 작업 시작 전에 글로벌 서버 백업 파일이 있는지 확인
if not exist "%~dp0\backup\0a0000.win32.index" (
    echo 글로벌 서버 백업 파일[0a0000.win32.index]이 존재하지 않습니다.
    echo 작업을 시작하기 전에 make-backup.bat을 실행해주세요.
    pause
    exit
)
if not exist "%~dp0\backup\0a0000.win32.dat0" (
    echo 글로벌 서버 백업 파일[0a0000.win32.dat0]이 존재하지 않습니다.
    echo 작업을 시작하기 전에 make-backup.bat을 실행해주세요.
    pause
    exit
)

rem 백업 생성일 체크
FOR /f "delims=" %%a IN (
    'dir /b /a-d "%~dp0\backup\0a0000.win32.*" '
    ) DO (
    CALL :creationdate "%~dp0\backup\%%a" c crdatetime
    ECHO - 글로벌 서버 백업 파일이 존재합니다. [%%a] 백업 날짜: !crdatetime:~0,10!
)

echo.
echo * 글로벌 서버 업데이트로 한국어 패치가 풀린 이후 make-backup.bat을 실행한 적 없다면, 반드시 먼저 실행해주세요.
echo * 도중에 실수를 하셨다면 이 파일을 닫고 다시 실행하세요.
pause

rem input 폴더가 없으면 생성
if not exist "%~dp0\input\" (
    mkdir "%~dp0\input"
)

echo.
copy "%KOREA_PATH%\game\sqpack\ffxiv\0a0000.win32.index" "%~dp0\input\"
copy "%KOREA_PATH%\game\sqpack\ffxiv\0a0000.win32.dat0" "%~dp0\input\"
echo 한국 서버 0a0000.win32.index, 0a0000.win32.dat0 파일 복사 완료
echo.
echo AllaganNode 실행 중...
echo 로딩이 완료되면 "0"을 입력하십시오.
"%~dp0\AllaganNode"

copy "%GLOBAL_PATH%\game\sqpack\ffxiv\0a0000.win32.index" "%~dp0\input\"
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\0a0000.win32.dat0" "%~dp0\input\"
echo 글로벌 서버 0a0000.win32.index, 0a0000.win32.dat0 파일 복사 완료
echo.
echo AllaganNode 실행 중...
echo 로딩이 완료되면 "0"을 입력하십시오.
"%~dp0\AllaganNode"
echo.

echo.
echo AllaganNode 실행 중...
echo 로딩이 완료되면 "swap"을 입력하고 "ko"를 입력한 다음,
echo 주로 사용하는 클라이언트 언어를 입력하세요. (예: ja, en, de, fr... 중 한 개만 입력)
"%~dp0\AllaganNode"
echo.

echo.
echo AllaganNode 실행 중...
echo 로딩이 완료되면 "1"을 입력하고 아까 입력한 글로벌 서버 언어를 입력하세요.
"%~dp0\AllaganNode"
echo.

echo.
echo AllaganNode 실행 중...
echo 로딩이 완료되면 "2"를 입력하고 아까 입력한 글로벌 서버 언어를 입력하세요.
"%~dp0\AllaganNode"
echo.

echo.
echo 글로벌 서버 파일에 한국어 패치를 적용합니다.
echo 정말로 덮어씌우시겠습니까?
echo * 실행 후 문제가 생긴다면 restore-backup.bat를 실행해서 백업한 내용을 복구하세요.
pause
copy "%~dp0\output\0a0000.win32.dat1" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
copy "%~dp0\output\0a0000.win32.index" "%GLOBAL_PATH%\game\sqpack\ffxiv\"
echo.
echo 글로벌 서버에 한국어 패치 적용을 완료했습니다.
pause

goto:eof
:creationDate
for /f "skip=5 tokens=1,2 delims= " %%a in (
    'dir  /a:-d /o:d /t:%2 "%~1"') do set "%~3=%%~a %%~b"&goto:eof
goto:eof
