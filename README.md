## 🧑🏻‍💻 팀원 소개
|<a href="https://github.com/skkim125"><img src="https://avatars.githubusercontent.com/u/134041539?v=4" width="150px"/></a>|<a href="https://github.com/vichye-1"><img src="https://avatars.githubusercontent.com/u/66904886?v=4" width="150px"/></a>|<a href="https://github.com/dsungc1111"><img src="https://avatars.githubusercontent.com/u/114575573?v=4" width="150px"/></a>
| :---: | :---: | :---: |
| 김상규 | 양승혜 | 최대성 |

## Git Commit Message Convention
🐞 Fix: 올바르지 않은 동작(버그)을 고친 경우 

🐣 Feat: 새로운 기능을 추가한 경우 

✨ Add: feat 이외의 부수적인 코드, 라이브러리 등을 추가한 경우, 새로운 파일(Component나 Activity 등)을 생성한 경우도 포함 

🩹 Refactor: 내부 로직은 변경하지 않고 기존의 코드를 개선한 경우, 클래스명 수정&가독성을 위해 변수명을 변경한 경우도 포함

 🗑️ Remove: 코드, 파일을 삭제한 경우, 필요 없는 주석 삭제도 포함 

🚚 Move: fix, refactor 등과 관계 없이 코드, 파일 등의 위치를 이동하는 작업만 수행한 경우 

🎨 Style: 내부 로직은 변경하지 않고 코드 스타일, 포맷 등을 수정한 경우, 줄 바꿈, 누락된 세미콜론 추가 등의 작업도 포함 

💄 Design: CSS 등 사용자 UI 디자인을 추가, 수정한 경우 

📝 Comment: 필요한 주석을 추가, 수정한 경우(❗ 필요 없는 주석을 삭제한 경우는 remove) 

📚 Docs: 문서를 추가, 수정한 경우 

🔧 Test: 테스트 코드를 추가, 수정, 삭제한 경우 

🎸 Chore: 위 경우에 포함되지 않는 기타 변경 사항 

🙈 gitignore: ignore파일 추가 및 수정

```mermaid
%%{init: { 'logLevel': 'debug', 'theme': 'default' , 'themeVariables': {
              'commitLabelFontSize': '20px'
       } } }%%
gitGraph
   commit id: "main"
   commit id: "dev"
   branch dev
   checkout dev
   commit id: "feature1"
   branch feature1
   checkout feature1
   commit id: "Network"
   checkout dev
   commit id: "feature2"
   branch feature2
   checkout feature2
   commit id: "UI"
   checkout dev
   commit id: "feature3"
   branch feature3
   checkout feature3
   checkout feature2
   checkout feature1
   checkout feature3
   commit id: "Realm"
   checkout dev
   merge feature1
   merge feature2
   checkout feature3
   commit id: "FileManager"
   checkout dev
   merge feature3
   checkout main
   merge dev
   commit id: "v1.0.0"
```
