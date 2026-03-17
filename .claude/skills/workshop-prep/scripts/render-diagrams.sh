#!/bin/bash
# render-diagrams.sh — .mmd 파일을 PNG로 일괄 렌더링 후 .mmd 삭제
#
# Usage: render-diagrams.sh <mmd-directory>
# Example: bash .claude/skills/workshop-prep/scripts/render-diagrams.sh images/검색서비스팀_2차/

set -euo pipefail

DIR="${1:-.}"

if [ ! -d "$DIR" ]; then
    echo "Error: 디렉토리가 존재하지 않습니다: $DIR"
    exit 1
fi

# .mmd 파일이 있는지 확인
shopt -s nullglob
files=("$DIR"/*.mmd)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
    echo "Warning: $DIR 디렉토리에 .mmd 파일이 없습니다."
    exit 0
fi

echo "=== Mermaid 다이어그램 렌더링 시작 ==="
echo "디렉토리: $DIR"
echo "대상 파일: ${#files[@]}개"
echo ""

success=0
fail=0

for f in "${files[@]}"; do
    out="${f%.mmd}.png"
    basename_f=$(basename "$f")
    echo -n "렌더링: $basename_f ... "

    if npx -y @mermaid-js/mermaid-cli -i "$f" -o "$out" -w 1200 -b white -q 2>/dev/null; then
        echo "✅"
        ((success++))
    else
        echo "❌ 실패"
        ((fail++))
    fi
done

# 성공한 .mmd 파일만 삭제
if [ $success -gt 0 ]; then
    for f in "${files[@]}"; do
        out="${f%.mmd}.png"
        if [ -f "$out" ]; then
            rm -f "$f"
        fi
    done
fi

echo ""
echo "=== 렌더링 완료 ==="
echo "성공: ${success}개, 실패: ${fail}개"
echo "PNG 파일:"
ls -1 "$DIR"/*.png 2>/dev/null || echo "(없음)"
