---
name: boundedness-checker
description: Use when verifying that optimization changes, iterative improvements, and refactoring operations stay within defined boundaries. Part of the skeptic skill layer for preventing runaway optimizations and ensuring bounded convergence.
---

# Boundedness Checker

## Overview

Verify that optimization changes, iterative improvements, and refactoring operations stay within defined boundaries. This skill is part of the skeptic skill layer designed to prevent runaway optimizations and ensure bounded convergence.

**Implements**: Boundedness verification for optimization and iterative improvement

**Part of**: Skeptic Skill Layer

**Related to**: P9 Recursive Self-Optimization Principle

## When to Use

Use when:
- Verifying optimization changes stay within scope
- Checking iteration counts against limits
- Preventing runaway refactoring
- Validating convergence conditions

## Core Pattern

### Boundedness Verification Dimensions

- Change Magnitude
- Iteration Count
- Quality Bounds
- Scope Constraints

## Verification Process

1. Change Magnitude Verification
2. Iteration Count Verification
3. Quality Bounds Verification
4. Convergence Condition Evaluation

## Output Format

```yaml
boundedness_report:
  optimization_id: "opt-skill-tdd-001"
  boundedness_checks:
    change_magnitude:
      status: "CONDITIONAL_PASS"
      violations: 1
    quality_bounds:
      status: "PASS"
  convergence_evaluation:
    verdict: "CONVERGED"
    confidence: 0.95
```

## Quality Metrics

| Metric | Target |
|--------|--------|
| Bound Violation Rate | < 5% |
| Convergence Accuracy | > 90% |
| Early Termination | < 10% |
| Quality Degradation | 0% |

## Related Skills

- **correctness-checker**: Verify factual correctness
- **completeness-checker**: Verify comprehensive coverage
- **consistency-checker**: Verify cross-layer consistency
- **recursive-optimizer**: Implements the optimization logic