---
name: correctness-checker
description: Use when verifying the factual accuracy, logical consistency, and validity of content against reference standards. Part of the skeptic skill layer for ensuring AI-generated content correctness.
---

# Correctness Checker

## Overview

Verify the factual accuracy, logical consistency, and validity of content against reference standards. This skill is part of the skeptic skill layer designed to ensure AI-generated content meets correctness standards before being used downstream.

**Implements**: Correctness verification for AI-generated content

**Part of**: Skeptic Skill Layer

## When to Use

Use when:
- Verifying business requirement accuracy
- Checking technical implementation correctness
- Validating logical consistency of generated content
- Confirming reference citations are accurate
- Pre-approval validation before content passes to next stage

## Core Pattern

### Correctness Verification Dimensions

- Factual Accuracy
- Logical Consistency  
- Reference Validity
- Conclusion Support

## Verification Process

1. Factual Accuracy Check
2. Logical Consistency Check
3. Reference Validity Check
4. Conclusion Support Check

## Output Format

```yaml
correctness_report:
  content_id: "req-auth-001"
  verification_results:
    factual_accuracy:
      status: "PASS"
      score: 0.92
    logical_consistency:
      status: "PASS"
      score: 0.95
  overall_assessment:
    status: "CONDITIONAL_PASS"
    confidence_score: 0.87
```

## Quality Metrics

| Metric | Target |
|--------|--------|
| False Positive Rate | < 5% |
| False Negative Rate | < 10% |
| Verification Coverage | > 95% |
| Processing Time | < 30s per page |

## Related Skills

- **completeness-checker**: Check if all required elements are present
- **consistency-checker**: Verify cross-layer and cross-domain consistency
- **boundedness-checker**: Ensure optimization changes are bounded