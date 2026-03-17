---
name: workshop-prep
description: >
  이벤트 스토밍 워크샵 준비 가이드 문서를 작성한다.
  팀명, 차수, draw.io 분석 결과를 입력받아
  mermaid 다이어그램 10개 + 본문 마크다운 문서를 생성한다.
  "워크샵 준비", "워크샵 문서", "이벤트스토밍 가이드" 등의 요청 시 사용한다.
disable-model-invocation: true
argument-hint: "[팀명] [N차] [draw.io분석 또는 파일경로]"
allowed-tools: Read, Write, Edit, Bash, Glob, Grep, Agent
---

# 이벤트 스토밍 워크샵 준비 가이드 작성 스킬

## 입력 파라미터

`$ARGUMENTS`에서 다음을 파싱한다:
- **팀명**: 한글 팀명 (예: 검색서비스팀, 주문서비스팀)
- **N차**: 워크샵 차수 (예: 2차, 3차)
- **draw.io 분석 또는 파일경로**: draw.io 분석 결과 텍스트 또는 `.drawio` 파일 경로

파싱 규칙:
- 첫 번째 인자: 팀명 (한글 포함)
- 두 번째 인자: N차 (숫자+차)
- 나머지: draw.io 파일 경로 또는 분석 결과

## 출력 파일

- **문서**: `이벤트스토밍_{팀명}_{N차}워크샵준비.md`
- **이미지 디렉토리**: `images/{팀명}_{N차}/`
- **이미지 파일**: `diagram_01_현황요약.png` ~ `diagram_10_전체통합흐름.png`

## 5단계 워크플로우

### Step 1: draw.io 분석

`.drawio` 파일 경로가 제공된 경우:
- `analyze-drawio` 스킬의 색상 매핑 로직을 참조하여 요소를 추출한다
- `.claude/skills/analyze-drawio/references/color-mapping.md` 읽기

텍스트 분석 결과가 제공된 경우:
- 제공된 분석 결과에서 요소 유형별 목록과 개수를 파악한다

**필수 추출 정보:**
- 이벤트 목록 및 개수
- 커맨드 목록 및 개수
- 애그리게이트(라벨) 목록 및 개수
- 핫스팟 목록 및 개수
- 외부 시스템 목록 및 개수
- 정책 목록 및 개수 (있는 경우)
- 읽기 모델 목록 및 개수 (있는 경우)
- 흐름 영역 수 및 이름
- 오분류 의심 항목

### Step 2: 참조 문서 읽기

다음 문서들을 확인한다:

1. **팀별 가이드**: `이벤트스토밍_{팀명}_가이드.md` — 팀 특화 도전 과제, 판단 기준
2. **팀별 도메인 예시**: `이벤트스토밍_{팀명}_도메인예시.md` (있는 경우) — 도메인별 이벤트 예시
3. **팀별 워크샵 실행**: `이벤트스토밍_{팀명}_워크샵실행.md` (있는 경우) — 퍼실리테이터 스크립트
4. **읽기모델 가이드**: `이벤트스토밍_읽기모델_가이드.md` — 읽기모델 3단계 프로세스
5. **시각화 가이드**: `이벤트스토밍_시각화_가이드.md` — 포스트잇 색상·배치 패턴

이전 차수 문서가 있으면 함께 확인:
- `이벤트스토밍_{팀명}_{N-1차}워크샵준비.md`

### Step 3: Mermaid 다이어그램 10개 작성

`.claude/skills/workshop-prep/references/mermaid-styles.md`를 참조하여 다이어그램 10개를 작성한다.

각 다이어그램을 `.mmd` 파일로 이미지 디렉토리에 저장:
```
images/{팀명}_{N차}/diagram_01_현황요약.mmd
images/{팀명}_{N차}/diagram_02_흐름영역맵.mmd
...
images/{팀명}_{N차}/diagram_10_전체통합흐름.mmd
```

렌더링:
```bash
bash .claude/skills/workshop-prep/scripts/render-diagrams.sh images/{팀명}_{N차}/
```

**다이어그램 10종 목록:**

| # | 파일명 | 타입 | 내용 |
|---|--------|------|------|
| 1 | `diagram_01_현황요약` | `pie` | 이전 차수 도출 요소 현황 |
| 2 | `diagram_02_흐름영역맵` | `flowchart LR` | 흐름 영역 전체 맵 |
| 3 | `diagram_03_타임라인` | `gantt` | 워크샵 타임라인 |
| 4 | `diagram_04_애그리게이트_비포애프터` | `flowchart TB` | 애그리게이트 Before/After |
| 5 | `diagram_05_영역별매핑` | `flowchart TB` + subgraph | 영역별 애그리게이트-이벤트 매핑 |
| 6 | `diagram_06_정책후보맵` | `flowchart LR` | 정책 후보 맵 |
| 7 | `diagram_07_핫스팟정책전환` 또는 `정책이벤트연결` | `flowchart TB/LR` | 핫스팟→정책 전환 또는 정책-이벤트 연결 |
| 8 | `diagram_08_읽기모델후보` | `flowchart TB` | 읽기 모델 후보 목록 |
| 9 | `diagram_09_읽기모델이벤트연결` | `flowchart LR` | 읽기모델-이벤트 연결 맵 |
| 10 | `diagram_10_전체통합흐름` | `flowchart LR` + subgraph | 전체 요소 통합 흐름 |

### Step 4: 본문 작성

`.claude/skills/workshop-prep/references/document-structure.md`의 10개 섹션 구조를 따른다.
`.claude/skills/workshop-prep/references/formatting-guide.md`의 포맷팅 규칙을 준수한다.

**문서 제목**: `# {팀명 (띄어쓰기)} 이벤트 스토밍 {N차} 워크샵 준비 가이드`

각 다이어그램은 다음 패턴으로 삽입:
```markdown
![다이어그램 제목](./images/{팀명}_{N차}/diagram_XX_이름.png)

<details>
<summary>📊 원본 Mermaid 코드 보기</summary>

```mermaid
(mermaid 코드)
```

</details>
```

**차수별 분기 로직:**

| 차수 | 이전 결과 참조 | Phase 특성 |
|------|--------------|-----------|
| 2차 | 1차 결과 | 이벤트 정제 + 애그리게이트 + 정책 + 읽기모델 |
| 3차 | 1~2차 결과 | 정제 강화 + 오분류 교정 + BC 프리뷰 강조 |
| 4차+ | 이전 전체 | BC 확정 + 컨텍스트 맵 |

### Step 5: 검증

`workshop-review` 스킬의 체크리스트를 참조하여 자가 검증한다:
- 이미지 10개 존재 확인
- 이미지 참조 경로 매칭
- details 태그 10개 확인
- 필수 섹션 10개 확인
- 포맷팅 규칙 준수 확인

## 중요 규칙

1. **퍼실리테이터 관점**: 문서는 퍼실리테이터가 워크샵 중 바로 참조할 수 있도록 실용적으로 작성
2. **팀 맥락 반영**: 팀별 가이드에서 추출한 도메인 특화 비유/설명을 활용
3. **구체적 수치**: draw.io 분석 결과의 실제 수치를 사용 (예: "40개 → ~30개")
4. **실행 가능한 스크립트**: 퍼실리테이터 스크립트는 대화체로, 바로 읽을 수 있는 형태
5. **일관된 포맷**: 기존 문서(검색서비스팀 2차, 주문서비스팀 3차)와 동일한 스타일 유지
