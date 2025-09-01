## 📱 숫자 야구 게임 (Baseball Game)

간단한 콘솔 기반 숫자 야구 게임입니다. 게임 시작, 기록 조회, 종료를 메뉴로 제공하며, 기록은 로컬 JSON 파일로 저장합니다. 설계는 Swift의 값/참조 타입 철학에 맞추고, Protocol 기반 추상화와 Factory 패턴으로 생성 의존성을 단순화했습니다.

---

### 🚀 실행 방법
- 요구 사항: Swift 5.9+, macOS 환경
- 프로젝트 루트에서 실행:
```bash
swift run  # Xcode 프로젝트가 아닌 경우
```
또는 Xcode에서 `BaseballGameApp.xcodeproj` 열고 실행합니다.

---

### 🧭 사용법
앱 실행 후 메뉴가 출력됩니다.
```
1. 게임 시작하기 2. 게임 기록 보기 3. 종료하기
```
- 1: 게임을 시작하고, 정답을 맞추면 시도 횟수가 기록됩니다.
- 2: 저장된 게임 기록(시도 횟수)을 조회합니다.
- 3: 프로그램을 종료합니다.

게임 기록은 프로젝트 실행 디렉토리에 `game_records.json` 파일로 저장됩니다.

---

### 🧱 프로젝트 구조
```
BaseballGameApp/
  BaseballGameApp/
    Errors/
      BaseballGameError.swift
      ValidateGuessError.swift
    Game/
      BaseballGame.swift
      GameProtocol.swift
    Records/
      GamePlayRecorder.swift
      Models/
        GameRecord.swift
        en.lproj/
          game_record.json
    Utils/
      GameFactory.swift
      GameRecordFilePath.swift
      GameRecordReader.swift
      RandomNumberGenerator.swift
    GameManager.swift
    main.swift
README.md
```

---

### 🧩 아키텍처 개요
- **엔트리 포인트**: `main.swift`에서 의존성을 구성하고 `GameManager.start()` 호출
- **오케스트레이터**: `GameManager`가 메뉴/흐름을 관리하며, `GameFactory`로 게임 인스턴스를 생성
- **게임 도메인**: `Game` 프로토콜과 구현체 `BaseballGame`
- **유틸리티**:
  - 난수 생성기: `RandomNumberGenerating` / `RandomNumberGenerator`
  - 기록 저장: `GamePlayRecording` / `GamePlayRecorder`
  - 기록 조회: `GameRecordReading` / `GameRecordReader`

---

### 🧠 설계 의도와 선택

#### 1) Protocol 기반 인터페이스
- `Game`, `RandomNumberGenerating`, `GamePlayRecording`, `GameRecordReading`을 **프로토콜**로 정의해 구현체 교체가 쉽도록 했습니다.
- 효과:
  - 테스트/DI 용이: 예) 랜덤/레코더/리더를 목(mock)으로 대체 가능
  - 결합도 감소: 구현 변경이 상위 흐름(`GameManager`)에 파급되지 않음

#### 2) Factory 패턴으로 생성 단순화
- `BaseballGameFactory: GameFactory`가 `BaseballGame` 생성 시 필요한 의존성(`RandomNumberGenerating`, `GamePlayRecording`)을 캡슐화합니다.
- 배경: 게임이 진행되며 내부 상태가 적절히 갱신되지 않는 문제가 있었고, 생성/주입 책임을 **Factory로 일원화**하여
  - 생성 타이밍과 의존성 구성을 명확히 하고
  - `GameManager`에서의 생성 로직을 단순화해 상태 일관성 문제를 해소했습니다.

#### 3) 값/참조 타입 선택
- `GameManager`: 공유/지속 상태 관리가 필요해 **class(참조 타입)** 사용
- `RandomNumberGenerator`: 내부 상태가 없고 순수 기능이므로 **struct(값 타입)** 사용

#### 4) 접근 제어(캡슐화)
- 외부 API는 `public`으로, 내부 구현은 `internal/private/fileprivate`로 최소 노출
- 예) `GameManager`의 상태는 외부에서 변경 불가, `BaseballGame`의 진행 로직/검증은 `private`

---

### ⚙️ 주요 컴포넌트 요약
- `GameManager`
  - 메뉴 루프 관리, 기록 조회, 게임 시작/종료
  - `GameFactory.createGame()`로 매 게임 인스턴스 생성
- `BaseballGame`
  - 입력 검증(`ValidateGuessError`), 판정(`BaseballGameError.notMatch`), 종료 시 기록
- `GamePlayRecorder`
  - 시도 횟수 증가/저장/리셋, JSON 파일로 저장
- `GameRecordReader`
  - 기록 파일 로드 및 문자열 포맷 반환
- `RandomNumberGenerator`
  - 첫 자리 1~9, 나머지 0~9 중 중복 없이 섞어 3자리 생성

---

### 🧯 에러 처리
- 도메인 에러를 명확히 분리:
  - `ValidateGuessError`: 길이/숫자/유효 범위 검증 실패
  - `BaseballGameError`: 게임 진행 중 판정 결과(스트라이크/볼/낫싱), 입력 불가
- `LocalizedError` 구현으로 사용자 메시지 일원화
- 게임 루프에서 `do-catch`로 메시지 출력 후 재시도

---

### 📚 FAQ
- Q. 왜 프로토콜을 썼나요?
  - A. 구현 세부를 가리고 테스트/교체 가능성을 확보하기 위해서입니다. 콘솔 앱이지만, 입력/난수/기록은 쉽게 바뀌는 축이라 인터페이스로 고정했습니다.
- Q. Factory는 꼭 필요했나요?
  - A. 게임 인스턴스 생성 시 의존성 주입이 분산되어 상태 갱신 타이밍 문제가 생길 여지를 줄이기 위해, 생성을 일원화해 단순/안정화했습니다.

---

### 💾 데이터 저장 선택: UserDefaults vs JSON vs Core Data
- **UserDefaults**
  - **장점**: 사용 간단, 소량의 환경설정(Key-Value)에 적합
  - **단점**: 기록을 저장/불러오는 흐름이 깔끔하지 않게 느껴졌고, 여러 개의 기록 목록을 다루기엔 불편
  - **판단**: 이번 프로젝트의 "게임 기록 히스토리"에는 맞지 않음
- **JSON 파일(선택)**
  - **장점**: 사람이 읽기 쉬움, `Codable`로 목록 가져오기 간단, 네트워크에서 쓰는 `Decodable/Encodable`과 사용 방식이 비슷함
  - **단점**: 파일 경로와 파일 읽기/쓰기 중 발생할 수 있는 오류를 직접 처리해야 함, 동시에 여러 곳에서 접근하면 충돌이 날 수 있어 주의가 필요
  - **적용**: 파일 읽기/쓰기, 오류 처리까지 직접 다뤄보는 **도전적 선택**으로 채택
    - 모델: `Records/Models/GameRecord.swift`
    - 경로: `Utils/GameRecordFilePath.swift` (실행 디렉토리의 `game_records.json`)
    - 저장: `Records/GamePlayRecorder.swift` (`saveRecords`, `loadRecords`)
    - 조회: `Utils/GameRecordReader.swift`
- **Core Data**
  - **장점**: 스키마 기반, 대용량·관계형 데이터·쿼리·마이그레이션 강점
  - **단점**: 러닝 커브·보일러플레이트 증가, 이번 범위엔 오버엔지니어링
  - **판단**: 오버엔지니어링이라고 판단되었음

요약: 소규모 기록을 명확히 남기고 파일 읽기/쓰기와 오류 처리 경험을 쌓기 위해 **JSON 파일 저장**을 채택했습니다.

---

### 🔐 파일 저장 위치
- 기록 파일: 실행 디렉토리의 `game_records.json`
- 경로 계산: `Utils/GameRecordFilePath.swift`
