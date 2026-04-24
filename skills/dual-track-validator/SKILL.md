---
name: dual-track-validator
description: Use when migrating between technology stacks with parallel verification ensuring behavioral equivalence between old and new systems
---

# Dual Track Validator

## Overview
Execute dual-track validation workflow for technology stack migration (e.g., PHP→Go, Java→Rust). Runs old and new systems in parallel, validating behavioral equivalence through shadow traffic testing before completing migration. Implements "behavioral equivalence principle" as temporary constitution.

## When to Use

```
Scenario detected: language_migration? ────────┐
                                              │
Technology stack replacement? ────────────────┤
                                              ├─► Use dual-track-validator
Behavioral equivalence required? ─────────────┤
                                              │
Parallel execution needed? ────────────────────┘
```

Use when:
- scenario-detector identifies "language_migration" mode
- Complete technology stack replacement
- Zero-downtime migration required
- Behavioral equivalence is mandatory

## Core Pattern

### Dual Track Process

```
Phase 1: Specification Extraction
    ├── Static analysis → Domain models
    ├── Dynamic analysis → I/O mappings
    └── Generate "behavioral equivalence spec"

Phase 2: New System Implementation
    └── Standard SDD workflow
        └── Spec from Phase 1

Phase 3: Equivalence Validation
    ├── Shadow traffic testing
    ├── State equivalence checking
    └── Performance regression testing

Phase 4: Gradual Switchover
    ├── Canary release (1%→10%→50%→100%)
    ├── Real-time monitoring
    └── Instant rollback capability
```

### Temporary Constitution

| Original Principle | Adjustment |
|--------------------|-------------|
| P4 Interface-First | New system maintains old interfaces |
| P6 Test-First | Characterization tests lock behavior |
| New: Equivalence Validation | Shadow traffic must pass before switch |

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: language_migration)
- **Output to**: Deployment orchestration
- **Part of**: D6 Scenario Adaptation Domain
