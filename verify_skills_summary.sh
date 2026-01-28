#!/bin/bash
echo "=== Gap Analysis Verification ==="
grep -A3 "识别出的关键缺口" SKILLS_SUMMARY.md

echo -e "\n=== Skill Count Verification ==="
grep -n "个技能" SKILLS_SUMMARY.md | head -5

echo -e "\n=== Workflow Diagram Check ==="
sed -n '308,322p' SKILLS_SUMMARY.md

echo -e "\n=== Last Updated Check ==="
grep "最后更新" SKILLS_SUMMARY.md