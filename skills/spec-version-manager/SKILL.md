---
name: spec-version-manager
description: Use when managing specification versions, tracking changes, maintaining version history, analyzing impact, and enabling traceability and comparability between specification versions (merged with spec-evolution-tracker)
---

# Spec Version Manager

## Overview
Manage specification versions throughout the development lifecycle. Track changes, maintain version history, analyze impact of changes, enable rollback to previous versions, and provide traceability and comparability between specification versions. Combines version lifecycle management with evolution tracking. Essential for L3→L2 transition tracking and audit compliance.

**Note**: This skill has merged with spec-evolution-tracker capabilities.

## When to Use

```
Specification established? ──────────────────┐
                                              │
Specification change detected? ────────────────┤
                                              ├─► Use spec-version-manager
Need version history or rollback? ────────────┤
                                              │
Audit trail required? ───────────────────────┘
```

Use when:
- Specifications need version control
- Tracking specification evolution over time
- Comparing versions for impact analysis
- Rollback to previous specification version needed
- Audit trail required for compliance
- Branching specifications for different scenarios

## Core Pattern

### Version Lifecycle

```
Specification Created (v1.0.0)
    │
    ├── Change Request
    │     │
    │     ├── Impact Analysis
    │     ├── Change Approval
    │     └── Version Increment
    │
    ├── v1.1.0 (Minor: small change)
    ├── v1.2.0 (Minor: small change)
    │
    └── v2.0.0 (Major: breaking change)
          │
          └── Can branch to v1.x for maintenance
```

### Version Numbering Convention

| Type | Format | Example | When to Use |
|------|--------|---------|-------------|
| Major | X.0.0 | 2.0.0 | Breaking changes, architecture shifts |
| Minor | X.Y.0 | 1.3.0 | New features, non-breaking additions |
| Patch | X.Y.Z | 1.2.5 | Bug fixes, clarifications |

### Change Classification

| Change Type | Version Bump | Impact | Examples |
|-------------|--------------|--------|----------|
| **Major** | X.0.0 | Breaking | Architecture change, new system |
| **Minor** | X.Y.0 | Additive | New FR, new AC, new NFR |
| **Patch** | X.Y.Z | Fix | Clarification, typo, constraint tweak |

## Key Artifacts

| Artifact | Purpose |
|----------|---------|
| Version History | Chronological list of all spec versions |
| Diff Report | Comparison between any two versions |
| Change Log | Structured list of changes per version |
| Branch Map | Visualization of spec branches |
| Rollback Plan | Steps to revert to previous version |

## Version Metadata Schema

```yaml
spec_version:
  version: "1.2.0"
  parent_version: "1.1.0"
  created_at: "2025-04-24T10:00:00Z"
  created_by: "agent-id"
  change_type: "minor"
  
  changes:
    - type: "added"
      item: "FR-005"
      description: "Added social login requirement"
      
    - type: "modified"
      item: "AC-003"
      before: "response time < 500ms"
      after: "response time < 200ms"
      
    - type: "deprecated"
      item: "FR-002"
      reason: "Superseded by FR-005"
      
  rationale: "Support social login for user acquisition goal"
  approved_by: "human-ai-boundary-guard"
```

## Integration with Aether.go Methodology

### D3 Specification Derivation Domain

```
L3: System Specification S
    │
    ├── spec-version-manager: Track versions
    ├── spec-to-scenario: Transform to scenarios
    ├── scenario-completeness-checker: Validate coverage
    └── nfr-analyzer: Extract NFRs
```

### Workflow Integration

| Stage | Spec Version Action |
|-------|---------------------|
| Stage 2 (Spec Definition) | Create initial version |
| Stage 3 (Constitutional Review) | Record review changes |
| Stage 4 (Implementation Planning) | Lock version for implementation |
| Stage 6 (Integration Validation) | Compare against spec |
| Change Request | Create new version |

### Change Request Workflow

```
Change Request Received
    │
    ├── Impact Analysis
    │     ├── What specs are affected?
    │     ├── What downstream artifacts?
    │     └── What tests need updates?
    │
    ├── Version Decision
    │     ├── Major, Minor, or Patch?
    │     └── Branch needed?
    │
    ├── Approval (Human/AI based on confidence)
    │
    ├── Implement Change
    │     ├── Update specification
    │     ├── Update version metadata
    │     └── Update traceability
    │
    └── Notify Downstream
          ├── Update derivation matrix
          └── Trigger affected agents
```

## Diff Generation

### Comparison Types

| Type | Use Case |
|------|----------|
| **Semantic Diff** | Functional changes between versions |
| **Structural Diff** | Addition/removal of requirements |
| **Impact Diff** | Downstream effect analysis |

### Diff Output Format

```yaml
diff_report:
  from_version: "1.1.0"
  to_version: "1.2.0"
  
  semantic_changes:
    - item: "FR-003"
      change: "modified"
      impact: "medium"
      description: "Priority elevated from should to must"
      
  structural_changes:
    additions:
      - FR-005, AC-007
    removals: []
    modifications:
      - FR-003, AC-003, AC-004
      
  impact_assessment:
    affected_agents: ["change-and-task-agent", "context-manager"]
    affected_docs: ["docs/02-specification/auth.md"]
    affected_tests: ["integration/auth_test.go"]
    regression_risk: "medium"
```

## Rollback Support

### Rollback Decision Matrix

| Confidence | Risk Level | Rollback Required |
|-----------|------------|------------------|
| < 0.70 | Any | Yes, human must approve |
| 0.70-0.90 | High | Yes, with justification |
| 0.70-0.90 | Medium | Optional, recommended |
| > 0.90 | Any | No, continue |

### Rollback Plan Template

```yaml
rollback_plan:
  target_version: "1.1.0"
  current_version: "1.2.0"
  
  steps:
    - step: 1
      action: "Restore specification text"
      artifact: "docs/02-specification/auth.md"
      
    - step: 2
      action: "Update derivation matrix"
      checkpoint: "L2 state reset"
      
    - step: 3
      action: "Notify affected agents"
      agents: ["workflow-orchestrator", "change-and-task-agent"]
      
  validation:
    - "Verify spec matches target version"
    - "Confirm downstream docs updated"
    - "Run consistency-checker"
```

## Version Comparison Features

### Visual Comparison

```yaml
comparison_view:
  left_version: "1.1.0"
  right_version: "1.2.0"
  
  additions:
    highlight: "green"
    items: ["FR-005", "AC-007"]
    
  removals:
    highlight: "red"
    items: []
    
  modifications:
    highlight: "yellow"
    items:
      - id: "FR-003"
        before: "Priority: should"
        after: "Priority: must"
```

## Evolution Tracking (Merged from spec-evolution-tracker)

### Spec Evolution History

Track specification changes over time with full version history:

```yaml
spec_evolution:
  spec_id: "REQ-ORDER-001"
  title: "Order Processing"

  versions:
    - version: "1.0"
      date: "2026-01-01"
      status: "released"
      author: "Alice"
      changes: "Initial version"
      requirements:
        - "User can create order"
        - "Order validation"

    - version: "1.1"
      date: "2026-01-15"
      status: "released"
      author: "Bob"
      changes: "Added order cancellation"
      requirements:
        - "User can create order"
        - "Order validation"
        - "Order cancellation"
      impact:
        affected_services:
          - "Order Service"
          - "Payment Service"
        breaking_changes: false

    - version: "2.0"
      date: "2026-02-01"
      status: "proposed"
      author: "Charlie"
      changes: "Added subscription support"
      requirements:
        - "User can create order"
        - "Order validation"
        - "Order cancellation"
        - "Recurring orders"
      impact:
        affected_services:
          - "Order Service"
          - "Payment Service"
          - "Subscription Service"
        breaking_changes: true
        migration_plan: "Migrate existing orders to subscription model"
```

### Change Analysis

```python
def analyze_spec_change(old_spec, new_spec):
    """Analyze differences between spec versions."""

    changes = {
        'added': [],
        'removed': [],
        'modified': [],
        'breaking': False
    }

    old_requirements = {r['id'] for r in old_spec['requirements']}
    new_requirements = {r['id'] for r in new_spec['requirements']}

    changes['added'] = new_requirements - old_requirements
    changes['removed'] = old_requirements - new_requirements

    for req_id in old_requirements & new_requirements:
        old_req = next(r for r in old_spec['requirements'] if r['id'] == req_id)
        new_req = next(r for r in new_spec['requirements'] if r['id'] == req_id)
        if old_req != new_req:
            changes['modified'].append({
                'id': req_id,
                'old': old_req,
                'new': new_req
            })

    changes['breaking'] = len(changes['removed']) > 0 or any(
        m['old'].get('priority') == 'must' and m['new'].get('priority') != 'must'
        for m in changes['modified']
    )

    return changes
```

### Changelog Generation

```markdown
# Changelog: REQ-ORDER-001 - Order Processing

## [2.0.0] - 2026-02-01 (Proposed)
### Added
- Subscription order support
- Recurring order scheduling

### Changed
- Order data model now supports subscription fields

### Breaking
- Order API requires `type` field (default: "one-time")
- Order validation now checks subscription-specific fields

### Migration
Run migration: `npm run migrate:order-subscription`

### Impact
- **Affected Services:** Order Service, Payment Service, Subscription Service
- **Estimated Effort:** 2-3 sprints
- **Risk Level:** High

---

## [1.1.0] - 2026-01-15 (Released)
### Added
- Order cancellation
- Order status tracking

### Impact
- **Affected Services:** Order Service, Payment Service
- **Estimated Effort:** 1 sprint
- **Risk Level:** Medium
```

## Integration Points

- **Input from**: spec-to-scenario, usecase-designer, nfr-analyzer
- **Output to**: context-manager (derivation matrix), constitution-guardian (compliance tracking)
- **Triggers**: workflow-orchestrator (stage transitions), change-and-task-agent (change requests)
- **Part of**: D3 Specification Derivation Domain

## Quality Gates

- Version number MUST follow semantic versioning
- Each change MUST have rationale
- Major changes MUST have human approval
- Version history MUST be immutable
- Rollback MUST preserve audit trail
