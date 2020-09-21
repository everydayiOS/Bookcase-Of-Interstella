# 시안
## Main Idea
하루 한 장만 편지/글 쓰고 내가 원하는 날 원하는 시간에 읽을 수 있는 앱

전체 구조 : TabBar Controller (다섯개의 Tab)
1. 오늘의 메시지
2. 글쓰기
3. 임시보관함
4. 즐겨찾기함
5. 설정

## 1. 오늘의 메시지
주요 기능
- 어제 쓴 편지 확인
- 임시저장 or 즐겨찾기 선택

필요구현 세부사항
- ImageView를 통해 이미지 보여주기 (resizing)
- Label 의 메시지 (전날 작성 내용) 보여주기
- 이미지 & 메시지 크기에 따른 Autolayout (StackView)
- 임시 보관(button) 클릭 -> 보관할 기간 선택 (DatePicker) -> Label의 메시지 내용(data)을 '임시보관함' VC에 전달하기
- 즐겨찾기(button) 클릭 -> Label의 메시지 내용(data)을 '즐겨찾기' VC에 전달하기

## 2. 글쓰기
주요 기능
- 미래에 보낼 편지 작성하기

필요구현 세부사항
- 설정한 시간에서 1시간 이내로만 작성 가능하게 하기, 이외의 시간엔 disabled
- UIImagePickerController를 통해 이미지 가져오기
- TextView에 편지 내용 작성하기
- 전송하기 클릭 -> data 저장 -> 화면 초기화

## 3. 임시보관함
주요 기능
- 정해진 시간동안 받은 편지 보관하기
- 정해진 시간이 지나면 보관함에서 사라짐

필요구현 세부사항
- tableview + table cell 구성하기
- 편지 남은 시간 타이머 구현하기
- table cell 클릭 > 편지 세부사항 > 즐겨찾기 이동 / 삭제 가능 (navigation controller로 화면 이동 가능) 

## 4. 즐겨찾기함
주요 기능
- 받은 편지를 영구적으로 보관 가능

필요구현 세부사항
- tableview + table cell 구성하기
- table cell 클릭 > 편지 세부사항 > 삭제 가능 (navigation controller로 화면 이동 가능)

## 5. 설정
주요 기능
- 편지 쓸 시간 설정
- 편지를 받을 디폴트 시간 설정
- 즐겨찾기 편지 항목 갯수 설정

## 6. 기타
- 애니메이션 활용
