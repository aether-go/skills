---
name: adjustment-proposer
description: Use when proposing architecture or workflow adjustments in response to audit findings, derivation gaps, or principle conflicts
---

# Adjustment Proposer

## Overview
Propose architecture or workflow adjustments in response to audit findings, derivation gaps, or principle conflicts. Triggered by META-004 protocol when architecture-self-auditor or derivation-chain-validator identifies issues requiring human-validated corrections.

## When to Use

```
Audit finding requires action? ────────────────┐
                                              │
Derivation gap detected? ──────────────────────┤
                                              ├─► Use adjustment-proposer
Principle conflict needs resolution? ──────────┤
                                              │
META-004 triggered? ──────────────────────────┘
```

Use when:
- architecture-self-auditor reports issues
- derivation-chain-validator finds gaps
- principle-consistency-checker identifies conflicts
- Skill gap analysis reveals missing capabilities

## Core Pattern

### Adjustment Types

| Issue Type | Adjustment Scope | Example |
|------------|-----------------|---------|
| Skill Gap | New skill creation | Add missing derivation skill |
| Process Gap | Workflow modification | Add validation checkpoint |
| Architecture | Structural change | Modify agent responsibilities |
| Principle Conflict | Dynamic weighting | Adjust P weights temporarily |

### Proposal Structure

```yaml
adjustment_proposal:
  id: "AP-20250424-001"
  triggered_by: "META-004"
  source: "architecture-self-auditor"
  
  issue:
    type: "skill_gap"
    description: "Missing L3→L4 test stratification skill"
    impact: "Cannot generate test分层 plans"
    
  proposed_adjustment:
    action: "create_skill"
    target: "test-pyramid-deriver"
    priority: "high"
    effort: "2 days"
    
  expected_outcome:
    - "Complete derivation chain"
    - "META-002 validation pass"
    
  risks:
    - "Delay in current sprint"
    - "Learning curve for team"
```

## Integration with Aether.go Methodology

- **Input from**: architecture-self-auditor, derivation-chain-validator
- **Output to**: adjustment-validator (validation)
- **Part of**: D8 Meta-Capability Domain (META-004)
