@echo off
set GLOBAL_PATH=C:\Program Files (x86)\SquareEnix\FINAL FANTASY XIV - A Realm Reborn

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

echo �۷ι� ���� ������ ������ �´��� Ȯ�����ּ���.
echo �߸��� ������ ����ϰ� �Ǹ� �� ���Ϸ� ������ �� �����ϴ�.
echo * �ѱ� ��Ʈ ��ġ�� Ǯ�� ������ ����� �������ּ���.
echo * �̹� ����ε� �ֽ� ��ġ ������� �ִٸ� �ٽ� ������ �ʿ䰡 �����ϴ�.
echo ������ �´ٸ�, �ƹ� Ű�� �����ʽÿ� . . .
pause> nul

rem ������ ������ ����
if not exist "%~dp0\backup\" (
    mkdir "%~dp0\backup"
)
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\000000.win32.index" "%~dp0\backup\"
copy "%GLOBAL_PATH%\game\sqpack\ffxiv\000000.win32.dat0" "%~dp0\backup\"
