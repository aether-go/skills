---
name: completeness-checker
description: Use when verifying that content includes all required elements, covers all scenarios, and meets completeness criteria. Part of the skeptic skill layer for ensuring AI-generated content comprehensiveness.
---

# Completeness Checker

## Overview

Verify that content includes all required elements, covers all necessary scenarios, and meets defined completeness criteria. This skill is part of the skeptic skill layer designed to ensure AI-generated content is comprehensive before being used downstream.

**Implements**: Completeness verification for AI-generated content

**Part of**: Skeptic Skill Layer

## When to Use

Use when:
- Verifying requirements document completeness
- Checking if all test scenarios are covered
- Ensuring boundary conditions are addressed
- Validating stakeholder coverage
- Pre-approval validation for content completeness

## Core Pattern

### Completeness Verification Dimensions

- Scenario Coverage
- Boundary Conditions
- Stakeholder Coverage
- Exception Handling

## Verification Process

1. Scenario Coverage Analysis
2. Boundary Condition Check
3. Stakeholder Coverage Check
4. Exception Handling Coverage

## Output Format

```yaml
completeness_report:
  content_id: "req-auth-system"
  coverage_analysis:
    scenario_coverage:
      total: 15
      covered: 12
      percentage: 80%
  overall_assessment:
    completeness_score: 0.77
    status: "INCOMPLETE"
```

## Quality Metrics

| Metric | Target |
|--------|--------|
| False Completeness | < 3% |
| Missed Items Rate | < 15% |
| Coverage Consistency | > 90% |
| Processing Time | < 20s per 1000 tokens |

## Related Skills

- **correctness-checker**: Verify factual and logical correctness
- **consistency-checker**: Verify cross-layer consistency
- **boundedness-checker**: Ensure bounded verification scope