---
name: value-architecture-tracer
description: Use when verifying the bidirectional mapping between functional requirements and architecture decisions, ensuring complete bipartite graph with no isolated nodes in L1 to L2 derivation
---

# Value Architecture Tracer

## Overview
Verify and maintain the bidirectional traceability between functional requirements (L2) and architecture decisions (ADR). Ensures the complete bipartite graph required by P1: Purpose-Driven Principle, where every architecture decision maps to at least one business goal and every business goal is supported by at least one architecture decision.

## When to Use

```
Functional requirements defined? ─────────────┐
                                              │
Architecture decisions made? ─────────────────┤
                                              ├─► Use value-architecture-tracer
L1 -> L2 derivation validation needed? ───────┤
                                              │
P1 Principle compliance check? ────────────────┘
```

Use when:
- Validating completeness of L1→L2 derivation
- Verifying P1: Purpose-Driven Principle compliance
- Ensuring no isolated nodes in requirement-architecture mapping
- Performing impact analysis for requirement changes
- Preparing for constitution-guardian review

Don't use when:
- Requirements or architecture are not yet defined
- Only documenting existing decisions (use architecture-decision-recorder)
- Checking code-implementation trace (use requirement-implementation-tracer)

## Core Pattern

### L1→L2 Derivation Validation Model

```
Business Goals (L1)
    ├── BG-001: Grow user base by 30%
    ├── BG-002: Reduce churn to <5%
    └── BG-003: Improve NPS to >50
         │
         │ value-decomposer
         ▼
Functional Requirements (L2)
    ├── FR-001: Multi-channel registration
    ├── FR-002: Onboarding tutorial
    ├── FR-003: Retention campaigns
    └── FR-004: Support ticket system
         │
         │ value-architecture-tracer
         ▼
Architecture Decisions (ADR)
    ├── ADR-001: Microservices architecture (→ FR-001, FR-003)
    ├── ADR-002: Event-driven messaging (→ FR-002, FR-003)
    └── ADR-003: CDN for static assets (→ FR-001)
```

### Bipartite Graph Validation

```
Valid Mapping (Complete Bipartite):
    BG-001 ───────┬──────→ ADR-001
    BG-002 ───────┼──────→ ADR-002
    BG-003 ───────┴──────→ ADR-003

Invalid Mapping (Isolated Node):
    BG-001 ───────┬──────→ ADR-001
    BG-002 ───────┼          (ADR-002 isolated!)
    BG-003 ───────┴──────→ ADR-003
```

### Before (Without Architecture Tracing)
```yaml
business_goals:
  - bg-001: "Grow user base"
  
functional_requirements:
  - fr-001: "User registration"
  
architecture_decisions:
  - adr-001: "Use microservices"
  
result:
  - No visibility into which goal ADR supports
  - Cannot assess impact when goals change
  - Potential over-engineering for unaligned goals
  - P1 compliance cannot be verified
```

### After (With Architecture Tracing)
```yaml
business_goals:
  - bg-001: "Grow user base by 30%"

functional_requirements:
  - fr-001: "Multi-channel registration"
    business_value: "Reduce signup friction"
    derived_from: "bg-001"

architecture_decisions:
  - adr-001: "Microservices architecture"
    purpose: "Enable horizontal scaling for registration surge"
    supports: ["fr-001", "fr-002"]  # Maps to FRs
    
traceability_matrix:
  bg-001: [fr-001, fr-002]
  fr-001: [adr-001, adr-003]
  
validation:
  complete_bipartite: true
  isolated_nodes: []
  p1_compliant: true
```

## Quick Reference

### Mapping Rules

| Architecture Pattern | Typical Business Goal Support |
|---------------------|-------------------------------|
| Microservices | Scalability, Reliability |
| Event-driven | Responsiveness, Real-time |
| CQRS | Performance, Consistency |
| API Gateway | Security, Simplicity |
| CDN | Performance, User Experience |

### Validation Checklist

- [ ] Every ADR has at least one `supports` link to FR
- [ ] Every FR has at least one `supported_by` link to ADR
- [ ] No orphaned ADRs (not supporting any FR)
- [ ] No orphaned FRs (not supported by any ADR)
- [ ] Every ADR documents business purpose (P1 requirement)

## Implementation

### Traceability Matrix Generation

```python
class ValueArchitectureTracer:
    def __init__(self, functional_requirements, architecture_decisions):
        self.frs = functional_requirements
        self.adrs = architecture_decisions
        self.matrix = {}
        
    def generate_matrix(self):
        """Generate bidirectional traceability matrix."""
        
        # Initialize matrix
        for fr in self.frs:
            self.matrix[fr.id] = {'supports': [], 'supported_by': []}
        for adr in self.adrs:
            self.matrix[adr.id] = {'supports': [], 'supported_by': []}
            
        # Build forward links (FR → ADR)
        for adr in self.adrs:
            for fr_id in adr.supports:
                if fr_id in self.matrix:
                    self.matrix[fr_id]['supported_by'].append(adr.id)
                    self.matrix[adr.id]['supports'].append(fr_id)
                    
        return self.matrix
    
    def validate_completeness(self):
        """Validate complete bipartite graph."""
        
        issues = []
        
        # Check for orphaned FRs
        for fr_id, links in self.matrix.items():
            if fr_id.startswith('fr-') and not links['supported_by']:
                issues.append(f"Isolated FR: {fr_id} has no supporting ADR")
                
        # Check for orphaned ADRs
        for adr_id, links in self.matrix.items():
            if adr_id.startswith('adr-') and not links['supports']:
                issues.append(f"Isolated ADR: {adr_id} supports no FRs")
                
        return {
            'valid': len(issues) == 0,
            'issues': issues,
            'complete_bipartite': len(issues) == 0
        }
```

## Output Format

```yaml
value_architecture_trace:
  trace_id: "vat-20250424-001"
  validation_timestamp: "2025-04-24T10:00:00Z"
  
  traceability_matrix:
    fr-001:
      description: "Multi-channel registration"
      supported_by: ["adr-001", "adr-003"]
      business_goal: "bg-001"
      
    adr-001:
      title: "Microservices architecture"
      purpose: "Enable horizontal scaling"
      supports: ["fr-001", "fr-002"]
      
  validation_result:
    complete_bipartite: true
    isolated_nodes: []
    orphan_frs: []
    orphan_adrs: []
    p1_compliant: true
    
  impact_analysis:
    if_bg_001_changes:
      affected_adrs: ["adr-001", "adr-003"]
      affected_frs: ["fr-001", "fr-002"]
```

## Integration with Aether.go Methodology

- **Input from**: value-decomposer (functional requirements), architecture-decision-recorder (ADRs)
- **Output to**: constitution-guardian (P1 compliance verification)
- **Validates with**: consistency-checker (cross-layer consistency)
- **Part of**: D1 Value Derivation Domain (L1 → L2 validation)

## Validation Rules

- Every ADR MUST have at least one `supports` link
- Every FR MUST have at least one `supported_by` link
- No isolated nodes allowed in bipartite graph
- Every ADR MUST document business purpose
- Matrix MUST be bidirectional (forward + backward traceability)
