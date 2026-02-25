---
name: spec-evolution-tracker
description: Use when tracking specification changes, version history, and impact analysis across project lifecycle
---

# Spec Evolution Tracker

## Overview
Track specification changes over time, maintain version history, and analyze impact of changes on dependent systems and implementations. Ensures traceability and informed decision-making during evolution.

## When to Use

```
Spec needs change? ─────────────────────┐
                                        │
Need version history? ───────────────────┤
                                        ├─► Use spec-evolution-tracker
Impact analysis for spec change? ───────┤
                                        │
Compliance audit needed? ─────────────────┘
```

Use when:
- Proposing specification changes
- Analyzing change impact
- Maintaining spec version history
- Compliance audits
- Release planning
- Stakeholder communication

## Core Pattern

### Spec Version History

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

## Output Location

Spec evolution history and changelogs are stored in `.aether/docs/requirements/` alongside the requirements:

```
.aether/docs/requirements/
├── 04-functional-requirements.md
├── {spec-id}-evolution.yaml       # Spec version history
└── {spec-id}-changelog.md         # Human-readable changelog
```

### Output Path Helper

```python
from pathlib import Path

class SpecEvolutionOutputManager:
    """Manages output paths for spec evolution artifacts."""
    
    BASE_PATH = '.aether/docs/requirements'
    
    @classmethod
    def get_evolution_path(cls, spec_id, base_path='.'):
        """Get path for spec evolution history file."""
        req_dir = Path(base_path) / cls.BASE_PATH
        req_dir.mkdir(parents=True, exist_ok=True)
        return req_dir / f"{spec_id}-evolution.yaml"
    
    @classmethod
    def get_changelog_path(cls, spec_id, base_path='.'):
        """Get path for spec changelog file."""
        req_dir = Path(base_path) / cls.BASE_PATH
        req_dir.mkdir(parents=True, exist_ok=True)
        return req_dir / f"{spec_id}-changelog.md"
```

## Implementation

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

### Impact Analysis

```python
def calculate_change_impact(change, dependency_graph):
    """Calculate impact of spec change across system."""

    impact = {
        'affected_components': [],
        'estimated_effort': 0,
        'risk_level': 'low'
    }

    # BFS traversal through dependency graph
    for spec_id in change['affected_specs']:
        components = find_components_implementing(spec_id)
        impact['affected_components'].extend(components)

        # Find downstream dependencies
        downstream = find_downstream_dependencies(components)
        impact['affected_components'].extend(downstream)

    # Calculate risk based on components affected
    if len(impact['affected_components']) > 10:
        impact['risk_level'] = 'high'
        impact['estimated_effort'] = '2-3 sprints'
    elif len(impact['affected_components']) > 5:
        impact['risk_level'] = 'medium'
        impact['estimated_effort'] = '1-2 sprints'
    else:
        impact['risk_level'] = 'low'
        impact['estimated_effort'] = '< 1 sprint'

    return impact
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
