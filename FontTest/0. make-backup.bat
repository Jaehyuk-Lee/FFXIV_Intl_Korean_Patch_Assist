@echo off
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn

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

echo 글로벌 서버 파일이 원본이 맞는지 확인해주세요.
echo 잘못된 파일을 백업하게 되면 그 파일로 복구할 수 없습니다.
echo * 한글 폰트 패치가 풀릴 때마다 백업을 실행해주세요.
echo * 이미 제대로된 최신 패치 백업본이 있다면 다시 실행할 필요가 없습니다.
echo 원본이 맞다면, 아무 키나 누르십시오 . . .
pause> nul

rem 폴더가 없으면 생성
if not exist "%~dp0\backup\" (
    mkdir "%~dp0\backup"
)
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\000000.win32.index" "%~dp0\backup\"
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\000000.win32.dat0" "%~dp0\backup\"
