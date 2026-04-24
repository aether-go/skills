---
name: improvement-budget-allocator
description: Use when allocating improvement budget following 70/20/10 rule and executing continuous improvement workflows with technical debt management and RecursiveOptimizer integration (merged with continuous-improvement-suite)
---

# Improvement Budget Allocator

## Overview
Allocate improvement budget across three categories following the 70/20/10 rule and execute continuous improvement workflows. Combines budget allocation with technical debt management, RecursiveOptimizer integration, and iterative optimization cycle. Implements P9: Recursive Self-Optimization Principle for sustainable演进.

**Note**: This skill has merged with continuous-improvement-suite capabilities.

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
- scenario-detector identifies "continuous_improvement" mode
- RecursiveOptimizer tasks need coordination

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

### Continuous Improvement Cycle

```
Improvement Budget Allocated (70/20/10)
    │
    ├── Identify Improvement Opportunities
    │     ├── Tech debt quantification
    │     ├── Performance bottlenecks
    │     ├── Skill gaps analysis
    │     └── User feedback synthesis
    │
    ├── Prioritize Using RecursiveOptimizer
    │     ├── Pareto frontier calculation
    │     ├── Convergence detection
    │     ├── Boundedness verification
    │     └── Multi-objective optimization
    │
    ├── Execute Improvement Tasks
    │     ├── /opsx-ff: Fast feedback phase
    │     └── /opsx-apply: Formal application phase
    │
    ├── Validate Results
    │     ├── Quality metrics improvement
    │     ├── Convergence state update
    │     └── Skill library refresh
    │
    └── Loop Until Converged
```

### Decision Matrix

| Business Value | Tech Debt | Recommended Action |
|----------------|-----------|-------------------|
| High | High | Immediate refactor |
| High | Low | Proceed with feature |
| Low | High | Evaluate deletion |
| Low | Low | Maintain status quo |

### Key Artifacts

| Artifact | Purpose |
|----------|---------|
| Budget Allocation Report | 70/20/10 distribution with rationale |
| Tech Debt Registry | Prioritized debt items with effort estimates |
| Improvement Backlog | Prioritized improvement candidates |
| Convergence State | Current optimization convergence status |

### Budget Reallocation Triggers

| Trigger | Action |
|---------|--------|
| Critical bug surge | Shift 10% from innovation to maintenance |
| Major tech debt blocking | Shift 5% from improvements to debt |
| New opportunity discovered | Shift 5% from maintenance to innovation |
| Convergence reached | Redirect to skill optimization |

## Integration with RecursiveOptimizer

### Linkage Protocol

```
ImprovementBudgetAllocator
    │
    ├── Detects improvement opportunity
    │
    ├── Generates optimization task list
    │
    ├── Submits to RecursiveOptimizer
    │     ├── Quality degradation signals
    │     ├── Convergence state
    │     └── Multi-objective targets
    │
    ├── RecursiveOptimizer computes Pareto frontier
    │
    ├── ChangeAndTaskAgent executes /opsx-ff /opsx-apply
    │
    ├── RecursiveOptimizer verifies convergence
    │
    └── If not converged: Continue loop
```

### Convergence Criteria

| Dimension | Metric | Target |
|-----------|--------|--------|
| **Quality** | Overall quality score | Improving or stable |
| **Debt** | Tech debt ratio | Decreasing |
| **Velocity** | Development throughput | Stable or improving |
| **Coverage** | Skill coverage | Stable or improving |

## Technical Debt Management

### Debt Quantification

```yaml
tech_debt_registry:
  items:
    - id: "TD-001"
      description: "Legacy authentication module"
      category: "code_quality"
      severity: "high"
      effort_hours: 40
      interest_cost: "2 hours/week"
      blocked_features: ["social-login", "mfa"]

    - id: "TD-002"
      description: "Missing integration tests"
      category: "testing"
      severity: "medium"
      effort_hours: 24
      interest_cost: "2 hours/deploy"

  summary:
    total_debt_hours: 64
    monthly_interest: 4 hours
    top_blocked_features: ["social-login", "mfa"]
```

### Debt Prioritization Matrix

| Severity | Interest Cost | Effort | Priority |
|----------|---------------|--------|----------|
| Critical | High | Low | Immediate |
| Critical | High | High | Plan for quarter |
| Medium | Medium | Low | Next sprint |
| Medium | Medium | High | Backlog |
| Low | Low | Any | When capacity |

## Integration with Aether.go Methodology

- **Input from**: recursive-optimizer (improvement suggestions), scenario-detector (mode: continuous_improvement), tech-debt-quantifier
- **Output to**: ChangeAndTaskAgent (task prioritization), recursive-optimizer (optimization tasks)
- **Coordinates with**: skill-lifecycle-manager (skill improvements), convergence-checker (convergence state)
- **Part of**: D7 Evolution Optimization Domain (P9-P10)

## Quality Gates

- Budget allocation MUST follow 70/20/10 rule (with documented deviation)
- Convergence check MUST pass before concluding improvement cycle
- Tech debt items MUST have priority and interest cost estimated
- Improvement results MUST be measured against baseline metrics
