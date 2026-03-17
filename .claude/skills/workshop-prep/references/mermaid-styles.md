# Mermaid 스타일 및 다이어그램 명세

## classDef 표준 정의

모든 flowchart 다이어그램에서 사용할 classDef 패턴:

```
classDef event fill:#FF9800,color:#000,stroke:#E65100
classDef command fill:#2196F3,color:#fff,stroke:#1565C0
classDef aggregate fill:#FFEB3B,color:#000,stroke:#F9A825
classDef policy fill:#9C27B0,color:#fff,stroke:#6A1B9A
classDef external fill:#4CAF50,color:#fff,stroke:#2E7D32
classDef readmodel fill:#E3F2FD,color:#000,stroke:#1565C0,stroke-width:2px
classDef hotspot fill:#FF69B4,color:#fff,stroke:#C2185B
```

### 변형 classDef (특수 용도)

```
%% 신규 애그리게이트 (점선 테두리)
classDef newAgg fill:#FFEB3B,color:#000,stroke:#F9A825,stroke-width:3px,stroke-dasharray:5 5

%% 오분류 항목 (점선 테두리 + 이벤트 색상에 애그리게이트 테두리)
classDef wrong fill:#FF9800,color:#000,stroke:#F9A825,stroke-width:3px,stroke-dasharray:5 5

%% 읽기모델 용도별 색상
classDef customer fill:#FFF3E0,color:#000,stroke:#FF9800
classDef operator fill:#E8F5E9,color:#000,stroke:#4CAF50

%% 정책 결과
classDef result fill:#E1BEE7,color:#000,stroke:#6A1B9A

%% 강조 애그리게이트 (굵은 테두리)
classDef aggregate fill:#FFEB3B,color:#000,stroke:#F9A825,stroke-width:2px
```

### 노드에 class 적용

```mermaid
%% 방법 1: 인라인 (:::)
E1[이벤트명]:::event
C1[커맨드명]:::command

%% 방법 2: class 선언문
class E1,E2,E3 event
class C1,C2 command
```

## 다이어그램 10종 명세

### 1. 현황 요약 — `pie`

```mermaid
pie title {N-1}차 워크샵 도출 요소 현황
    "도메인 이벤트 🟧" : {이벤트수}
    "커맨드 🟦" : {커맨드수}
    "애그리게이트 🟨" : {애그리게이트수}
    "정책 💜" : {정책수}
    "외부 시스템 🟩" : {외부시스템수}
    "핫스팟 🩷" : {핫스팟수}
```

**필수 요소**: 최소 이벤트, 커맨드, 애그리게이트 3개 항목. 값이 0인 항목도 포함.

### 2. 흐름 영역 맵 — `flowchart LR`

```mermaid
flowchart LR
    A[① 영역1] --> B[② 영역2] --> C[③ 영역3]

    classDef event fill:#FF9800,color:#000,stroke:#E65100
    classDef command fill:#2196F3,color:#fff,stroke:#1565C0
    classDef aggregate fill:#FFEB3B,color:#000,stroke:#F9A825
    classDef external fill:#4CAF50,color:#fff,stroke:#2E7D32
    classDef hotspot fill:#FF69B4,color:#fff,stroke:#C2185B
```

**구조**: 각 영역을 노드로, 데이터/프로세스 흐름을 화살표로 연결.
영역 아래에 해당 영역의 대표 이벤트를 서브노드로 배치.

### 3. 타임라인 — `gantt`

```mermaid
gantt
    title {N차} 워크샵 타임라인
    dateFormat HH:mm
    axisFormat %H:%M

    section 준비
    참석자 입장·환경 세팅           :done, 09:00, 10m

    section Phase 1
    이벤트 정제                    :active, 09:10, 20m

    section Phase 2
    애그리게이트 식별               :09:30, 30m

    section 휴식
    Break                         :10:00, 10m

    section Phase 3
    정책 도출                      :10:10, 25m

    section Phase 4
    읽기 모델 도출                  :10:35, 25m

    section 정리
    전체 통합 및 정리               :11:00, 20m
```

**규칙**:
- `dateFormat HH:mm`, `axisFormat %H:%M` 고정
- 각 Phase에 소요 시간 명시
- 휴식 시간 포함
- `done`, `active` 상태는 문맥에 맞게

### 4. 애그리게이트 Before/After — `flowchart TB`

```mermaid
flowchart TB
    subgraph before["❌ Before (오분류/미정제)"]
        B1["기존 라벨 1"]:::wrong
        B2["기존 라벨 2"]:::wrong
    end

    subgraph after["✅ After (정제 후)"]
        A1["새 애그리게이트 1"]:::aggregate
        A2["새 애그리게이트 2"]:::newAgg
    end

    B1 -.->|"통합"| A1
    B2 -.->|"재분류"| A1
```

**필수 요소**: before/after subgraph, 오분류→정제 화살표

### 5. 영역별 매핑 — `flowchart TB` + subgraph

```mermaid
flowchart TB
    subgraph area1["① 영역1"]
        AG1["애그리게이트1"]:::aggregate
        E1["이벤트1"]:::event
        E2["이벤트2"]:::event
        AG1 --- E1
        AG1 --- E2
    end

    subgraph area2["② 영역2"]
        AG2["애그리게이트2"]:::aggregate
        E3["이벤트3"]:::event
        AG2 --- E3
    end
```

**구조**: 영역별 subgraph → 내부에 애그리게이트+이벤트 매핑

### 6. 정책 후보 맵 — `flowchart LR`

```mermaid
flowchart LR
    E1["트리거 이벤트"]:::event --> P1["정책명"]:::policy --> E2["결과 이벤트"]:::event
    E3["트리거 이벤트"]:::event --> P2["정책명"]:::policy --> C1["결과 커맨드"]:::command
```

**구조**: `이벤트 → 정책 → 이벤트/커맨드` 체인

### 7. 핫스팟/정책 전환 또는 정책-이벤트 연결 — `flowchart TB` 또는 `flowchart LR`

차수에 따라 다이어그램 내용이 달라짐:

**2차 (정책-이벤트 연결):**
```mermaid
flowchart LR
    E1["이벤트"]:::event --> P1["정책"]:::policy
    P1 --> C1["결과 커맨드"]:::command
    C1 --> E2["후속 이벤트"]:::event
```

**3차+ (핫스팟→정책 전환):**
```mermaid
flowchart TB
    H1["🩷 핫스팟: 문제상황"]:::hotspot
    H1 -->|"정책으로 전환"| P1["💜 정책: 자동화 규칙"]:::policy
    P1 --> R1["결과/효과"]:::result
```

### 8. 읽기모델 후보 — `flowchart TB`

```mermaid
flowchart TB
    subgraph customer["👤 고객/사용자 화면"]
        RM1["읽기모델1"]:::readmodel
        RM2["읽기모델2"]:::readmodel
    end

    subgraph operator["🔧 운영자/관리자 화면"]
        RM3["읽기모델3"]:::readmodel
        RM4["읽기모델4"]:::readmodel
    end
```

**구조**: 용도별(고객/운영자) subgraph로 분류

### 9. 읽기모델-이벤트 연결 — `flowchart LR`

```mermaid
flowchart LR
    E1["이벤트1"]:::event --> RM1["읽기모델1"]:::readmodel
    E2["이벤트2"]:::event --> RM1
    C1["커맨드1"]:::command --> E1
```

**구조**: 이벤트/커맨드 → 읽기모델 데이터 흐름

### 10. 전체 통합 — `flowchart LR` + subgraph

```mermaid
flowchart LR
    subgraph area1["① 영역1"]
        C1["커맨드"]:::command --> E1["이벤트"]:::event
        E1 --> AG1["애그리게이트"]:::aggregate
    end

    subgraph area2["② 영역2"]
        E1 -->|"정책"| P1["정책"]:::policy
        P1 --> E2["이벤트"]:::event
        E2 --> RM1["읽기모델"]:::readmodel
    end

    EXT1["외부시스템"]:::external -.-> E1
```

**필수 요소**: 모든 요소 유형(이벤트, 커맨드, 애그리게이트, 정책, 읽기모델, 외부시스템)이 하나 이상 포함

## 렌더링 옵션

mermaid-cli 렌더링 시 표준 옵션:
- **width**: 1200px
- **background**: white
- **quality**: (기본값, -q 플래그로 quiet 모드)

```bash
npx -y @mermaid-js/mermaid-cli -i input.mmd -o output.png -w 1200 -b white -q
```
