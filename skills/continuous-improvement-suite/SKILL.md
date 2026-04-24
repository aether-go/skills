---
name: continuous-improvement-suite
description: Use when executing continuous improvement workflows with budget allocation (70/20/10), technical debt management, and RecursiveOptimizer integration for iterative optimization
---

# Continuous Improvement Suite

## Overview
Execute continuous improvement workflow following 70/20/10 budget allocation rule: 70% for maintenance, 20% for improvements, 10% for innovation. Integrates with RecursiveOptimizer to maintain convergence while continuously improving system quality, managing technical debt, and optimizing skill assets.

## When to Use

```
Scenario detected: continuous_improvement? ──────┐
                                                  │
System in production maintenance mode? ───────────┤
                                                  ├─► Use continuous-improvement-suite
Iterative optimization needed? ───────────────────┤
                                                  │
Technical debt accumulation noticed? ──────────────┘
```

Use when:
- scenario-detector identifies "continuous_improvement" mode
- System is in production maintenance phase
- Need to balance maintenance vs improvement vs innovation
- Technical debt needs systematic management
- RecursiveOptimizer tasks need coordination

## Core Pattern

### 70/20/10 Budget Allocation

```
Total Improvement Budget
    │
    ├── 70% ──→ Maintenance & Reliability
    │     ├── Bug fixes and patches
    │     ├── Performance optimization
    │     ├── Security updates
    │     └── Technical debt repayment
    │
    ├── 20% ──→ Improvements & Enhancements
    │     ├── Feature enhancements
    │     ├── UX improvements
    │     ├── Developer experience
    │     └── Process automation
    │
    └── 10% ──→ Innovation & Experimentation
          ├── New technology evaluation
          ├── Proof of concepts
          ├── Architecture experiments
          └── Skill development
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

### Key Artifacts

| Artifact | Purpose |
|----------|---------|
| Budget Allocation Report | 70/20/10 distribution with rationale |
| Tech Debt Registry | Prioritized debt items with effort estimates |
| Improvement Backlog | Prioritized improvement candidates |
| Convergence State | Current optimization convergence status |

## Budget Allocation Rules

| Category | Allocation | Focus Areas | Success Metrics |
|----------|------------|-------------|-----------------|
| **Maintenance (70%)** | Core operations | Bug fixes, patches, debt repayment | Stability, uptime, reduced incidents |
| **Improvements (20%)** | Enhancements | Features, UX, DX, automation | User satisfaction, developer velocity |
| **Innovation (10%)** | Experiments | POC, new tech, architecture | Learning, discovered opportunities |

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
ContinuousImprovementSuite
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

- **Input from**: scenario-detector (mode: continuous_improvement), tech-debt-quantifier, improvement-budget-allocator
- **Output to**: recursive-optimizer (optimization tasks), change-and-task-agent (execution)
- **Coordinates with**: skill-lifecycle-manager (skill improvements), convergence-checker (convergence state)
- **Part of**: D6 Scenario Adaptation Domain, D7 Evolution Optimization Domain

## Quality Gates

- Budget allocation MUST follow 70/20/10 rule (with documented deviation)
- Convergence check MUST pass before concluding improvement cycle
- Tech debt items MUST have priority and interest cost estimated
- Improvement results MUST be measured against baseline metrics
