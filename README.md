# 🎥 스크린타임 
> 당신의 스크린타임을 지배했던 영화를 내 손 안에! 📲
<br>

## 🧑🏻‍💻 팀원 소개
|<a href="https://github.com/skkim125"><img src="https://avatars.githubusercontent.com/u/134041539?v=4" width="210px"/></a>|<a href="https://github.com/vichye-1"><img src="https://avatars.githubusercontent.com/u/66904886?v=4" width="210px"/></a>|<a href="https://github.com/dsungc1111"><img src="https://avatars.githubusercontent.com/u/114575573?v=4" width="210px"/></a>
| :---: | :---: | :---: |
| 김상규 | 양승혜 | 최대성 |
| 서치탭 <br>디테일뷰 | 네트워크 통신 로직 <br>Realm | 홈 탭 <br>다운로드 탭 |

<br>

<img src="https://github.com/user-attachments/assets/61fa8043-74ac-4c0d-8adc-4729092b69c5" width="220" height="470"/>

<br>

## 🙋‍♀️ 프로젝트 주요기능  
- 인기 영화, TV 시리즈를 함께 볼 수 있는 **메인화면**
- 원하는 컨텐츠를 검색할 수 있는 **검색화면**
- 좋아요한 컨텐츠를 볼 수 있는 **즐겨찾기 화면**
- Youtube와 연동되어 제공되는 **영화 예고편**
- 컨텐츠 세부 정보를 제공하고 비슷한 컨텐츠를 추천해주는 **상세화면**
<br>

## 🛠 개발 환경  

> **개발 인원** : iOS개발 3명
> 
> **개발 기간** : 24.10.08 - 24.10.13(6일)
> 
> **iOS 최소 버전** : 15.0+

   <br>

##  🦾 기술 스택
- UI : UIKit, Snapkit, YoutubePlayerKit, Kingfisher, IQKeyboardManager
- Reactive : RxSwift, RxCocoa, RxDataSource
- Database : FileManager, Realm
- Network : Alamofire
- 아키텍쳐 및 디자인 패턴 : MVVM(Input - Output), Repository﹒Router﹒Singleton 패턴
- 형상 관리 도구 : Git

<br>

## 🙌🏻 Git Commit Message Convention
```
🐞 Fix: 올바르지 않은 동작(버그)을 고친 경우 
🍿 Feat: 새로운 기능을 추가한 경우 
✨ Add: feat 이외의 부수적인 코드, 라이브러리 등을 추가한 경우, 새로운 파일을 생성한 경우도 포함
🩹 Refactor: 내부 로직은 변경하지 않고 기존의 코드를 개선한 경우, 클래스명 수정&가독성을 위해 변수명을 변경한 경우도 포함
🗑️ Remove: 코드, 파일을 삭제한 경우, 필요 없는 주석 삭제도 포함 
💄 Design: CSS 등 사용자 UI 디자인을 추가, 수정한 경우 
🎸 Chore: 위 경우에 포함되지 않는 기타 변경 사항 
🙈 gitignore: ignore파일 추가 및 수정
```
### 브랜치 전략
<img width="811" alt="스크린샷 2024-10-17 오후 7 20 08" src="https://github.com/user-attachments/assets/743cd0c3-84d3-4d95-8ef7-0cc951467acb">

<br>

## 🔎 주요 기술

### 네트워크
- Alamofire URLRequestConvertible을 채택한 enum으로 각 endpoint를 case로 구분하고, path, parameters, headers 등의 프로퍼티를 활용해 요청을 간편하고 일관성 있게 구성
- NetworkManager에서 제네릭 타입을 활용해 TMDB API의 다양한 엔드포인트 응답을 단일 메서드로 파싱하여, 모델별 중복 코드를 제거하고 재사용성과 유지보수성을 향상
- 네트워크 비동기 요청 결과를 단일 성공 또는 실패 이벤트로 처리하여, API 응답을 효율적으로 관리

### 데이터 관리

- MVVM 패턴을 활용하여 비즈니스 로직과 UI로직 분리하여 관리, Input/Output을 통해 데이터의 흐름을 명확하게 구현
- Realm을 활용하여 데이터 저장, 이미지 저장을 위해 FileManager 활용
- 컨텐츠 좋아요 클릭 시, 상태 변경을 다른 객체에 알리기 위해 NotificationCenter 활용

### 기타
- UICollectionView에 여러 섹션에 대응할 수 있도록 RxDataSource의 SectionModelType 활용
- BaseViewModel 프로토콜을 통한 ViewModel 구조 표준화로 일관된 개발 패턴 유지

<br>


## ☄️ 트러블 슈팅 

### 문제 상황 - DetailView init시 데이터가 불러오지 않는 문제 발생

- combineLatest를 활용해 초기 뷰가 init 되었을 때와 미디어 상세 페이지에서 좋아요 버튼 클릭 시, 새로운 값을 방출하도록 코드 구현
- combineLatest는 모든 Observable에서 값이 발행될 때까지 대기하므로 초기 데이터가 누락되어 초기 View가 init될 때 데이터를 받아오지 않는 문제가 발생

### 해결 - CombineLatest를 merge로 변경

- Observable.merge를 사용하여 초기 뷰가 init 되었을 때와 미디어 상세 페이지에서 좋아요 버튼 클릭 시 새로운 값을 방출하도록 수정
- merge는 여러 Observable의 이벤트를 하나로 합쳐 발행하므로, 각 Observable에서 하나의 이벤트가 발생할 때마다 값을 받을 수 있어 최초로 뷰가 init 되었을 때 데이터가 누락되지 않음

<br>
<img width="660" alt="트러블슈팅" src="https://github.com/user-attachments/assets/65e237fe-8abb-424e-9b9c-e687af18eca8">


## 💬 회고

### 🌟 좋았던 점

#### - 네트워크 통신에 RxSwift Single 도입
- 네트워크 요청을 처리에 RxSwift의 Single을 도입하였습니다. Single은 success 이벤트를 한 번만 방출하고 자동으로 종료되는 특성이 있어, 네트워크 요청의 일회성 특성과 잘 맞았습니다.  
- Single을 네트워크 처리에 적용해보면서 Single의 개념과 동작 방식을 깊이 이해할 수 있었고, 실제 프로젝트에 적용해봄으로써 이론적 지식을 실무 능력으로 발전시킬 수 있었습니다.

### 🌟 부족했던 점

####  - 효과적인 코드 리뷰의 필요성
- 처음에는 각자의 코드를 충분히 리뷰하지 못한 상태에서 Merge를 시도해 트러블이 발생한 경우가 있었습니다. 각자 작업한 내용을 철저히 검토하고, 팀원들과 더 적극적으로 피드백을 주고받았다면 협업이 더 원활했을 것입니다.

### 🌟 향후 계획

####  - PR 프로세스 최적화
- 다음 프로젝트에서는 커밋 단위를 더 명확히 정하고, PR 프로세스에 코드 리뷰와 커뮤니케이션 시간을 추가할 계획입니다. PR 과정에서 미리 문제를 발견하고 해결할 수 있는 코드 리뷰 시간을 통해, 더욱 효율적인 협업을 진행하고자 합니다.

####  - 기술 도입 전 사전 학습 진행
- 프로젝트 시작 전 새로운 기술을 도입할 때는 사전 학습 시간을 마련하여, 팀원 모두가 해당 기술에 대해 충분히 이해한 상태에서 프로젝트를 시작하도록 개선하려고 합니다.
  
#### - 향후 프로젝트에 Result를 래핑한 Single을 네트워크 통신에 도입 시도
- Single<Result<Success, Error>> 패턴을 활용하여 네트워크 요청을 구현함으로써, 더욱 세밀하고 체계적인 에러 핸들링이 가능하게끔 코드 설계를 하고자 합니다.

