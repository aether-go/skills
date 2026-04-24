---
name: tech-debt-quantifier
description: Use when quantifying and cataloging technical debt with impact analysis for prioritization in improvement planning
---

# Tech Debt Quantifier

## Overview
Quantify and catalog technical debt across codebase with impact analysis. Provides sortable debt清单 for prioritization in improvement planning. Supports P9: Recursive Self-Optimization by enabling data-driven debt management decisions.

## When to Use

```
Tech debt assessment? ─────────────────────────┐
                                              │
Improvement planning? ─────────────────────────┤
                                              ├─► Use tech-debt-quantifier
Debt impact analysis needed? ──────────────────┤
                                              │
Prioritization decisions? ─────────────────────┘
```

Use when:
- Assessing overall technical debt
- Planning improvement iterations
- Justifying refactoring investments
- Tracking debt over time

## Core Pattern

### Debt Categories

```
Technical Debt
    │
    ├── Code Debt
    │     ├── Duplication
    │     ├── Complexity
    │     ├── Naming
    │     └── Comment debt
    │
    ├── Design Debt
    │     ├── Architecture misalignment
    │     ├── Missing abstractions
    │     └── Coupling
    │
    ├── Test Debt
    │     ├── Missing tests
    │     ├── Brittle tests
    │     └── Low coverage
    │
    └── Documentation Debt
          ├── Missing docs
          ├── Outdated docs
          └── API documentation
```

### Quantification Model

```
Debt Impact Score = Σ(extent × severity × remediation_cost)

Where:
- extent: How widespread (files, modules affected)
- severity: How critical (bug risk, maintenance burden)
- remediation_cost: Effort to fix (person-hours)
```

## Integration with Aether.go Methodology

- **Input from**: context-manager (code analysis)
- **Output to**: improvement-budget-allocator (budget planning)
- **Part of**: D7 Evolution Optimization Domain (P9-P10)
