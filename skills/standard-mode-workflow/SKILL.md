---
name: standard-mode-workflow
description: Use when executing the standard Aether workflow for greenfield projects with complete five-layer derivation and full constitution principle enforcement
---

# Standard Mode Workflow

## Overview
Execute the standard Aether methodology workflow for greenfield projects. This workflow enforces complete five-layer derivation (L1→L5) with full constitution principles (P0-P10) compliance. Used when project is new, requirements are clear, and no special scenario adaptations are needed.

## When to Use

```
Scenario detected: standard? ─────────────────┐
                                              │
New greenfield project? ───────────────────────┤
                                              ├─► Use standard-mode-workflow
Full methodology required? ────────────────────┤
                                              │
No exemptions applicable? ─────────────────────┘
```

Use when:
- scenario-detector identifies "standard" mode
- Greenfield project with clear requirements
- Full P0-P10 constitution enforcement needed
- Team has capacity for complete workflow

## Core Pattern

### Standard Workflow Stages

```
Stage 0: (Optional) Initial setup
Stage 1: Business Analysis (L1→L2)
    └── value-decomposer → functional requirements
Stage 2: Specification Definition (L2→L3)
    └── spec-to-scenario → GWT acceptance criteria
Stage 3: Constitution Review (P0-P10)
    └── constitution-validator → compliance report
Stage 4: Implementation Planning (L3→L4)
    └── test-pyramid-deriver → test stratification
Stage 5: Code Generation (L4→L5)
    └── tdd-cycle-runner → implementation
Stage 6: Integration Validation
    └── e2e-test-generator + integration-test-generator
Stage 7: Deployment
    └── deployment-orchestrator
Stage 8: Recursive Optimization
    └── recursive-optimizer
```

### Constitution Enforcement

| Principle | Stage | Enforcement |
|----------|-------|-------------|
| P0 Context-Adaptation | All | Active |
| P1 Purpose-Driven | Stage 1 | Strict |
| P2 Planning-Driven | Stage 1-2 | Strict |
| P3 Modular | Stage 4 | Strict |
| P4 Interface-First | Stage 4 | Strict |
| P5 Occam's Razor | Stage 4 | Warning |
| P6 Test-First | Stage 5 | Strict |
| P7 Context-First | Stage 5 | Strict |
| P8 Human-AI Boundary | Stage 3,6 | Strict |
| P9 Recursive Optimization | Stage 8 | Active |
| P10 Skill Asset | Stage 8 | Active |

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: standard)
- **Output to**: All D1-D5 derivation skills
- **Managed by**: WorkflowOrchestrator
- **Part of**: D6 Scenario Adaptation Domain
