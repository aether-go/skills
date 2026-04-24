---
name: test-pyramid-deriver
description: Use when deriving test stratification plans from GWT acceptance criteria, establishing the L3 to L4 derivation bridge with boundary identification and META-005 redundancy validation
---

# Test Pyramid Deriver

## Overview
Derive test stratification plans from L3 GWT (Given-When-Then) acceptance criteria, establishing the critical L3->L4 derivation bridge in the Aether five-layer derivation model. Identifies system boundaries and maps acceptance criteria to appropriate test layers (L2-L5), with built-in META-005 redundancy validation support.

## When to Use

```
GWT acceptance criteria defined? ────────┐
                                         │
Need test stratification plan? ──────────┤
                                         ├─► Use test-pyramid-deriver
L3 -> L4 derivation needed? ─────────────┤
                                         │
Test pyramid analysis required? ─────────┘
```

Use when:
- GWT acceptance criteria are defined and need test layer mapping
- Need to derive test stratification from specifications
- Following Aether.go methodology five-layer derivation model (L3->L4)
- Need to identify system boundaries for testing
- Preparing input for test generators (unit, integration, contract, e2e, system)

Don't use when:
- Tests already exist and are validated
- Only running existing tests (use test-pyramid-analyzer instead)
- Acceptance criteria are not yet defined (use bdd-scenario-writer first)

## Core Pattern

### L3 -> L4 Derivation Model

```
L3: GWT Acceptance Criteria (Acceptance Standard Layer)
    ├── AC-001: Given user is on login page, When enters valid credentials, Then login succeeds
    ├── AC-002: Given user is logged in, When clicks logout, Then session is cleared
    └── AC-003: Given 1000 concurrent users, When accessing API, Then response time < 200ms
         |
         v
    Test Pyramid Derivation
         |
         v
L4: Test Stratification Plan (Component Contract Layer)
    ├── User-System Boundary → E2E Tests (4%)
    ├── System-External Service Boundary → Contract Tests (10%)
    ├── System Internal Component Boundary → Integration Tests (15%)
    └── Global Attributes → System Tests (1%)
         |
         v
L5: Unit Tests (70%) derived from internal logic
```

### Derivation Rules

```
L3: GWT Scenarios AC
    ├── test-pyramid-deriver ──→ Test Stratification Plan TP
    ├── META-005: meta-skeptic challenges boundary rationality
    ├── test-pyramid-deriver explicitizes boundary rationale
    └── test-pyramid-validator ──→ Proportion compliance check
```

### Boundary Identification

| Boundary Type | Derivation Source | Test Layer | Target % |
|--------------|-------------------|------------|----------|
| **User-System Boundary** | End-to-end user scenarios | E2E Tests | 4% |
| **System-External Service Boundary** | External dependency interfaces | Contract Tests | 10% |
| **System Internal Component Boundary** | Component collaboration scenarios | Integration Tests | 15% |
| **Global Attributes** | NFR specifications | System Tests | 1% |
| **Internal Logic** | Business logic, algorithms | Unit Tests | 70% |

### Before (Without Test Stratification)
```yaml
acceptance_criteria:
  - ac-001: "Given user enters valid credentials, When clicks login, Then access is granted"
  - ac-002: "Given invalid password, When login attempted, Then error is shown"
  - ac-003: "Given 1000 users, When accessing API, Then response < 200ms"

team_approach:
  - "Write one E2E test per AC"
  - "Maybe add some unit tests"
  
result:
  - 3 E2E tests (too many, slow)
  - 2 unit tests (insufficient)
  - No contract tests (missing service boundaries)
  - No performance tests (NFR not validated)
  - Test suite runs in 30 minutes
```

### After (With Test Stratification)
```yaml
acceptance_criteria:
  - ac-001: "Given user enters valid credentials, When clicks login, Then access is granted"
  - ac-002: "Given invalid password, When login attempted, Then error is shown"
  - ac-003: "Given 1000 users, When accessing API, Then response < 200ms"

test_stratification_plan:
  derived_from: [ac-001, ac-002, ac-003]
  
  l5_unit_tests:
    - id: "ut-auth-001"
      description: "Validate credential verification logic"
      derived_from: "ac-001"
      boundary: "internal_logic"
      target_percentage: 70
      
    - id: "ut-auth-002"
      description: "Validate password validation rules"
      derived_from: "ac-002"
      boundary: "internal_logic"
      target_percentage: 70
      
  l4_contract_tests:
    - id: "ct-auth-001"
      description: "Verify auth API contract with user service"
      derived_from: "ac-001"
      boundary: "system-external"
      target_percentage: 10
      
  l4_integration_tests:
    - id: "it-auth-001"
      description: "Verify login flow across auth and session services"
      derived_from: "ac-001"
      boundary: "system-internal"
      target_percentage: 15
      
  l3_acceptance_tests:
    - id: "e2e-auth-001"
      description: "End-to-end login via UI"
      derived_from: "ac-001"
      boundary: "user-system"
      target_percentage: 4
      
  l2_system_tests:
    - id: "st-perf-001"
      description: "Load test API with 1000 concurrent users"
      derived_from: "ac-003"
      boundary: "global-attribute"
      target_percentage: 1

  boundary_rationale:
    user_system: "E2E tests cover only critical user journeys (login, signup, checkout)"
    system_external: "Contract tests validate all 4 external service integrations"
    system_internal: "Integration tests cover auth-session-user data flow"
    global_attribute: "System tests validate NFRs: performance, security, reliability"
    internal_logic: "Unit tests cover all business logic branches and edge cases"
```

## Quick Reference

### Test Derivation Mapping

```
Acceptance Criteria (GWT) - L3
├── Given [Precondition] → L5 Unit Test (state setup)
├── When [Action]
│   ├── System Boundary → L4 Integration Test
│   ├── External Call → L4 Contract Test
│   └── Internal Logic → L5 Unit Test
└── Then [Outcome]
    ├── Observable State → L5 Unit Test
    ├── External Effect → L4 Contract Test
    └── System Response → L4 Integration Test
```

### Five-Layer Test Distribution (Aether.go)

| Layer | Test Type | Target % | Purpose | Derivation Source |
|-------|-----------|----------|---------|-------------------|
| **L5** | Unit Tests | **70%** | Internal state, business logic | Component contracts |
| **L4** | Contract Tests | **10%** | External dependency interfaces | External dependencies |
| **L4** | Integration Tests | **15%** | System boundary interactions | Acceptance criteria |
| **L3** | Acceptance Tests | **4%** | End-to-end user scenarios | GWT specifications |
| **L2** | System Tests | **1%** | Non-functional requirements | Architecture decisions |

**Total L4 (Contract + Integration)**: 25%

## Implementation

### Derivation Process

#### Step 1: Parse Acceptance Criteria
```python
def parse_acceptance_criteria(gwt_scenarios):
    """Parse GWT scenarios into structured testable elements."""
    
    parsed = []
    for scenario in gwt_scenarios:
        elements = {
            'given': extract_preconditions(scenario.given),
            'when': extract_actions(scenario.when),
            'then': extract_outcomes(scenario.then),
            'boundary': classify_boundary(scenario)
        }
        parsed.append(elements)
    
    return parsed
```

#### Step 2: Classify Boundary
```python
def classify_boundary(scenario):
    """Classify which boundary the scenario crosses."""
    
    if is_user_visible(scenario):
        return 'user_system'
    elif is_external_call(scenario):
        return 'system_external'
    elif is_component_collaboration(scenario):
        return 'system_internal'
    elif is_nfr(scenario):
        return 'global_attribute'
    else:
        return 'internal_logic'
```

#### Step 3: Map to Test Layers
```python
def map_to_test_layers(parsed_scenarios):
    """Map parsed scenarios to appropriate test layers."""
    
    stratification_plan = {
        'l5_unit_tests': [],
        'l4_contract_tests': [],
        'l4_integration_tests': [],
        'l3_acceptance_tests': [],
        'l2_system_tests': []
    }
    
    boundary_mapping = {
        'internal_logic': 'l5_unit_tests',
        'system_external': 'l4_contract_tests',
        'system_internal': 'l4_integration_tests',
        'user_system': 'l3_acceptance_tests',
        'global_attribute': 'l2_system_tests'
    }
    
    for scenario in parsed_scenarios:
        layer = boundary_mapping[scenario['boundary']]
        stratification_plan[layer].append(scenario)
    
    return stratification_plan
```

### META-005 Redundancy Validation Support

The test-pyramid-deriver MUST provide explicitized boundary rationale for META-005 validation:

```yaml
boundary_rationale:
  user_system:
    scope: "Only critical user journeys"
    examples: ["login", "signup", "checkout", "payment"]
    exclusion_rationale: "Admin operations covered by integration tests"
    
  system_external:
    scope: "All external service integrations"
    services: ["payment-gateway", "email-service", "sms-provider", "analytics"]
    rationale: "Any API change in these services breaks our system"
    
  system_internal:
    scope: "Cross-component business flows"
    flows: ["auth-session-user", "order-payment-inventory", "notification-delivery"]
    rationale: "These flows involve multiple services and need integration validation"
    
  global_attribute:
    scope: "NFR requirements from architecture decisions"
    nfrs: ["performance", "security", "reliability", "scalability"]
    rationale: "System tests validate architecture-level quality attributes"
```

## Output Format

```yaml
test_stratification_plan:
  plan_id: "tp-20250424-001"
  derived_from: ["ac-001", "ac-002", "ac-003"]
  version: "1.0.0"
  
  l5_unit_tests:
    count: 14
    target_percentage: 70
    tests: []
    
  l4_contract_tests:
    count: 2
    target_percentage: 10
    tests: []
    
  l4_integration_tests:
    count: 3
    target_percentage: 15
    tests: []
    
  l3_acceptance_tests:
    count: 1
    target_percentage: 4
    tests: []
    
  l2_system_tests:
    count: 1
    target_percentage: 1
    tests: []
    
  boundary_rationale:
    user_system: "..."
    system_external: "..."
    system_internal: "..."
    global_attribute: "..."
    
  meta_005_ready: true
```

## Integration with Aether.go Methodology

- **Input from**: bdd-scenario-writer (GWT scenarios), spec-to-scenario (specification scenarios)
- **Output to**: e2e-test-generator, contract-test-generator, integration-test-generator, system-test-generator, unit-test-generator
- **Validates with**: meta-skeptic (META-005 boundary rationality challenge)
- **Part of**: D4 Contract Derivation Domain (L3 -> L4) - MOST CRITICAL

## Validation Rules

- Each acceptance criterion MUST map to at least one test layer
- Boundary classification MUST be explicitized with rationale
- Test percentages MUST sum to 100%
- L5 unit tests MUST be >= 60%
- L4 contract + integration MUST be >= 20%
- META-005 boundary rationale MUST be provided for meta-skeptic validation
