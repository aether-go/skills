---
name: architecture-auditor
description: Use when auditing the overall architecture for completeness, consistency, principle compliance, derivation chain integrity, and proposing/validating adjustments. This skill unifies the meta-verification layer and replaces architecture-self-auditor, derivation-chain-validator, adjustment-proposer, and adjustment-validator.
---

# Architecture Auditor

## Overview

The unified skill for architecture auditing and self-correction. This skill:
- Audits architecture for completeness, consistency, compliance, performance, scalability, maintainability
- Validates the 6-layer derivation chain (L1→L5) integrity
- Detects principle conflicts and validates via dynamic weighting
- Proposes and validates architecture adjustments
- Implements META-001 (architecture audit) and META-004 (adjustment) protocols

**Replaces** (consolidated from 4 skills):
- `architecture-self-auditor`
- `derivation-chain-validator`
- `adjustment-proposer`
- `adjustment-validator`

## When to Use

```
Need comprehensive architecture audit? ─────┐
                                            │
Validating 6-layer derivation chain? ───────┤
                                            │
Proposing architecture adjustments? ─────────┼─► Use architecture-auditor
                                            │
Validating proposed changes are safe? ──────┤
                                            │
Periodic health check? ─────────────────────┘
```

## Core Pattern

```
Subject (architecture or derivation chain)
    │
    ├──► [1] Completeness Check
    │         ├── Layer coverage (L1-L5)
    │         ├── Skill coverage
    │         └── Missing components
    │
    ├──► [2] Consistency Check
    │         ├── Interface alignment
    │         ├── Data flow integrity
    │         └── Cross-layer traceability
    │
    ├──► [3] Derivation Chain Validation (L1-L5)
    │         ├── L1 → L2 completeness
    │         ├── L2 → L3 completeness
    │         ├── L3 → L4 completeness
    │         ├── L4 → L4.5 dispatch
    │         └── L4.5 → L5 generation
    │
    ├──► [4] Principle Compliance (P0-P14)
    │         ├── Run constitution-validator
    │         ├── Detect conflicts
    │         └── Apply dynamic weighting
    │
    ├──► [5] Performance / Scalability / Maintainability
    │         ├── Latency budgets met
    │         ├── Load capacity
    │         └── Documentation coverage
    │
    ├──► [6] Propose Adjustments (if issues found)
    │         ├── Generate fix proposals
    │         └── Prioritize by impact
    │
    └──► [7] Validate Adjustments (META-004)
              ├── Safety check
              ├── Impact analysis
              └── Approval status
    │
    ▼
Audit Report + Adjustment Plan
```

## Input Format

```yaml
audit_request:
  system:
    name: "Aether Platform"
    version: "3.0"
  
  # Scope
  scope:
    type: "full"  # full | derivation-chain | principles | performance
    
  architecture:
    layers: ["L1", "L2", "L3", "L4", "L4.5", "L5"]
    domains: ["D1", "D2", "D3", "D4", "D4.5", "D5", "D6", "D7", "D8"]
    principles: ["P0", "P1", ..., "P14"]
  
  artifacts:
    code: "src/"
    tests: "tests/"
    docs: "docs/"
    config: ".aether/"
    adrs: "docs/adr/"
    constraints: "constraints/"
  
  # Adjustment proposal (if validating)
  adjustment:
    description: "Add Kafka for event-driven order processing"
    affected_components: ["order-service", "payment-service"]
    estimated_effort: "2 weeks"
```

## Output Format

### Audit Report

```yaml
audit_report:
  system: "Aether Platform"
  version: "3.0"
  audit_date: "2026-06-02T10:00:00Z"
  scope: "full"
  
  overall_score: 0.88
  status: "passing"  # passing | warning | failing
  issues: 3
  warnings: 5
  
  # === Dimension 1: Completeness ===
  completeness:
    score: 0.92
    status: "passing"
    layer_coverage: {L1: 1.0, L2: 1.0, L3: 0.95, L4: 0.90, L4.5: 0.95, L5: 1.0}
    skill_coverage: 0.94
    missing: ["L3: 1 missing NFR analysis"]
  
  # === Dimension 2: Consistency ===
  consistency:
    score: 0.85
    status: "passing"
    interface_alignment: 0.95
    data_flow_integrity: 0.90
    cross_layer_traceability: 0.85
    issues:
      - "L4 to L4.5 data flow not fully documented"
      - "Inconsistent error type between L2 spec and L4 contract"
  
  # === Dimension 3: Derivation Chain ===
  derivation_chain:
    score: 0.93
    status: "passing"
    layers:
      L1_to_L2: {completeness: 1.0, orphans: 0, coverage_gaps: []}
      L2_to_L3: {completeness: 0.95, orphans: 1, coverage_gaps: ["FR-008 not traced to spec"]}
      L3_to_L4: {completeness: 0.90, orphans: 0, coverage_gaps: ["scenario_signup_timeout missing test"]}
      L4_to_L4_5: {completeness: 0.95, dispatch_rate: 0.65}
      L4_5_to_L5: {completeness: 1.0, ai_generated: 12, traditional: 18}
    issues:
      - "Orphan: FR-008 (payment retry logic) not traced to spec"
      - "Missing: scenario_signup_timeout not in test pyramid"
  
  # === Dimension 4: Principle Compliance ===
  principle_compliance:
    score: 0.90
    status: "passing"
    principles: {P0: PASS, P1: PASS, P2: PASS, P3: PASS, P4: PASS, P5: WARNING, P6: PASS, P7: PASS, P8: PASS, P9: PASS, P10: PASS, P11: PASS, P12: PASS, P13: PASS, P14: WARNING}
    warnings:
      - "P5: 6 core dependencies (target ≤5)"
      - "P14: Knowledge engine coverage 78% (target 80%)"
  
  # === Dimension 5: Performance / Scalability / Maintainability ===
  performance:
    score: 0.82
    status: "warning"
    p95_ms: 195
    target_p95_ms: 200
    issue: "P95 latency 195ms, close to 200ms budget"
  
  scalability:
    score: 0.88
    status: "passing"
    current_load: 0.67
    capacity_headroom: 0.33
  
  maintainability:
    score: 0.90
    status: "passing"
    doc_coverage: 0.85
    test_coverage: 0.87
  
  # === Issues & Warnings ===
  issues:
    - severity: "medium"
      type: "derivation_gap"
      description: "FR-008 not traced to spec"
      fix: "Add spec for payment retry logic in spec-engineer"
    - severity: "low"
      type: "principle_warning"
      description: "P5: 6 core dependencies"
      fix: "Replace custom logger with zap (already in dependencies)"
    - severity: "medium"
      type: "performance"
      description: "P95 latency close to budget"
      fix: "Optimize user query, add index on users.email"
  
  warnings: 5
  
  # === Adjustment Plan (if issues found) ===
  adjustment_plan:
    - id: "ADJ-001"
      priority: "high"
      action: "Add payment retry spec (closes derivation gap)"
      owner: "spec-team"
      effort: "1 day"
      impact: "fixes derivation chain"
    
    - id: "ADJ-002"
      priority: "medium"
      action: "Optimize user query (reduces P95 from 195ms to ~150ms)"
      owner: "backend-team"
      effort: "2 days"
      impact: "restores performance headroom"
    
    - id: "ADJ-003"
      priority: "low"
      action: "Replace custom logger with zap (reduces to 5 deps)"
      owner: "backend-team"
      effort: "1 day"
      impact: "satisfies P5"
  
  next_audit: "2026-07-02T10:00:00Z"
```

### Adjustment Validation

```yaml
adjustment_validation:
  adjustment: "Add Kafka for event-driven order processing"
  validation_result: "APPROVED"
  
  safety_check:
    passed: true
    concerns: []
  
  impact_analysis:
    affected_components: ["order-service", "payment-service"]
    estimated_complexity_increase: 0.05
    performance_impact: "improved (async processing)"
    risk_level: "medium"
    mitigation: "Implement with feature flag, gradual rollout"
  
  principle_impact:
    p4_interface_first: "neutral"
    p6_occams_razor: "negative (adds dependency)"
    p11_nfr_built_in: "positive (better performance)"
  
  recommendation: "Approve with feature flag; defer to Q3 if not on critical path"
  
  approver: "architect@team"
  approved_at: "2026-06-02T11:00:00Z"
```

## Implementation

### Derivation Chain Validation

```python
def validate_derivation_chain(layers: dict) -> dict:
    """Validate L1→L5 derivation chain."""
    results = {}
    for transition in ["L1_to_L2", "L2_to_L3", "L3_to_L4", "L4_to_L4_5", "L4_5_to_L5"]:
        from_layer, to_layer = transition.split("_to_")
        from_items = layers[from_layer]
        to_items = layers[to_layer]
        # Check coverage: every from_item should trace to at least one to_item
        traced = {item["id"] for item in to_items if "traces_to" in item}
        orphans = [item["id"] for item in from_items if item["id"] not in traced]
        # Check completeness: every to_item should trace back
        back_traced = {item["traces_to"] for item in to_items if "traces_to" in item}
        coverage_gaps = [item["id"] for item in from_items if item["id"] not in back_traced]
        results[transition] = {
            "completeness": 1.0 - len(coverage_gaps) / max(len(from_items), 1),
            "orphans": orphans,
            "coverage_gaps": coverage_gaps,
        }
    return results
```

### Adjustment Proposal

```python
def propose_adjustment(audit_issues: list) -> list:
    """Propose fixes for audit issues."""
    proposals = []
    for issue in audit_issues:
        proposal = {
            "id": f"ADJ-{len(proposals) + 1:03d}",
            "priority": compute_priority(issue),
            "action": suggest_fix(issue),
            "owner": suggest_owner(issue),
            "effort": estimate_effort(issue),
            "impact": estimate_impact(issue),
        }
        proposals.append(proposal)
    return sorted(proposals, key=lambda p: p["priority"])
```

### Adjustment Validation

```python
def validate_adjustment(adjustment: dict) -> dict:
    """Validate proposed adjustment for safety and impact."""
    return {
        "safety_check": check_safety(adjustment),
        "impact_analysis": analyze_impact(adjustment),
        "principle_impact": assess_principle_impact(adjustment),
        "recommendation": make_recommendation(adjustment),
    }
```

## Validation Rules

- ✅ All 6 layers validated for completeness
- ✅ All 15 principles checked
- ✅ Orphans and gaps detected and reported
- ✅ Adjustments prioritized by impact × effort
- ✅ Validation before applying changes

## Integration with Aether.go Methodology

- **Input from**:
  - All derivation skills (for chain validation)
  - `constitution-validator` (for principle check)
  - `metrics-tracker` (for performance metrics)
- **Output to**:
  - `methodology-fusion-orchestrator` (audit findings)
  - `recursive-optimizer` (improvement targets)
  - `skill-manager` (skill gaps)
- **Part of**: D8 Meta-Capability Domain
- **Principle alignment**:
  - **P13 Recursive-Self-Optimization**: Core implementation
  - **All 15 principles**: Validated by this skill

## Migration Notes

This skill consolidates 4 previously separate skills:
- `architecture-self-auditor` → Dimensions 1, 2, 5
- `derivation-chain-validator` → Dimension 3
- `adjustment-proposer` → Step 6
- `adjustment-validator` → Step 7 (META-004)

**Protocols implemented**:
- **META-001**: Architecture self-audit
- **META-002**: Derivation chain validation
- **META-004**: Adjustment proposal + validation
