---
name: skill-lifecycle-manager
description: Use when managing skill asset lifecycle from creation through validation, assetization, application, feedback, optimization to retirement
---

# Skill Lifecycle Manager

## Overview
Manage skill asset lifecycle following the 6-phase model: (1) Creation, (2) Validation, (3) Assetization, (4) Application, (5) Feedback, (6) Optimization/Retirement. Implements P10: Skill Library Assetization Principle.

## When to Use

```
Skill asset management? ───────────────────────┐
                                              │
New skill created? ────────────────────────────┤
                                              ├─► Use skill-lifecycle-manager
Skill performance declining? ─────────────────┤
                                              │
Skill retirement evaluation? ──────────────────┘
```

Use when:
- Creating new skill assets
- Validating skill effectiveness
- Reviewing skill performance
- Retiring obsolete skills

## Core Pattern

### Skill Lifecycle

```
Creation → Validation → Assetization → Application → Feedback → Optimization
    │                                        │
    └────────────────────────────────────────┘
                    │
                    ▼
               Retirement
            (if triggered)
```

### Phase Details

| Phase | Gate | Criteria |
|-------|------|----------|
| Creation | Skill authored | Documented pattern |
| Validation | Trial use | Success rate > 85% |
| Assetization | Quality review | Documented, versioned |
| Application | Production use | Active usage |
| Feedback | Usage analysis | Performance tracked |
| Optimization | Threshold breach | Update or retire |

### Retirement Triggers

- Technology stack obsolete
- Success rate < 85% threshold
- Superseded by better skill
- Extended non-use (> 6 months)

## Integration with Aether.go Methodology

- **Input from**: All skills (usage metrics)
- **Output to**: skill-recommender (skill catalog)
- **Part of**: D7 Evolution Optimization Domain (P10)
