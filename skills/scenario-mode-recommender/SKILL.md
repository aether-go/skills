---
name: scenario-mode-recommender
description: Use when recommending optimal scenario mode with confidence scoring and derivation parameter output for complex project situations
---

# Scenario Mode Recommender

## Overview
Recommend optimal scenario mode with confidence scoring and detailed reasoning. Unlike scenario-mode-selector, this skill outputs derivation parameters (L1→L2 decomposition depth, P2 completeness threshold, P6 test coverage threshold) needed by ConstitutionGuardian for dynamic principle weighting.

## When to Use

```
Project situation complex? ───────────────────┐
                                              │
Need derivation parameters? ───────────────────┤
                                              ├─► Use scenario-mode-recommender
Multi-factor decision needed? ────────────────┤
                                              │
Confidence scoring required? ──────────────────┘
```

Use when:
- Complex project with multiple scenario indicators
- Need specific derivation parameters for constitution-guardian
- High-stakes scenario selection
- Need confidence scoring for recommendation

## Core Pattern

### Recommendation Output

```yaml
recommendation:
  mode: "reverse_engineering"
  confidence: 0.87
  reasoning:
    - factor: "legacy_codebase"
      weight: 0.4
      evidence: "15 year old PHP system, no documentation"
    - factor: "migration_requirement"
      weight: 0.3
      evidence: "Must migrate to Go within 12 months"
      
  derivation_parameters:
    l1_l2_depth: "comprehensive"  # vs "abbreviated"
    p2_completeness_threshold: 0.7  # vs 1.0
    p6_test_coverage_threshold: 0.5  # vs 0.9
    
  principle_adjustments:
    P2: {mode: "reduced", threshold: 0.7}
    P4: {mode: "n_a_legacy"}
    P5: {mode: "document_existing"}
```

## Integration with Aether.go Methodology

- **Input from**: business-requirements-collector, context-manager
- **Output to**: ConstitutionGuardian (dynamic principle weighting)
- **Part of**: D8 Meta-Capability Domain
