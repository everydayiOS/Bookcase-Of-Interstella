# Bookcase-Of-Interstella

### 앱 컨셉: 하루 한 장만 편지/글 쓰고 내가 원하는 날 원하는 시간에 읽을 수 있는 앱

### 제한 정도
1. 편지는 당일에만 확인 가능하게 할까요? 
- 설정: 본인이 몇 일동안 보관 후 삭제할 건지 설정 가능
- 메시지를 읽고 바로 보관할 수 있음
- 즐겨찾기처럼 킵하고 싶은것만 하고 나머지는 자동 삭제
- 킵하는 갯수도 정해놓고(최대 몇 개만)

2. 받는 시간
- 편지를 받는 시간도 설정에서 설정할 수 있음. 또는 랜덤 시간에 받아볼 수 있음.
- 기본 디폴트는 하루 후, 설정에서 몇 일 후(최대 일주일)에 받을지 설정 가능하도록

3. 편지지 생성 시간
- 사용자 정의
- 사용자가 정한 시간에서 1시간 이내에 작성해야함
- 이 시간안에 작성하지 않으면 유명한 추천 글귀를 랜덤하게 받아보는 것도 좋을 듯

4. 텍스트 뿐만 아니라 이미지도 첨부할건지
- 이미지도 첨부가능 (user default 또는 Core Data)

5. 위젯
- 위젯 지원

### 작업 역할 분담

### 디자인
1. 기능 정의 
2. 화면 요소 지정 + 화면별 기능 정하기
3. 디자인 (피그마 사용)
4. 로고, 메인 색상 정하기

### 기능 및 화면
* 화면은 xib 또는 코드 사용해서 구현
1. 글쓰기 (워닝닝님)
2. 즐겨찾기 편지 목록 (이니님)
3. 편지 도착했을 때 화면 (유리맥님)
4. 설정 (추후)
5. 임시 보관 편지 목록 (수달님)
6. 메인 (디자인 나오기 전까지 임시 오브젝트로 화면 이동)

### 프로젝트 진행
- 목표 기간: 10월 26일 심사 신청
- 진행 방법: 
첫 회의: 2020년 9월 16일 수요일  
첫째주 & 둘째주: 기획 -> 화면 기획서  
9월 22일 화요일 회의에서 화면별 라이브러리 사용 기술 정하기 + 컨벤션, 브랜치 룰 정하기  

- 회의 날짜: 화요일 10시 반
  - 자기 부분 구현하기 전에 사용한 기술 공부해서 발표하고 피드백 받기
  - 피드백에 대한 기능 구현자의 최소 변론 (5명 모두 approve 하면 merge 되도록)
- 기능 구현: 일요일 오전까지
- PR 코드 리뷰: 월요일 자정까지


### 그라운드 룰
- 커밋룰: 9월 22일 화요일 회의 때 의논하기
- 브랜치룰: 

### 9월 22일 화요일 회의
- 할 일  
  - 모두: Git/ Github 공부해오기 + 디자인 컨셉 생각해오기 + 코드/xib로 화면 구현하는 방법 공부해오기  
  - 개인 주제: autolayout(이니), animation(워닝닝), dispatchQueue(유리맥), fcm(수달), MVVM(레나) 하나씩 맡아서 공부해오기
  - autolayout(이니): 이론적인 접근보다 실제로 저희가 사용하는 내용 위주. 나름대로 구성하신 화면으로 오토레이아웃 공부해 오는 걸로 하죠!
  - 내용: 기본적인 내용 + 공부한 내용 + 우리 프로젝트에서 어떻게 진행하면 좋을지
- 화요일 저녁 8시까지 자기가 정리한 내용 md 파일로 업로드 -> study-documentation 브랜치 

### 9월 27일 일요일 회의
- Architecture : MVC로 구현 후, MVVM으로 리팩토링 예정
- 한글 명언 API : UserDefault 활용하여 앱 첫 실행시 자동다운로드
- 버전 : 11
- 최소 지원 버전 : 11

- 다음주 일요일 10/04 21:00 
  - 각자 기능 담당 정하기
  - 코딩컨벤션 정하기
  - 수달님: FCM 보충, 인증서 배포 공유하기
  - 문서수정해서 올리기
  - 화면 구체화 해오기
  
### 10월 4일 일요일 회의
- 코딩 컨벤션 [StyleShare Swift-style-guide](https://github.com/StyleShare/swift-style-guide)
- 다음주중(수요일)으로 대략적인 화면 디자인 공유 (워닝닝님), master 브랜치에 임시 오브젝트 생성
- SwiftLint 적용 (이니님)
- 각자 기능 별로 브랜치 따서 진행

- 다음주 토요일 10/10 20:00
  - 각자 화면 기능에 대한 정의
  - 코드리뷰(어려웠던 점, 신경썼던 점 공유)
  
### 10월 10일 토요일 회의
```
struct letter {
  var contents: String
  var photo: UIImage?
  var timestamp: String
  var validTime: String
  var isBookmarked: Bool
}
```
- 편지 도착 시 모달로 표시 / 나머지 화면은 push로 이동
- Local Notification 으로 구현
- 임시보관함 : 유효기간 경과한 편지는 자동 삭제, isBookmarked false인 편지만 표시
- 즐겨찾기 : isBookmarked true인 편지만 표시
- Userdefaults에 timestamp를 key로 설정
- master - Userdefaults에 데이터 저장, 삭제 함수 구현 -> 워닝닝님
- master - ViewController 링크 누락된 부분 추가 -> 워닝닝님

- 10/18 일요일 21:00
  - 각자 화면 기능에 대한 정의
  - 코드리뷰(어려웠던 점, 신경썼던 점 공유)

### 커밋 메시지
- git karma style
```
Feat: 내용을 적어주세요

- 세부 내용

#1 (관련 이슈 번호)
```
