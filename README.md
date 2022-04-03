# swift-signup
회원가입 프로젝트 저장소

## [수정 이력]
| 날짜       | 번호   | 내용                                    | 비고                             |
| ---------- | :----- | --------------------------------------- | -------------------------------- |
| 2022.04.03 | STEP3 | 회원가입 구성 요소 유효성 검사 구현 및 push 구현    |                                  |
| 2022.03.31 | STEP2 | 회원가입 화면 구현 및 아이디 유효성 검사 구현       |                                  |
| 2022.03.29 | STEP1 | 로그인 화면 구현하기                  |                                  |


<details>
<summary> STEP3 : 회원가입 구성 요소 유효성 검사 구현 및 push 구현 </summary>
## 작업 목록
### 리팩토링
- 싱글톤 구현 요소 일반 인스턴스로 수정
- 메서드명 구체적으로 수정
- URL 접근, Decode, 검증 로직 구분 및 분리

### SigninViewController 구성
- 비밀번호 / 비밀번호 재확인 / 이름 유효성 검사 관련 기능 구현
    + delegate가 아닌, addTarget에 각각의 유효성 검사 로직 함수 연결
    + 유효성에 따른 Case를 통해 UI 변경 기능 구현
- 키보드 return 변경
    + next 타입으로 변경
    + nameTextField에서 모든 유효성 검사가 true이면, done타입으로 변경 후 다음 VC로 push 구현
- NextButton 구현
    + 모든 유효성 검사가 true이면, done타입으로 변경 후 다음 VC로 push 구현
- 모든 유효성 검사 관련 Enum 타입 구현

</details>

<details>
<summary> STEP2 : 회원가입 화면 구현 및 아이디 유효성 검사 </summary>
## 작업 목록
### LoginViewController 수정
- 전반적인 메서드 이름 변경 (동사 + 목적어 형태)

### SiginViewController 구성
- 생성할 아이디, 비밀번호 및 비밀번호 재확인, 이름 기입 요소 구현 (Label / TextField)
    + NavigationBar를 기준으로 Attribute 위치 직접 구현
- NavigationBar 타이틀 구현
    + setNavigationBar 함수에 NSAttributedString.Key를 활용하여 타이틀 폰트 구현
- 각각의 TextField의 입력 값에 대한 유효성을 검사 위해 모두 Delegate 설정
    + textField(shouldChangeCharactersIn) 함수에 유효성 검사 로직 구현
    + 유효성 결과에 따른 layer 색상 변경을 위한 changeTextFieldLayer 함수 구현
    + 키보드 return 입력 및 외부 view 터치 시의 키보드 dismiss 구현을 위해 textFieldShouldReturn 및 textFieldDismissKeyboard 함수 구현
        * textFieldShouldReturn 함수 내에서 textField.resignFirstResponder()를 호출하고 true 리턴 시, 키보드 dismiss
- TextField의 값을 체크하는 로직을 가진 TextFieldValueChecker 객체 구현
    + checkID 함수 내에 정규표현식을 설정하여 ID의 길이, 중복 여부, 올바른 ID 구성인지를 유효성 검사하도록 로직 구현
        * return 값은 enum 타입으로 구현
    + httpGetId 함수를 통해 URL에 GET 요청을 보내고 기존 ID들의 값을 받아와 checkID에서 중복 여부를 판단할 수 있도록 로직 구현
        * URLSession.shared.dataTask 사용 시, 마지막에 .resume() 필수로 작성!
- 유효성 검사에 따른 적절한 값을 내포하고 있는 CheckValidIDCase enum 구현

</details>

<details>
<summary> STEP1 : 로그인 화면 구현 </summary>
## 작업 목록
### LoginViewController 구성
- 아이디와 비밀번호를 입력하고 로그인하거나, 회원가입 창으로 넘어갈 수 있는 화면 구성
- 로그인 창의 타이틀 라벨을 IBOutlet으로 구성하고, 이를 기반으로 나머지 Attribute들의 위치 직접 구현
    + 모든 Attribute들의 x 좌표는 rootView에서 40, width는 rootView의 width에서 -80으로 고정
    + textField는 Input 값이 틀에 바로 붙지 않도록 leftView를 활용하여 10정도 padding 부여
        * 키보드 return 입력 혹은 키보드 창 밖을 클릭 시, 키보드가 사라지도록 TextFieldDelegate의 textFieldShouldReturn과 커스텀 함수인 textFeildDismissKeyboard 구현
- 회원가입 버튼 클릭 시, NavigationController로 구현된 SiginViewController로 이동
    + 화면 이동은 modal present로 구현

</details>
