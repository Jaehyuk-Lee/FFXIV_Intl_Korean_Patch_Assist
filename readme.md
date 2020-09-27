# 한글 패치 도우미 안내

이 저장소는 버전 관리를 위한 저장소입니다. 사용법에 관한 문의는 받지 않습니다.  
한글 패치에 필요한 프로그램 또한 따로 찾으셔야 합니다.

아래는 각 파일의 용도 설명을 위해 간단히 적은 내용입니다.

## 패치 사용법

### 0. make-backup.bat

백업본을 생성합니다. (현재 디렉토리에 `backup` 폴더를 생성하고, 그 폴더에 백업합니다.)

### 0. restore-backup.bat

백업본을 이용해 패치를 되돌립니다. (관리자 권한 필요)

### 1. apply-translation.bat / 1. apply-fontpatch.bat

한글 패치를 적용합니다. (관리자 권한 필요)  
한국 서버, 글로벌 서버 프로그램에 있는 파일을 input (AllaganNode) / korean, global (fontTest) 폴더에 복사해서 output 폴더에 한패 결과물을 생성합니다.  
글로벌 서버에 덮어쓰기 하기 전까지는 글로벌 서버는 원본 그대로 남아있습니다. 따라서, 문제가 생기면 이 파일을 처음부터 다시 실행하면 됩니다.

## 참고
`AllaganNode`는 한국어 데이터 적용, `FontTest`는 한글 폰트 출력에 사용합니다.

Allagan-Node는 GitHub에 저장소가 있습니다. [링크](https://github.com/allagan-node/allagan-node)