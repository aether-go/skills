---
name: skill-optimizer
description: Use when optimizing skill parameters and prompts based on execution history and success rate analysis
---

# Skill Optimizer

## Overview
Optimize skill parameters and prompts based on execution history and success rate analysis. Implements recursive self-optimization by analyzing what works best and adjusting skill configurations accordingly.

## When to Use

```
Skill performance declining? ──────────────────┐
                                              │
Parameter tuning needed? ──────────────────────┤
                                              ├─► Use skill-optimizer
Success rate optimization? ────────────────────┤
                                              │
Recursive improvement active? ─────────────────┘
```

Use when:
- Skill success rate below threshold
- Prompt refinement needed
- Parameter tuning opportunities identified
- Implementing recursive optimization

## Core Pattern

### Optimization Process

```
Skill Execution
    │
    ▼
Metrics Collection
    ├── Success rate
    ├── Execution time
    ├── Output quality
    └── User feedback
    │
    ▼
Pattern Analysis
    ├── What works well?
    ├── What fails?
    ├── Common contexts?
    └── Optimal parameters?
    │
    ▼
Optimization
    ├── Prompt refinement
    ├── Parameter adjustment
    ├── Example selection
    └── Threshold tuning
```

### A/B Testing Framework

```python
class SkillOptimizer:
    def run_ab_test(self, skill, variations):
        """Run A/B test on skill variations."""
        
        results = {}
        for variation in variations:
            result = self.execute_skill(skill, variation)
            results[variation.id] = result
            
        winner = self.select_winner(results)
        return {
            'winner': winner,
            'confidence': self.calculate_confidence(results),
            'recommendation': winner if results[winner].confidence > 0.95 else 'keep_current'
        }
```

## Integration with Aether.go Methodology

- **Input from**: skill-lifecycle-manager (performance data)
- **Output to**: skill-lifecycle-manager (updated skill)
- **Part of**: D7 Evolution Optimization Domain (P9)
