---
name: poc-exemption-manager
description: Use when managing constitution principle exemptions for proof-of-concept projects with rapid validation focus
---

# POC Exemption Manager

## Overview
Manage constitution principle exemptions for Proof-of-Concept (POC) projects. POC mode prioritizes speed and learning over process rigor. Tracks exemptions granted, validation relaxed, and manages POC→正式项目 transition.

## When to Use

```
Scenario detected: poc? ───────────────────────┐
                                              │
Exploring new technology/approach? ────────────┤
                                              ├─► Use poc-exemption-manager
Rapid validation needed? ──────────────────────┤
                                              │
Result might be "not feasible"? ──────────────┘
```

Use when:
- scenario-detector identifies "poc" mode
- Validating new technology or approach
- High uncertainty, rapid iteration
- Results may indicate infeasibility

## Core Pattern

### Exemption Matrix

| Principle | Exemption Level | Rationale |
|-----------|-----------------|-----------|
| P2 Planning-Driven | Full exemption | Cannot plan unknowns |
| P4 Interface-First | Full exemption | Interfaces emerge from exploration |
| P6 Test-First | Partial exemption | Manual validation allowed |
| P3 Modular | Partial exemption | Temporary coupling acceptable |

### POC Lifecycle

```
Phase 1: POC Execution (Exemptions Active)
    └── Rapid prototyping, manual testing
    
Phase 2: POC Evaluation
    ├── Success → Proceed to formal project
    └── Failure → Document learnings, stop
    
Phase 3: Transition (Exemptions Removed)
    ├── Extract stable specifications
    ├── Apply standard workflow
    └── Asset knowledge to skill library
```

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: poc)
- **Output to**: constitution-guardian (exemption tracking)
- **Part of**: D6 Scenario Adaptation Domain
