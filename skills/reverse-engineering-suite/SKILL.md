---
name: reverse-engineering-suite
description: Use when extracting specifications and architecture from legacy systems for L1 derivation in brownfield projects with reduced planning principle
---

# Reverse Engineering Suite

## Overview
Execute reverse engineering workflow to extract specifications, architecture, and domain knowledge from existing legacy systems. Used in brownfield projects where understanding the current system precedes any modifications. Triggers P2 (Planning-Driven) and P4 (Interface-First) exemptions for legacy portions.

## When to Use

```
Scenario detected: reverse_engineering? ────────┐
                                              │
Legacy system requiring modification? ─────────┤
                                              ├─► Use reverse-engineering-suite
No existing documentation? ────────────────────┤
                                              │
Understanding current behavior? ───────────────┘
```

Use when:
- scenario-detector identifies "reverse_engineering" mode
- Legacy system needs modification without rewriting
- Documentation is missing or outdated
- Need to understand system behavior before changing

## Core Pattern

### Reverse Engineering Process

```
Stage 0: Reverse Engineering (NEW)
    │
    ├── Static Analysis
    │     ├── Extract domain models
    │     ├── Extract interface definitions
    │     └── Extract data flows
    │
    ├── Dynamic Analysis
    │     ├── Capture runtime behavior
    │     ├── Identify key workflows
    │     └── Map system boundaries
    │
    └── Characterization Tests
          ├── Lock existing behavior
          ├── Create regression suite
          └── Enable safe modification

Subsequent Stages: Standard workflow
    └── New features follow standard mode
```

### Principle Exemptions

| Principle | Exemption | Rationale |
|-----------|-----------|-----------|
| P2 Planning-Driven | Reduced for legacy | Cannot plan unknown |
| P4 Interface-First | N/A for legacy | Interfaces already exist |
| P5 Occam's Razor | Document existing | Cannot remove legacy deps |

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: reverse_engineering)
- **Output to**: Standard workflow stages for new features
- **Part of**: D6 Scenario Adaptation Domain
