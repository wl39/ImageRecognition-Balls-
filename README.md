# ImageRecognition-Balls-
- 사용 언어: MATLAB
- MATLAB 기반으로 만든, Image Recognition application 입니다.
	- 이 프로그램은 Image중에서 몇 개의 파란색, 초록색, 노란색 빨간색 공이 있는지 알려주는 프로그램입니다.
	 - 프로그램에서 사용된 이미지 파일들은 source_files/ 폴더에 있습니다.
	- 모든 이미지 파일에 대한 결과값은 results/ 폴더에 있습니다.
- 개발기간: 10일
- 마지막 수정일: 2022년 11월
  
## 사용방법
- **MATLAB이 컴퓨터내에 설치되어 있어야 합니다.**
- MATLAB 프로그램을 실행 후, 폴더 위치를 code/ 로 설정해줍니다.
- 그 후, 실행 버튼을 누르면 됩니다.
	- 각 코드의 4번째 줄에 파일을 읽는 줄이 있습니다: `rgb = imread("../source_files/very_easy.jpg");`
	- `imread("<file_path>")` 에서 `<file_path>` 부분을 원하는 이미지 파일로 변경할 수 있습니다.

---
## 프로그램에서 주목해서 봐야할 점
- RGB값을 CIELAB 컬러 공간으로 변경
- CIELAB 컬러 공간을 이용해, 색상 추출
- Opening/Closing Image
