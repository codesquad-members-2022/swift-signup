# Step1 - 회원가입-요구사항

## 💻 작업 목록

- [x] 스토리보드 디자인
- [x] 회원가입 흐름 연결


## 📱 실행 화면

![스크린샷 2022-03-30 오전 12 19 05](https://user-images.githubusercontent.com/95578975/160646064-d157ea3d-6a07-4184-889d-7e320214d60e.png)
![Simulator Screen Recording - iPhone 13 Pro Max - 2022-03-30 at 02 18 41](https://user-images.githubusercontent.com/95578975/160669007-5dceab25-ae59-44a5-8032-c1a08e9ead3c.gif)

- 1번째 화면 (회원가입 - SignUpVC)
    - NavigationController를 Embed하고, NavigationController Top Bar의 속성을 None으로 지정했습니다.
    - `다음` 버튼을 클릭하면 InfoVC (개인정보 화면)을 띄우도록(push) Segue를 연결했습니다.
- 2번째 화면 (개인정보 - InfoVC)
    - InfoVC에서 이전 버튼을 누르면 InfoVC를 pop 했습니다.
    - `다음` 버튼을 클릭하면 AgreeVC (동의 화면)로 넘어갈 때 Segue를 `Modal` 방식으로 연결했습니다.
- 3번째 화면 (동의 - AgreeVC)
    - `취소` 버튼을 누르면 AgreeVC를 dismiss 했습니다.
    - `동의` 버튼을 누르면 InterestVC (관심사 화면)으로 넘어도록 구현했습니다. 이 때 Segue는 기본 값 `Push`로 설정하였습니다.
- 4번째 화면 (관심사 - InterestVC)
    - 로그인 화면으로 넘어갈 때 Push/Pop 방식으로 구현하기 위해서 관심사 화면을 NavigationController로 Embed 하였습니다. 
    - 화면은 전체를 꽉 채우기 위해서 Presentation을 `FullScreen`으로 설정하였습니다.
    - `이전` 버튼을 누르면 InterestVC를 dismiss 했습니다.
    - `완료` 버튼을 누르면 LoginVC (로그인 화면)을 띄우도록(push) Segue를 연결했습니다.
- 5번째 화면 (로그인 - LoginVC)
    - 화면은 전체를 꽉 채우기 위해서 Presentation을 `FullScreen`으로 설정하였습니다.
## 💡 학습 키워드

- NavigationController
- StackView
- Segue
