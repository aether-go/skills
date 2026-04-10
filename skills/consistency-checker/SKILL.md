---
name: consistency-checker
description: Use when verifying cross-layer and cross-domain consistency in multi-tier architectures. Part of the skeptic skill layer for ensuring consistency across the five-layer derivation model.
---

# Consistency Checker

## Overview

Verify cross-layer and cross-domain consistency in multi-tier architectures. This skill ensures that content at different layers of the derivation model (L1-L5) maintains consistency with each other.

**Implements**: Cross-layer and cross-domain consistency verification

**Part of**: Skeptic Skill Layer

**Applies to**: Five-layer derivation model

## When to Use

Use when:
- Verifying business goals align with technical implementation
- Checking if acceptance criteria match system specifications
- Ensuring interface contracts are consistent with requirements
- Detecting requirement drift over time

## Core Pattern

### Consistency Verification Dimensions

- Business-Technical Alignment (L1-L2)
- Spec-Implementation Match (L2-L3-L4)
- Interface-Contract Consistency (L4-L5)
- Cross-Layer Traceability

## Verification Process

1. Business-Technical Alignment (L1-L2)
2. Specification-Implementation Match (L2-L3-L4)
3. Interface-Contract Consistency (L4-L5)
4. Cross-Layer Traceability Matrix

## Output Format

```yaml
consistency_report:
  content_id: "project-auth-system"
  layer_consistency:
    l1_to_l2:
      status: "PASS"
      consistency_score: 0.90
  overall_assessment:
    consistency_score: 0.85
    status: "CONDITIONAL_PASS"
```

## Quality Metrics

| Metric | Target |
|--------|--------|
| Consistency Detection Rate | > 95% |
| False Positive Rate | < 10% |
| Traceability Coverage | > 90% |
| Cross-Layer Coverage | 100% |

## Related Skills

- **correctness-checker**: Verify factual correctness
- **completeness-checker**: Verify comprehensive coverage
- **boundedness-checker**: Ensure bounded verification scope