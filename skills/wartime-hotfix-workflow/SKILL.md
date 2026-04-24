---
name: wartime-hotfix-workflow
description: Use when executing emergency production fixes with two-phase process: immediate remediation followed by post-incident normalization
---

# Wartime Hotfix Workflow

## Overview
Execute emergency production fix workflow following two-phase process: (1) Emergency Response for immediate service restoration, (2) Post-Incident Normalization for documentation and principle recovery. Temporarily exempts P6 (Test-First) with 24-hour mandatory completion.

## When to Use

```
Scenario detected: emergency? ────────────────┐
                                              │
Production incident active? ───────────────────┤
                                              ├─► Use wartime-hotfix-workflow
Immediate response required? ──────────────────┤
                                              │
Service degradation confirmed? ───────────────┘
```

Use when:
- scenario-detector identifies "emergency" mode
- Production service is degraded or down
- Standard process too slow for response
- Need immediate remediation

## Core Pattern

### Two-Phase Process

```
Phase 1: Emergency Response (Minutes)
    │
    ├── Objective: Restore service
    ├── Process: Diagnose → Fix → Verify → Deploy
    ├── Rules:
    │     ├── On-call engineer has full authority
    │     ├── Documentation can be deferred
    │     └── Test exemptions temporarily granted
    └── Deliverable: Service restored
    
Phase 2: Post-Incident Normalization (24 hours)
    │
    ├── Reverse-generate specification from fix
    ├── Create characterization tests
    ├── Conduct root cause analysis
    ├── Update skill library to prevent recurrence
    └── ConstitutionGuardian: Verify P6 completion
```

### Principle Adjustments

| Principle | Phase 1 | Phase 2 |
|-----------|---------|---------|
| P6 Test-First | Exempted (24h) | Mandatory |
| P7 Context-First | Deferred | Mandatory |
| P8 Human-AI Boundary | On-call decision | Full review |

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: emergency), incident-management
- **Output to**: constitution-guardian (exemption tracking)
- **Part of**: D6 Scenario Adaptation Domain
