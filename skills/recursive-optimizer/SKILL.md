---
name: recursive-optimizer
description: Use when optimizing skills, prompts, and workflows based on execution results and feedback, with convergence guarantees (Lipschitz learning rate). This skill unifies P13 Recursive-Self-Optimization and replaces recursive-optimizer, convergence-checker, improvement-budget-allocator, and tech-debt-quantifier.
---

# Recursive Optimizer

## Overview

The unified skill for recursive self-optimization of the Aether system. This skill:
- Implements the dual-track optimization model (system quality + AI effectiveness)
- Allocates improvement budget using 70/20/10 rule
- Quantifies and prioritizes technical debt
- Validates convergence conditions (boundedness, monotonicity, termination)
- Drives skill library and knowledge engine updates

**Replaces** (consolidated from 4 skills):
- `recursive-optimizer`
- `convergence-checker`
- `improvement-budget-allocator`
- `tech-debt-quantifier`

## When to Use

```
Need to optimize skills / prompts? ──────────┐
                                             │
Allocating improvement budget? ──────────────┤
                                             │
Tracking convergence conditions? ─────────────┼─► Use recursive-optimizer
                                             │
Quantifying technical debt? ─────────────────┤
                                             │
Need dual-track optimization? ───────────────┘
```

## Dual-Track Optimization Model

```
Track 1: System Quality Optimization
    S_{t+1} = S_t + α · ∇Q(S_t)
    where:
    - S_t: System state at time t
    - Q(S): Quality function (coverage, complexity, performance)
    - α: Learning rate (< 2/L, where L is Lipschitz constant)

Track 2: AI Collaboration Effectiveness
    Ctx_{t+1} = Ctx_t + β · ∇E(Ctx_t)
    where:
    - Ctx_t: Context/prompt state
    - E(Ctx): Effectiveness function (pass rate, confidence, token savings)
    - β: Learning rate (< 2/L)

Joint Feedback:
    Check convergence on both tracks
    Adjust meta-parameters (α, β) if needed
```

## Convergence Conditions (P13)

For stable recursive optimization:

| Condition | Formula | Purpose |
|-----------|---------|---------|
| **Boundedness** | ∃M, ∀t: ‖S_t‖ < M | Prevent unbounded growth |
| **Monotonicity** | Q(S_{t+1}) ≥ Q(S_t) − ε | Quality non-decreasing |
| **Termination** | ‖S_{t+1} − S_t‖ < δ or target reached | Stop criteria |

**Learning rate constraint**: α < 2/L, β < 2/L (Lipschitz)

## Improvement Budget (70/20/10)

| Allocation | Purpose | Example |
|------------|---------|---------|
| **70%** | Business feature delivery | New features, customer requests |
| **20%** | Technical debt repayment | Refactoring, dependency updates, test coverage |
| **10%** | Experimental improvements | New patterns, PoC, optimization experiments |

## Skill Lifecycle Integration

```
Create → Validate → Assetize → Apply → Feedback → Optimize → Retire
  │        │          │         │        │          │         │
  ▼        ▼          ▼         ▼        ▼          ▼         ▼
skill    success    skill    task    metrics   this skill  archive
creator   rate    library   exec   collected   (here)
          ≥85%
```

## Input Format

```yaml
optimization_request:
  context: "weekly_review"
  
  # Current metrics
  metrics:
    system_quality:
      test_coverage: 0.78
      avg_cyclomatic_complexity: 8.5
      code_duplication: 0.12
      tech_debt_hours: 240
    ai_effectiveness:
      token_savings_rate: 0.65
      generation_quality_score: 0.87
      first_pass_rate: 0.72
      avg_iteration_cycles: 2.3
  
  # Targets
  targets:
    system_quality:
      test_coverage: 0.85
      avg_cyclomatic_complexity: 6.0
      code_duplication: 0.08
      tech_debt_hours: 100
    ai_effectiveness:
      token_savings_rate: 0.75
      generation_quality_score: 0.92
      first_pass_rate: 0.85
      avg_iteration_cycles: 1.5
  
  # Budget allocation
  budget:
    feature_work: 0.70
    debt_repayment: 0.20
    experimental: 0.10
  
  # Skill candidates for optimization
  skill_candidates:
    - name: "requirement-analyzer"
      success_rate: 0.92
      avg_execution_time: 45
      feedback: "Works well, occasional false positives in classification"
    - name: "test-planner"
      success_rate: 0.78  # Below 85% threshold
      avg_execution_time: 120
      feedback: "Chaos experiment generation has edge cases"
  
  # Convergence state
  convergence:
    last_iteration: 12
    quality_delta: 0.02
    iterations_since_improvement: 1
```

## Output Format

```yaml
optimization_result:
  context: "weekly_review"
  timestamp: "2026-06-02T10:00:00Z"
  
  # Budget allocation
  budget_plan:
    total_capacity: 100  # person-hours/week
    allocations:
      feature_work: {hours: 70, percent: 0.70, items: [...]}
      debt_repayment: {hours: 20, percent: 0.20, items: [...]}
      experimental: {hours: 10, percent: 0.10, items: [...]}
  
  # Technical debt analysis
  tech_debt:
    total_estimated_hours: 240
    by_category:
      - {category: "test_coverage_gaps", hours: 80, impact: "high", priority: 1}
      - {category: "outdated_dependencies", hours: 60, impact: "medium", priority: 2}
      - {category: "code_duplication", hours: 50, impact: "medium", priority: 3}
      - {category: "missing_documentation", hours: 30, impact: "low", priority: 4}
      - {category: "performance_hotspots", hours: 20, impact: "high", priority: 1}
    
    repayment_plan:
      - item: "Increase test coverage from 78% to 85%"
        hours: 40
        priority: 1
        target_completion: "2026-06-16"
      - item: "Refactor duplicated auth logic"
        hours: 16
        priority: 2
        target_completion: "2026-06-09"
  
  # Dual-track progress
  tracks:
    system_quality:
      current_score: 0.78
      target_score: 0.85
      delta: +0.02
      trend: "improving"
      bottleneck: "test coverage in legacy modules"
    ai_effectiveness:
      current_score: 0.87
      target_score: 0.92
      delta: +0.03
      trend: "improving"
      bottleneck: "chaos experiment edge cases"
  
  # Convergence check
  convergence:
    status: "CONVERGING"  # CONVERGED | CONVERGING | DIVERGING
    boundedness: "ok"  # Within M
    monotonicity: "ok"  # Quality non-decreasing
    termination_predicted_at: "iteration 18"
    iterations_remaining: 6
    
    # Learning rate adjustment
    learning_rate:
      system: {alpha: 0.05, constraint: "< 2/L_Q where L_Q=20", status: "ok"}
      ai: {beta: 0.03, constraint: "< 2/L_E where L_E=30", status: "ok"}
  
  # Skill optimizations
  skill_updates:
    - skill: "test-planner"
      action: "optimize"
      reason: "Success rate 78% < 85% threshold"
      changes:
        - "Improve chaos experiment edge case handling"
        - "Add 3 example scenarios"
      expected_improvement: "+5% success rate"
      
    - skill: "requirement-analyzer"
      action: "monitor"
      reason: "Success rate 92% > 90% target"
      changes: []
  
  # Skill retirements
  skill_retirements:
    - skill: "old-test-generator"
      reason: "Replaced by test-planner (unified)"
      archive_path: "skills/.archive/old-test-generator/"
  
  # Next iteration actions
  next_actions:
    - "Run optimized test-planner with new examples, measure success rate"
    - "Increase test coverage in identified modules"
    - "Refactor auth duplication"
    - "Update skill library with new pattern: chaos edge cases"
  
  # Convergence prediction
  prediction:
    will_converge: true
    estimated_iterations: 6
    estimated_target_met: "2026-06-09"
```

## Implementation

### Convergence Check

```python
def check_convergence(state: dict) -> dict:
    """Check convergence conditions for recursive optimization."""
    # Boundedness: state norm < M
    bounded = norm(state["system_state"]) < state["bound_M"]
    
    # Monotonicity: quality non-decreasing
    monotonic = (
        state["quality_t"] >= state["quality_t_minus_1"] - state["epsilon"]
    )
    
    # Termination: change < delta
    terminated = (
        abs(state["quality_t"] - state["quality_t_minus_1"]) < state["delta"]
    )
    
    if terminated:
        status = "CONVERGED"
    elif bounded and monotonic:
        status = "CONVERGING"
    else:
        status = "DIVERGING"
    
    return {
        "status": status,
        "boundedness": "ok" if bounded else "violated",
        "monotonicity": "ok" if monotonic else "violated",
        "termination": "ok" if terminated else "pending",
    }
```

### Learning Rate Validation

```python
def validate_learning_rate(alpha: float, L: float) -> bool:
    """Ensure learning rate satisfies α < 2/L (Lipschitz)."""
    return alpha < 2.0 / L
```

### Skill Optimization

```python
def optimize_skill(skill_name: str, metrics: dict, feedback: str) -> dict:
    """Propose optimization for a skill."""
    if metrics["success_rate"] < 0.85:
        return {
            "skill": skill_name,
            "action": "optimize",
            "changes": analyze_feedback(feedback),
            "expected_improvement": estimate_improvement(metrics),
        }
    return {"skill": skill_name, "action": "monitor", "changes": []}
```

### Budget Allocation

```python
def allocate_budget(total_hours: float, debt: list, features: list, experiments: list) -> dict:
    """Allocate 70/20/10 budget across work categories."""
    feature_hours = total_hours * 0.70
    debt_hours = total_hours * 0.20
    experimental_hours = total_hours * 0.10
    
    return {
        "feature_work": {"hours": feature_hours, "items": prioritize(features, feature_hours)},
        "debt_repayment": {"hours": debt_hours, "items": prioritize(debt, debt_hours)},
        "experimental": {"hours": experimental_hours, "items": prioritize(experiments, experimental_hours)},
    }
```

## Validation Rules

- ✅ Learning rates within Lipschitz constraints (α < 2/L)
- ✅ Quality monotonically non-decreasing
- ✅ State bounded (no unbounded growth)
- ✅ Termination condition defined
- ✅ 70/20/10 budget respected
- ✅ Skills below 85% success rate get optimization proposals

## Integration with Aether.go Methodology

- **Input from**:
  - `metrics-tracker` (system + AI metrics)
  - `skill-manager` (skill library state)
  - `architecture-auditor` (audit findings)
- **Output to**:
  - `skill-manager` (optimized skills)
  - `metrics-tracker` (improvement targets)
  - `constitution-validator` (compliance trends)
- **Part of**: Evolution Layer
- **Principle alignment**:
  - **P13 Recursive-Self-Optimization**: Core implementation
  - **P14 Knowledge-Engine**: Skill library updates

## Migration Notes

This skill consolidates 4 previously separate skills:
- `recursive-optimizer` → Core optimization loop
- `convergence-checker` → Convergence validation
- `improvement-budget-allocator` → 70/20/10 allocation
- `tech-debt-quantifier` → Debt cataloging
