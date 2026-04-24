---
name: convergence-checker
description: Use when checking convergence conditions for recursive optimization ensuring boundedness, monotonicity, and termination criteria are met
---

# Convergence Checker

## Overview
Check convergence conditions for recursive self-optimization systems. Validates three key conditions: boundedness (optimization magnitude limits), monotonicity (quality doesn't significantly degrade), and termination (change magnitude below threshold or quality above target). Part of D7 Evolution Optimization Domain.

## When to Use

```
Recursive optimization running? ────────────────┐
                                              │
Iteration check needed? ───────────────────────┤
                                              ├─► Use convergence-checker
Optimization progress validation? ─────────────┤
                                              │
P9 compliance verification? ────────────────────┘
```

Use when:
- Checking optimization iteration status
- Validating P9 convergence conditions
- Controlling recursive optimizer loop
- Quality gates between iterations
- Stop/continue optimization decisions

## Core Pattern

### Three Convergence Conditions

```
Optimization Iteration
    │
    ├── 1. Boundedness Check
    │     └── |S_t| < M (optimization magnitude limited)
    │
    ├── 2. Monotonicity Check
    │     └── Quality(S_{t+1}) ≥ Quality(S_t) - ε
    │
    └── 3. Termination Check
          └── |S_{t+1} - S_t| < δ OR Quality > Threshold
```

### Condition Details

| Condition | Formula | Purpose |
|-----------|---------|---------|
| **Boundedness** | ∃M, ∀t, \|S_t\| < M | Prevent runaway changes |
| **Monotonicity** | Quality(t+1) ≥ Quality(t) - ε | Quality doesn't degrade |
| **Termination** | change < δ OR quality > threshold | Stable improvement found |

### Convergence Decision

```
┌─────────────────────────────────────┐
│        Convergence Check            │
└─────────────────┬───────────────────┘
                  │
      ┌───────────┼───────────┐
      ▼           ▼           ▼
  Bounded?    Monotonic?   Terminate?
      │           │           │
      ▼           ▼           ▼
   [PASS]      [PASS]      [YES] → STOP
      │           │           │
      └───────────┴───────────┘
                  │
                  ▼
              All PASS?
                  │
         ┌───────┴───────┐
         ▼               ▼
       [YES]            [NO]
         │               │
         ▼               ▼
      STOP           Continue
    (Converged)    (Not Converged)
```

## Implementation

### Convergence Validator

```python
class ConvergenceChecker:
    def __init__(self, config):
        self.config = config
        self.history = []
        
    def check(self, current_state, previous_state=None):
        """Check all three convergence conditions."""
        
        results = {
            'boundedness': self._check_boundedness(current_state),
            'monotonicity': self._check_monotonicity(current_state, previous_state),
            'termination': self._check_termination(current_state, previous_state),
        }
        
        # Converged if termination reached AND boundedness satisfied
        results['converged'] = (
            results['termination']['should_terminate'] and
            results['boundedness']['satisfied']
        )
        
        return results
    
    def _check_boundedness(self, state):
        """Check: ∃M, ∀t, |S_t| < M"""
        checks = {
            'changes_count': state.changes <= self.config.max_changes,
            'magnitude': state.magnitude <= self.config.max_magnitude,
        }
        return {'satisfied': all(checks.values()), 'checks': checks}
    
    def _check_monotonicity(self, current, previous):
        """Check: Quality(t+1) ≥ Quality(t) - ε"""
        if not previous:
            return {'satisfied': True, 'delta': None}
        
        delta = current.quality - previous.quality
        return {
            'satisfied': delta >= -self.config.epsilon,
            'delta': delta
        }
```

## Integration with Aether.go Methodology

- **Input from**: recursive-optimizer (iteration state)
- **Output to**: recursive-optimizer (convergence decision)
- **Validates**: P9 Recursive Self-Optimization Principle
- **Part of**: D7 Evolution Optimization Domain (P9)
