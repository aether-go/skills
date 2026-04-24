---
name: improvement-budget-allocator
description: Use when allocating improvement budget across business delivery, tech debt repayment, and experimental improvements following 70/20/10 rule
---

# Improvement Budget Allocator

## Overview
Allocate improvement budget across three categories following the 70/20/10 rule: (1) Business delivery (70%), (2) Technical debt repayment (20%), (3) Experimental improvements (10%). Implements P9: Recursive Self-Optimization Principle for sustainable演进.

## When to Use

```
Iteration planning? ───────────────────────────┐
                                              │
Resource allocation needed? ───────────────────┤
                                              ├─► Use improvement-budget-allocator
Continuous improvement mode? ──────────────────┤
                                              │
Tech debt management? ────────────────────────┘
```

Use when:
- Planning iteration resources
- Managing technical debt alongside features
- Balancing delivery vs improvement
- Implementing continuous improvement

## Core Pattern

### Budget Allocation Model

```
Total Iteration Capacity
    │
    ├── 70%: Business Delivery
    │     ├── Feature development
    │     ├── Bug fixes
    │     └── Customer requirements
    │
    ├── 20%: Technical Debt Repayment
    │     ├── Code refactoring
    │     ├── Test coverage improvement
    │     ├── Documentation updates
    │     └── Dependency updates
    │
    └── 10%: Experimental Improvements
          ├── Proof of concepts
          ├── Performance optimizations
          ├── New tool evaluation
          └── Innovation time
```

### Decision Matrix

| Business Value | Tech Debt | Recommended Action |
|----------------|-----------|-------------------|
| High | High | Immediate refactor |
| High | Low | Proceed with feature |
| Low | High | Evaluate deletion |
| Low | Low | Maintain status quo |

## Integration with Aether.go Methodology

- **Input from**: recursive-optimizer (improvement suggestions)
- **Output to**: ChangeAndTaskAgent (task prioritization)
- **Part of**: D7 Evolution Optimization Domain (P9-P10)
