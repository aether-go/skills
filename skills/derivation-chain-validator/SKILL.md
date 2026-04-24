---
name: derivation-chain-validator
description: Use when validating the integrity of the derivation chain (L1-L5) and detecting gaps or inconsistencies in the five-layer derivation model
---

# Derivation Chain Validator

## Overview
Validate the integrity of the five-layer derivation chain (L1-L5) and detect gaps or inconsistencies. Ensures that each layer's outputs properly derive from the previous layer's outputs, maintaining the structural integrity of the Aether methodology.

## When to Use

```
Derivation chain established? ───────────┐
                                         │
Need to validate integrity? ─────────────┤
                                         ├─► Use derivation-chain-validator
Gaps detected in derivation? ────────────┤
                                         │
L1-L5 consistency check needed? ─────────┘
```

Use when:
- Derivation chain is established and needs validation
- Gaps are suspected between layers
- L1-L5 consistency needs verification
- Following Aether.go five-layer derivation model
- Preparing for architecture self-audit

Don't use when:
- Only single layer needs validation
- Derivation chain is not yet established
- Only code quality needs checking

## Core Pattern

### Derivation Chain Validation

```
L1: Business Goals
    ├── Validate: Goals are quantified and measurable
    ├── Validate: Goals have business value mapping
    └── Validate: Goals have stakeholder approval
         |
         v
L2: Functional Requirements
    ├── Validate: Each FR traces to at least one BG
    ├── Validate: FRs are measurable and testable
    └── Validate: FRs have acceptance criteria
         |
         v
L3: GWT Acceptance Criteria
    ├── Validate: Each AC traces to at least one FR
    ├── Validate: ACs cover happy path and edge cases
    └── Validate: ACs have test stratification
         |
         v
L4: Test Stratification + Interface Contracts
    ├── Validate: Tests map to ACs
    ├── Validate: Interfaces define contracts
    └── Validate: Contracts have pre/post conditions
         |
         v
L5: Implementation Code
    ├── Validate: Code implements interfaces
    ├── Validate: Tests pass
    └── Validate: Code traces to requirements
```

### Validation Rules

| Layer | Validation Focus | Pass Criteria |
|-------|-----------------|---------------|
| **L1** | Business goal clarity | Quantified, measurable, approved |
| **L2** | Requirement traceability | Each FR traces to BG, has AC |
| **L3** | Scenario coverage | Each AC traces to FR, covers edges |
| **L4** | Contract completeness | Tests map to ACs, interfaces defined |
| **L5** | Implementation alignment | Code implements contracts, tests pass |

### Cross-Layer Validation

```
L1 -> L2: Each BG must have >= 1 FR
L2 -> L3: Each FR must have >= 1 AC
L3 -> L4: Each AC must map to >= 1 test layer
L4 -> L5: Each interface must have implementation
L5 -> L1: Each code change must trace to BG
```

### Before (Without Derivation Validation)
```yaml
project:
  business_goals: ["Improve user experience"]
  
  functional_requirements:
    - fr-001: "Add dark mode"
    - fr-002: "Optimize database queries"
    
  acceptance_criteria:
    - ac-001: "User can toggle dark mode"
    
  tests:
    - test-001: "Dark mode toggle works"
    
  code:
    - "implemented dark mode"

issues:
  - "Improve user experience" is not quantified (L1 gap)
  - FR-002 has no acceptance criteria (L2-L3 gap)
  - No tests for database optimization (L3-L4 gap)
  - No interface contracts defined (L4 gap)
  - Cannot trace code changes to business goals (L5-L1 gap)
```

### After (With Derivation Validation)
```yaml
project:
  business_goals:
    - bg-001: "Reduce page load time to < 2 seconds"
    - bg-002: "Increase user engagement by 20%"
    
  functional_requirements:
    - fr-001: "Implement dark mode toggle"
      traces_to: bg-002
      acceptance_criteria: [ac-001, ac-002]
      
    - fr-002: "Optimize database query performance"
      traces_to: bg-001
      acceptance_criteria: [ac-003, ac-004]
      
  acceptance_criteria:
    - ac-001: "Given user is on settings page, When toggles dark mode, Then theme changes immediately"
    - ac-002: "Given dark mode enabled, When page reloads, Then preference persists"
    - ac-003: "Given 1000 concurrent users, When accessing dashboard, Then response time < 2s"
    - ac-004: "Given large dataset, When querying reports, Then results return in < 5s"
    
  test_stratification:
    - ac-001: {layer: "e2e", tests: ["e2e-dark-mode-toggle"]}
    - ac-002: {layer: "unit", tests: ["unit-theme-persistence"]}
    - ac-003: {layer: "system", tests: ["st-load-test-dashboard"]}
    - ac-004: {layer: "integration", tests: ["it-report-query-performance"]}
    
  interfaces:
    - ic-001: "ThemeService"
    - ic-002: "ReportQueryService"
    
  code:
    - "ThemeServiceImpl implements ThemeService"
    - "ReportQueryServiceImpl implements ReportQueryService"

validation:
  l1: "PASS - Goals are quantified"
  l2: "PASS - All FRs trace to BGs"
  l3: "PASS - All ACs trace to FRs"
  l4: "PASS - All ACs map to test layers"
  l5: "PASS - All interfaces have implementations"
  cross_layer: "PASS - Complete traceability from L5 to L1"
```

## Quick Reference

### Derivation Chain Health Metrics

| Metric | Target | Description |
|--------|--------|-------------|
| **Traceability Coverage** | > 95% | % of artifacts that trace to parent layer |
| **Gap Count** | 0 | Number of unmapped artifacts between layers |
| **Orphan Count** | 0 | Number of artifacts with no parent or child |
| **Cycle Count** | 0 | Number of circular dependencies |
| **Depth Variance** | < 2 | Variance in derivation chain depth |

### Common Gap Patterns

| Gap Pattern | Detection | Resolution |
|-------------|-----------|------------|
| **Orphan Business Goal** | BG with no FRs | Decompose into FRs or remove |
| **Orphan Requirement** | FR with no ACs | Write acceptance criteria |
| **Orphan Test** | Test with no AC | Map to acceptance criteria |
| **Missing Implementation** | Interface with no impl | Implement or remove |
| **Circular Dependency** | A -> B -> A | Refactor to remove cycle |
| **Deep Nesting** | > 5 layers | Flatten or restructure |

## Implementation

### Validation Engine

```python
class DerivationChainValidator:
    def __init__(self, derivation_chain):
        self.chain = derivation_chain
        self.gaps = []
        self.issues = []
        
    def validate(self):
        """Validate complete derivation chain."""
        
        # Validate each layer
        self.validate_l1()
        self.validate_l2()
        self.validate_l3()
        self.validate_l4()
        self.validate_l5()
        
        # Validate cross-layer traceability
        self.validate_cross_layer()
        
        return {
            'valid': len(self.gaps) == 0,
            'gaps': self.gaps,
            'issues': self.issues,
            'metrics': self.calculate_metrics()
        }
    
    def validate_l1(self):
        """Validate business goals layer."""
        
        for goal in self.chain.l1_business_goals:
            if not goal.is_quantified:
                self.issues.append({
                    'layer': 'L1',
                    'type': 'not_quantified',
                    'item': goal.id,
                    'message': f"Goal {goal.id} is not quantified"
                })
            
            if not goal.has_stakeholder_approval:
                self.issues.append({
                    'layer': 'L1',
                    'type': 'not_approved',
                    'item': goal.id,
                    'message': f"Goal {goal.id} lacks stakeholder approval"
                })
    
    def validate_cross_layer(self):
        """Validate cross-layer traceability."""
        
        # L1 -> L2: Each BG must have >= 1 FR
        for goal in self.chain.l1_business_goals:
            frs = self.chain.get_frs_for_goal(goal.id)
            if len(frs) == 0:
                self.gaps.append({
                    'from_layer': 'L1',
                    'to_layer': 'L2',
                    'type': 'missing_derivation',
                    'item': goal.id,
                    'message': f"Goal {goal.id} has no functional requirements"
                })
        
        # L2 -> L3: Each FR must have >= 1 AC
        for fr in self.chain.l2_functional_requirements:
            acs = self.chain.get_acs_for_fr(fr.id)
            if len(acs) == 0:
                self.gaps.append({
                    'from_layer': 'L2',
                    'to_layer': 'L3',
                    'type': 'missing_derivation',
                    'item': fr.id,
                    'message': f"FR {fr.id} has no acceptance criteria"
                })
        
        # L3 -> L4: Each AC must map to test layer
        for ac in self.chain.l3_acceptance_criteria:
            tests = self.chain.get_tests_for_ac(ac.id)
            if len(tests) == 0:
                self.gaps.append({
                    'from_layer': 'L3',
                    'to_layer': 'L4',
                    'type': 'missing_derivation',
                    'item': ac.id,
                    'message': f"AC {ac.id} has no test mapping"
                })
        
        # L4 -> L5: Each interface must have implementation
        for interface in self.chain.l4_interfaces:
            impl = self.chain.get_implementation_for_interface(interface.id)
            if not impl:
                self.gaps.append({
                    'from_layer': 'L4',
                    'to_layer': 'L5',
                    'type': 'missing_implementation',
                    'item': interface.id,
                    'message': f"Interface {interface.id} has no implementation"
                })
    
    def calculate_metrics(self):
        """Calculate derivation chain health metrics."""
        
        total_artifacts = (
            len(self.chain.l1_business_goals) +
            len(self.chain.l2_functional_requirements) +
            len(self.chain.l3_acceptance_criteria) +
            len(self.chain.l4_tests) +
            len(self.chain.l5_implementations)
        )
        
        traced_artifacts = total_artifacts - len(self.gaps)
        
        return {
            'traceability_coverage': traced_artifacts / total_artifacts,
            'gap_count': len(self.gaps),
            'orphan_count': len(self.issues),
            'cycle_count': self.detect_cycles(),
            'depth_variance': self.calculate_depth_variance()
        }
```

## Output Format

```yaml
derivation_validation:
  validation_id: "dv-20250424-001"
  project: "user-management-system"
  
  layer_validations:
    l1:
      status: "PASS"
      goals_count: 3
      quantified: 3
      approved: 3
      
    l2:
      status: "PASS"
      frs_count: 8
      traced_to_goals: 8
      with_acs: 8
      
    l3:
      status: "WARNING"
      acs_count: 12
      traced_to_frs: 11
      with_test_mapping: 12
      issues:
        - ac_id: "ac-007"
          issue: "Not traced to any functional requirement"
          
    l4:
      status: "PASS"
      tests_count: 15
      mapped_to_acs: 12
      interfaces_count: 5
      with_contracts: 5
      
    l5:
      status: "PASS"
      implementations_count: 5
      implement_interfaces: 5
      tests_passing: 15
      
  cross_layer:
    status: "WARNING"
    gaps:
      - from_layer: "L2"
        to_layer: "L3"
        type: "missing_derivation"
        item: "fr-005"
        message: "FR-005 has no acceptance criteria"
        
  metrics:
    traceability_coverage: 0.97
    gap_count: 1
    orphan_count: 1
    cycle_count: 0
    depth_variance: 1.2
    
  recommendations:
    - "Add acceptance criteria for FR-005"
    - "Trace AC-007 to appropriate functional requirement"
```

## Integration with Aether.go Methodology

- **Input from**: context-manager (derivation matrix), all D1-D5 skills
- **Output to**: architecture-self-auditor (audit data), adjustment-proposer (gap fixes)
- **Validates with**: correctness-checker (validation accuracy)
- **Part of**: D8 Meta-Capability Domain (META-001)

## Validation Rules

- Each layer MUST validate independently
- Cross-layer traceability MUST be > 95%
- Gap count MUST be 0 for PASS status
- Orphan count SHOULD be 0
- Cycle count MUST be 0
- Depth variance SHOULD be < 2
