---
name: spec-to-scenario
description: Use when converting structured system specifications into GWT (Given-When-Then) acceptance scenarios for L2 to L3 derivation in Aether methodology
---

# Spec to Scenario Converter

## Overview
Convert structured system specifications into GWT (Given-When-Then) acceptance scenarios. Establishes the L2→L3 derivation bridge in Aether five-layer model, ensuring every specification maps to at least one testable acceptance scenario covering both positive and negative paths.

## When to Use

```
System specifications defined? ────────────────┐
                                              │
Need acceptance test scenarios? ───────────────┤
                                              ├─► Use spec-to-scenario
L2 -> L3 derivation needed? ─────────────────┤
                                              │
Preparing for bdd-scenario-writer? ───────────┘
```

Use when:
- Converting system specifications to acceptance criteria
- Following L2→L3 derivation in five-layer model
- Preparing input for bdd-scenario-writer or test-pyramid-deriver
- Ensuring specification completeness through scenario coverage

Don't use when:
- GWT scenarios already exist
- Only need to write code (use tdd-cycle-runner)
- Specifications are not yet defined (use spec-parser first)

## Core Pattern

### L2→L3 Derivation Model

```
L2: System Specifications
    ├── SPEC-001: User registration with email validation
    ├── SPEC-002: User login with password verification
    └── SPEC-003: Password reset via email
         │
         │ spec-to-scenario
         ▼
L3: GWT Acceptance Scenarios
    ├── Scenario: Valid email registration
    ├── Scenario: Invalid email format rejected
    ├── Scenario: Valid login succeeds
    ├── Scenario: Invalid password fails
    ├── Scenario: Password reset flow
    └── Scenario: Expired reset token handled
```

### Derivation Rules

```
Specification
    │
    ├── Identify actors and system
    ├── Extract preconditions (Given)
    ├── Extract actions (When)
    ├── Extract expected outcomes (Then)
    │
    ▼
GWT Scenario
    ├── Given: Precondition setup
    ├── When: Action to perform
    └── Then: Observable outcome
```

### Scenario Coverage Matrix

```
Specification
    │
    ├── Positive Path Coverage
    │     └── Main success scenario
    │
    ├── Negative Path Coverage
    │     ├── Invalid input handling
    │     ├── Missing required fields
    │     └── Unauthorized access
    │
    └── Edge Case Coverage
          ├── Boundary values
          ├── Concurrent operations
          └── System resource limits
```

### Before (Without Spec-to-Scenario)
```yaml
specification:
  - id: "SPEC-001"
    description: "User registration"
    
team_approach:
  - "Read spec and implement"
  - "Write some tests"
  
result:
  - Ambiguous interpretation of spec
  - Missing edge cases
  - Inconsistent test coverage
  - No traceability to spec
```

### After (With Spec-to-Scenario)
```yaml
specification:
  - id: "SPEC-001"
    description: "User registration"
    
scenarios:
  - id: "SC-001"
    type: "positive"
    gwt:
      given: "User is on registration page"
      when: "User submits valid email and password"
      then: "Account is created and confirmation shown"
    derived_from: "SPEC-001"
    
  - id: "SC-002"
    type: "negative"
    gwt:
      given: "User is on registration page"
      when: "User submits invalid email format"
      then: "Error message shown and account not created"
    derived_from: "SPEC-001"
    
coverage:
  positive_path: true
  negative_path: true
  edge_cases: true
```

## Quick Reference

### GWT Template

```
功能: [Feature Name]
  场景: [Scenario Name]
    给定 [Precondition]
    当 [Action]
    那么 [Outcome]
    而且 [Additional Outcome]  # optional
```

### Scenario Types

| Type | Purpose | Example |
|------|---------|---------|
| **positive** | Main success path | Valid login succeeds |
| **negative** | Error handling | Invalid password rejected |
| **boundary** | Edge conditions | Empty string, max length |
| **concurrent** | Parallel operations | Simultaneous edits |
| **recovery** | Error recovery | Session timeout handling |

### Coverage Rules

- Every SPEC MUST have at least 1 positive scenario
- Every SPEC MUST have at least 1 negative scenario
- Every input constraint MUST have a boundary test
- Every error condition MUST have a scenario

## Implementation

### Scenario Derivation Process

```python
class SpecToScenarioConverter:
    def __init__(self, specifications):
        self.specs = specifications
        self.scenarios = []
        
    def derive_scenarios(self):
        """Derive GWT scenarios from specifications."""
        
        for spec in self.specs:
            # Positive path scenario
            self.scenarios.append(self.derive_positive(spec))
            
            # Negative path scenarios
            for constraint in spec.constraints:
                self.scenarios.append(self.derive_negative(spec, constraint))
                
            # Boundary scenarios
            for boundary in spec.boundaries:
                self.scenarios.append(self.derive_boundary(spec, boundary))
                
        return self.scenarios
    
    def derive_positive(self, spec):
        """Derive main success scenario."""
        return {
            'id': f"SC-{spec.id}-positive",
            'type': 'positive',
            'given': self.extract_preconditions(spec),
            'when': spec.action,
            'then': spec.expected_outcome,
            'derived_from': spec.id
        }
    
    def derive_negative(self, spec, constraint):
        """Derive negative test scenario."""
        return {
            'id': f"SC-{spec.id}-neg-{constraint.id}",
            'type': 'negative',
            'given': spec.precondition,
            'when': f"User provides {constraint.description}",
            'then': f"System rejects with {constraint.error}",
            'derived_from': spec.id
        }
    
    def derive_boundary(self, spec, boundary):
        """Derive boundary test scenario."""
        return {
            'id': f"SC-{spec.id}-bound-{boundary.id}",
            'type': 'boundary',
            'given': spec.precondition,
            'when': f"User provides {boundary.value}",
            'then': boundary.expected_behavior,
            'derived_from': spec.id
        }
```

## Output Format

```yaml
spec_to_scenario_conversion:
  conversion_id: "sc-20250424-001"
  specs_processed: 3
  scenarios_generated: 12
  
  scenario_catalog:
    - id: "SC-001"
      type: "positive"
      gwt:
        given: "User is on registration page with valid data"
        when: "User submits email 'user@example.com' and password 'SecurePass123'"
        then: "Account is created successfully"
        and: "Confirmation email is sent to user"
      derived_from: "SPEC-001"
      coverage: "positive_path"
      
    - id: "SC-002"
      type: "negative"
      gwt:
        given: "User is on registration page"
        when: "User submits email 'invalid-email'"
        then: "Error message 'Invalid email format' is displayed"
        and: "Account is not created"
      derived_from: "SPEC-001"
      coverage: "negative_path"
      
    - id: "SC-003"
      type: "boundary"
      gwt:
        given: "User is on registration page"
        when: "User submits password with exactly 8 characters 'Pass1234'"
        then: "Password is accepted"
        and: "Account is created"
      derived_from: "SPEC-001"
      coverage: "boundary_min_length"
      
  coverage_report:
    total_specs: 3
    specs_fully_covered: 3
    positive_coverage: 100
    negative_coverage: 85
    boundary_coverage: 70
    
  traceability:
    SPEC-001: [SC-001, SC-002, SC-003]
    SPEC-002: [SC-004, SC-005]
    SPEC-003: [SC-006, SC-007]
```

## Integration with Aether.go Methodology

- **Input from**: spec-parser (structured specifications)
- **Output to**: bdd-scenario-writer (GWT formatting), test-pyramid-deriver (test layer mapping)
- **Validates with**: completeness-checker (scenario coverage)
- **Part of**: D3 Specification Derivation Domain (L2 → L3)

## Validation Rules

- Every specification MUST have at least one positive scenario
- Every specification MUST have at least one negative scenario
- Every constraint MUST have corresponding negative scenario
- Every boundary value MUST have a boundary scenario
- Scenario MUST use GWT format (Given-When-Then)
- Scenario MUST be traceable to source specification
