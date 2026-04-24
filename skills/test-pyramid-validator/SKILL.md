---
name: test-pyramid-validator
description: Use when validating test suite proportions against the test pyramid model and analyzing test coverage, distribution, and gaps in testing strategy (merged with test-pyramid-analyzer)
---

# Test Pyramid Validator

## Overview
Validate that test suites conform to the proper test pyramid distribution and analyze test structure to identify imbalances, generate coverage reports, and recommend test type improvements. Combines validation (proportion compliance) with analysis (coverage and gap detection). Ensures L5 (unit tests) dominate the pyramid (~70%), followed by L4 (integration + contract tests ~25%), L3 (acceptance tests ~4%), and L2 (system tests ~1%). Validates against Aether.go test pyramid model and reports deviations.

**Note**: This skill has merged with test-pyramid-analyzer capabilities.

## When to Use

```
Test suite created? ──────────────────────────┐
                                              │
Need proportion validation? ────────────────────┤
                                              ├─► Use test-pyramid-validator
After test-pyramid-deriver output? ───────────┤
                                              │
Pre-deployment gate? ─────────────────────────┘
```

Use when:
- After test-pyramid-deriver generates test stratification plan
- Before deployment to validate test distribution
- During code review to check test quality
- After test suite modifications
- Evaluating existing test suite health
- Identifying missing test types or coverage gaps
- Performance issues in test execution (too many slow tests)
- Planning test strategy for new projects

## Core Pattern

### Test Pyramid Distribution (Aether.go Model)

```
                    ┌─────────────────┐
                    │   L2: System    │  ~1%
                    │  (NFR Testing) │
                    └─────────────────┘
                          │
                    ┌─────────────────┐
                    │  L3: Acceptance │  ~4%
                    │   (E2E Tests)   │
                    └─────────────────┘
                          │
        ┌─────────────────┴─────────────────┐
        │       L4: Integration + Contract │  ~25%
        │         (Component Tests)        │
        └─────────────────────────────────┘
                          │
┌─────────────────────────────────────────────────┐
│              L5: Unit Tests                      │  ~70%
│              (Component Logic)                   │
└─────────────────────────────────────────────────┘
```

### Target Proportions

| Layer | Test Type | Target % | Acceptable Range | Purpose |
|-------|-----------|----------|------------------|---------|
| **L5** | Unit Tests | 70% | 60-80% | Internal logic, business rules |
| **L4** | Contract Tests | 10% | 5-15% | External service interfaces |
| **L4** | Integration Tests | 15% | 10-20% | Internal component interactions |
| **L3** | Acceptance Tests | 4% | 2-6% | End-to-end user scenarios |
| **L2** | System Tests | 1% | 0.5-2% | Non-functional requirements |

**Total L4 (Contract + Integration): 25%**

## Validation Rules

### Proportion Compliance

```yaml
validation_rules:
  l5_unit_tests:
    target: 70
    tolerance: ±10
    min_acceptable: 60
    max_acceptable: 80
    
  l4_contract_tests:
    target: 10
    tolerance: ±5
    min_acceptable: 5
    max_acceptable: 15
    
  l4_integration_tests:
    target: 15
    tolerance: ±5
    min_acceptable: 10
    max_acceptable: 20
    
  l3_acceptance_tests:
    target: 4
    tolerance: ±2
    min_acceptable: 2
    max_acceptable: 6
    
  l2_system_tests:
    target: 1
    tolerance: ±0.5
    min_acceptable: 0.5
    max_acceptable: 2
```

### Violation Severity

| Violation Type | Severity | Action Required |
|----------------|----------|-----------------|
| L5 < 50% or > 90% | Critical | Must fix before deploy |
| L5 < 60% or > 80% | High | Should fix |
| L3 > 10% | High | Too many E2E tests |
| L4 > 35% or < 10% | Medium | Review needed |
| L2 > 5% | Medium | Check NFR coverage |

### Anti-Patterns

| Anti-Pattern | Symptom | Problem | Solution |
|--------------|---------|---------|----------|
| **Ice Cream Cone** | Too many E2E, few unit | Slow tests, brittle | Refactor to unit tests |
| **Cupcake** | Many integration, few unit | Mid-level only | Add unit tests |
| **Gold Plating** | System tests > 5% | Over-engineered | Reduce system test scope |
| **Happy Path Only** | No negative tests | Missing edge cases | Add boundary tests |

## Input Schema

```yaml
test_suite:
  project: "auth-service"
  analyzed_at: "2025-04-24T10:00:00Z"
  
  test_counts:
    l5_unit:
      count: 245
      examples:
        - "unit-email-validation"
        - "unit-password-hashing"
        - "unit-session-token"
        
    l4_contract:
      count: 35
      examples:
        - "ct-payment-gateway"
        - "ct-email-service"
        
    l4_integration:
      count: 52
      examples:
        - "it-auth-session"
        - "it-user-profile"
        
    l3_acceptance:
      count: 14
      examples:
        - "e2e-login-flow"
        - "e2e-registration"
        
    l2_system:
      count: 4
      examples:
        - "st-load-test"
        - "st-security-scan"
        
  total_tests: 350
```

## Output Format

```yaml
validation_report:
  report_id: "tpv-20250424-001"
  project: "auth-service"
  analyzed_at: "2025-04-24T10:00:00Z"
  
  actual_distribution:
    l5_unit: {count: 245, percentage: 70.0}
    l4_contract: {count: 35, percentage: 10.0}
    l4_integration: {count: 52, percentage: 14.9}
    l3_acceptance: {count: 14, percentage: 4.0}
    l2_system: {count: 4, percentage: 1.1}
    
  target_distribution:
    l5_unit: 70
    l4_contract: 10
    l4_integration: 15
    l3_acceptance: 4
    l2_system: 1
    
  deviations:
    l5_unit: {actual: 70.0, target: 70, deviation: 0.0, status: "PASS"}
    l4_contract: {actual: 10.0, target: 10, deviation: 0.0, status: "PASS"}
    l4_integration: {actual: 14.9, target: 15, deviation: -0.1, status: "PASS"}
    l3_acceptance: {actual: 4.0, target: 4, deviation: 0.0, status: "PASS"}
    l2_system: {actual: 1.1, target: 1, deviation: +0.1, status: "PASS"}
    
  overall_status: "PASS"
  compliance_score: 1.0  # 0.0 to 1.0
  
  recommendations:
    - "Test distribution conforms to Aether.go pyramid model"
    - "All layers within acceptable tolerance"
    
  warnings: []
```

## Deviation Report Example

```yaml
deviation_report:
  report_id: "tpv-20250424-002"
  project: "legacy-checkout"
  analyzed_at: "2025-04-24T11:00:00Z"
  
  actual_distribution:
    l5_unit: {count: 45, percentage: 22.5}   # PROBLEM
    l4_contract: {count: 20, percentage: 10.0}
    l4_integration: {count: 80, percentage: 40.0}  # PROBLEM
    l3_acceptance: {count: 45, percentage: 22.5}  # PROBLEM
    l2_system: {count: 10, percentage: 5.0}  # PROBLEM
    
  violations:
    - layer: "l5_unit"
      severity: "critical"
      message: "Unit tests only 22.5%, below minimum 60%"
      
    - layer: "l4_integration"
      severity: "high"
      message: "Integration tests 40%, above maximum 20%"
      
    - layer: "l3_acceptance"
      severity: "high"
      message: "Acceptance tests 22.5%, above maximum 6%"
      
  anti_pattern_detected: "ice_cream_cone"
  
  remediation_steps:
    - step: 1
      action: "Identify business logic currently in E2E tests"
      target_tests: ["e2e-cart-add-item", "e2e-cart-remove-item"]
      
    - step: 2
      action: "Extract logic to unit testable functions"
      
    - step: 3
      action: "Write unit tests for extracted logic"
      target_count: 100
      
    - step: 4
      action: "Replace E2E coverage with unit + integration"
      
    - step: 5
      action: "Re-validate with test-pyramid-validator"
      
  estimated_effort: "8 hours"
  compliance_score: 0.45
```

## Integration with test-pyramid-deriver

```
test-pyramid-deriver outputs plan
    │
    ├── Plan includes target percentages
    │
    ├── test-pyramid-validator validates plan
    │     │
    │     ├── Check: percentages sum to 100
    │     ├── Check: each layer in acceptable range
    │     └── Check: no anti-patterns in distribution
    │
    ├── If INVALID
    │     └── Return to test-pyramid-deriver for adjustment
    │
    └── If VALID
          └── Proceed to test generators
```

## Integration with Aether.go Methodology

- **Input from**: test-pyramid-deriver (test stratification plan)
- **Output to**: test generators (validation feedback)
- **Validates with**: consistency-checker (pyramid model consistency)
- **Part of**: D4 Contract Derivation Domain

## Coverage Analysis (Merged from test-pyramid-analyzer)

### Analysis Workflow

#### 1. Discover Test Files
```bash
# Find all test files
find . -name "*.test.ts" -o -name "*_test.go" -o -name "test_*.py" -o -name "*.spec.js"

# Count by type
find . -name "*.e2e.test.ts" | wc -l     # E2E tests
find . -name "*.integration.test.ts" | wc -l  # Integration tests
find . -name "*.unit.test.ts" -o -name "*.test.ts" | wc -l  # Unit tests
```

#### 2. Measure Test Execution Time
```bash
# Run tests with timing
npm test -- --reporter=json --reporter-options=output=test-results.json

# Parse for slow tests
jq '.testResults[] | select(.duration > 10000) | {name: .name, duration: .duration}' test-results.json
```

#### 3. Analyze Coverage
```go
// Generate coverage report
go test ./... -coverprofile=coverage.out

// View coverage in browser
go tool cover -html=coverage.out

// Check coverage by package
go test ./... -cover | grep -v "no test files"
```

### Coverage Analysis by Language

#### JavaScript/TypeScript
```bash
# Istanbul/Nyc coverage
npm test -- --coverage --coverageReporters=json --coverageReporters=html

# Target: > 80% overall coverage
npx nyc check-coverage --lines 80 --functions 80 --branches 80
```

#### Go
```bash
# Generate coverage report
go test -coverprofile=coverage.out ./...

# Check coverage threshold
go test -coverprofile=coverage.out ./... && \
  go tool cover -func=coverage.out | \
  grep total | \
  awk '{if ($3+0 < 80) exit 1}'
```

#### Python
```bash
# Pytest with coverage
pytest --cov=src --cov-report=html --cov-report=term-missing

# Target: > 80% coverage
pytest --cov=src --cov-fail-under=80
```

### Recommendations Engine

```python
def generate_recommendations(results, coverage_data):
    """Generate test strategy recommendations based on analysis."""
    recommendations = []

    # Check pyramid ratios
    if results['unit_pct'] < 60:
        recommendations.append({
            'priority': 'HIGH',
            'category': 'Increase Unit Tests',
            'action': 'Add unit tests for business logic and algorithms',
            'target': f'Increase unit tests from {results["unit_pct"]}% to 70%'
        })

    if results['e2e_pct'] > 15:
        recommendations.append({
            'priority': 'HIGH',
            'category': 'Reduce E2E Tests',
            'action': 'Replace non-critical E2E tests with integration or unit tests',
            'target': f'Reduce E2E tests from {results["e2e_pct"]}% to 10%'
        })

    if coverage_data['overall_coverage'] < 80:
        recommendations.append({
            'priority': 'MEDIUM',
            'category': 'Improve Coverage',
            'action': f'Add tests for uncovered code paths',
            'target': f'Achieve 80% coverage (currently {coverage_data["overall_coverage"]}%)'
        })

    return recommendations
```

### Pyramid Anti-Patterns

**Ice Cream Cone (Inverted Pyramid)**
```
     ▲
    / \
   /   \           Many E2E tests
  /     \          Slow, expensive, fragile
 /       \         Hard to maintain
/_________\
/   Integration  \
/_________________\
/      Unit         \
/_____________________\
```

**Hourglass (Missing Integration)**
```
     ▲
    / \            No integration tests
   /   \           Gaps at service boundaries
  /     \          Bugs slip through
 /       \
/_________\
/               \
/                 \
/     Unit & E2E    \
/_____________________\
```

## Quality Gates

- Test percentages MUST sum to 100%
- L5 unit tests MUST be >= 60%
- L5 unit tests MUST be <= 80%
- L4 (contract + integration) MUST be >= 20%
- L4 (contract + integration) MUST be <= 35%
- L3 acceptance tests MUST be <= 6%
- L2 system tests MUST be <= 2%
- No "ice cream cone" or "cupcake" anti-patterns
