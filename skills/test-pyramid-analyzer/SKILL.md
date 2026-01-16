---
name: test-pyramid-analyzer
description: Use when analyzing test coverage, distribution, and identifying gaps in testing strategy
---

# Test Pyramid Analyzer

## Overview
Analyze project test structure to identify imbalances in the testing pyramid, generate coverage reports, and recommend test type improvements. Ensures healthy testing strategy with appropriate ratios of unit, integration, and E2E tests.

## When to Use

```
Have project with tests? ──────────────────┐
                                         │
Need to assess test quality? ─────────────┤
                                         ├─► Use test-pyramid-analyzer
Project feels slow or fragile? ───────────┤
                                         │
Adding new testing strategy? ────────────┘
```

Use when:
- Evaluating existing test suite health
- Identifying missing test types or coverage gaps
- Planning test strategy for new projects
- Performance issues in test execution (too many slow tests)
- Compliance requires minimum test coverage
- Onboarding to codebase and understanding test structure
- Refactoring and need to verify test protection

Don't use when:
- Writing actual tests (use bdd-scenario-writer or tdd-red-green-refactor)
- Project has no tests yet (use TDD skills to start)
- Analyzing non-code artifacts

## Core Pattern

### The Test Pyramid

```
                    ▲
                   / \                    E2E Tests
                  /   \                  10% - Slow, fragile, expensive
                 /-----\                 Selenium, Cypress, Playwright
                /       \
               / Integration Tests \    20% - Medium speed, medium maintenance
              /   (API, Service)   \    Supertest, Pytest, Postman
             /_____________________\
            / Unit Tests            \   70% - Fast, reliable, cheap
           / (Functions, Classes)   \   Jest, Go test, pytest
          /_________________________\
```

### Before (Imbalanced Pyramid)
```
Project has 100 tests:
- E2E: 60 tests (60%) - Slow, flaky, expensive
- Integration: 30 tests (30%) - Medium cost
- Unit: 10 tests (10%) - Minimal coverage

Issues:
- Test suite runs in 45 minutes
- Flaky tests cause CI failures
- Refactoring is risky
- Business logic not thoroughly tested
```

### After (Balanced Pyramid)
```
Project has 200 tests:
- E2E: 20 tests (10%) - Critical user journeys only
- Integration: 40 tests (20%) - API contracts and service boundaries
- Unit: 140 tests (70%) - All business logic covered

Benefits:
- Test suite runs in 5 minutes
- Reliable CI pipeline
- Safe refactoring
- Fast feedback loop
- Clear test structure
```

## Quick Reference

| Test Level | Speed | Cost | Coverage Focus | Example Tools |
|------------|-------|------|----------------|---------------|
| **Unit** | < 1s | Low | Business logic, algorithms | Jest, Go test, pytest |
| **Integration** | 1-10s | Medium | API contracts, service boundaries | Supertest, Postman, Testify |
| **E2E** | 10-60s | High | Critical user journeys | Cypress, Playwright, Selenium |

### Healthy Pyramid Ratios
- **Unit Tests**: 70-80% of total tests
- **Integration Tests**: 15-20% of total tests
- **E2E Tests**: 5-10% of total tests

### Warning Signs

| Symptom | Issue | Solution |
|---------|-------|----------|
| Test suite > 30 minutes | Too many E2E tests | Replace with integration/unit tests |
| Flaky tests | E2E fragility | Mock external dependencies, add integration tests |
| Can't refactor safely | Insufficient unit tests | Add unit tests for business logic |
| Tests don't catch bugs | Wrong test type for scenario | Add appropriate test level |
| High test maintenance | Testing implementation details | Test behavior, not code structure |

## Implementation

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

#### 4. Generate Pyramid Report

```python
import os
import json
from pathlib import Path

def analyze_test_pyramid(project_root):
    """Analyze test distribution and generate report."""

    results = {
        'unit': {'count': 0, 'files': []},
        'integration': {'count': 0, 'files': []},
        'e2e': {'count': 0, 'files': []},
        'total': 0
    }

    for test_file in Path(project_root).rglob('*.test.*'):
        if 'e2e' in test_file.name.lower() or 'e2e' in str(test_file):
            results['e2e']['files'].append(str(test_file))
            results['e2e']['count'] += 1
        elif 'integration' in test_file.name.lower():
            results['integration']['files'].append(str(test_file))
            results['integration']['count'] += 1
        else:
            results['unit']['files'].append(str(test_file))
            results['unit']['count'] += 1

        results['total'] += 1

    return results

def calculate_ratios(results):
    """Calculate pyramid ratios and recommendations."""
    if results['total'] == 0:
        return {'status': 'no_tests', 'message': 'No tests found'}

    unit_pct = (results['unit']['count'] / results['total']) * 100
    integration_pct = (results['integration']['count'] / results['total']) * 100
    e2e_pct = (results['e2e']['count'] / results['total']) * 100

    return {
        'unit_pct': round(unit_pct, 1),
        'integration_pct': round(integration_pct, 1),
        'e2e_pct': round(e2e_pct, 1),
        'health': 'healthy' if 60 <= unit_pct <= 80 and 5 <= e2e_pct <= 10 else 'unbalanced'
    }
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

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Test inverted pyramid (many E2E, few unit) | Slow, fragile, expensive maintenance | Add unit tests, reduce E2E to critical paths only |
| Testing implementation details | Tests break on refactoring | Test behavior, not code structure |
| No integration tests | Bugs at service boundaries | Add API/integration tests for service contracts |
| Skipping E2E entirely | No end-to-end validation | Add 5-10% E2E for critical user journeys |
| High flaky test rate | CI unreliability, wasted time | Fix or remove flaky tests, stabilize test environment |
| Coverage as only metric | High coverage ≠ quality tests | Combine coverage with test quality review |

### Pyramid Anti-Patterns

**Ice Cream Cone (Inverted Pyramid)**
```
         ▲
        / \
       /   \           ❌ Many E2E tests
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
        / \            ❌ No integration tests
       /   \           Gaps at service boundaries
      /     \          Bugs slip through
     /       \
    /_________\
   /               \
  /                 \
 /     Unit & E2E    \
/_____________________\
```

## Real-World Impact

**Before (Imbalanced):**
- E-commerce site with 80% E2E tests
- Test suite runs in 2 hours
- Daily flaky test rate: 15%
- Developers afraid to refactor
- New feature testing takes days

**After (Balanced):**
- 70% unit, 20% integration, 10% E2E
- Test suite runs in 8 minutes
- Flaky test rate: < 1%
- Safe refactoring with test protection
- New feature testing takes hours

**Result:** 75% reduction in test execution time, 90% reduction in flaky tests, 50% faster feature development.

## Visualization and Reporting

### Generate HTML Report
```python
def generate_pyramid_report(results):
    """Generate visual HTML report of test pyramid."""

    html = f"""
    <html>
    <head><title>Test Pyramid Report</title></head>
    <body>
    <h1>Test Pyramid Analysis</h1>
    <h2>Distribution</h2>
    <ul>
        <li>Unit Tests: {results['unit']['count']} ({results['unit_pct']}%)</li>
        <li>Integration Tests: {results['integration']['count']} ({results['integration_pct']}%)</li>
        <li>E2E Tests: {results['e2e']['count']} ({results['e2e_pct']}%)</li>
    </ul>
    <h2>Status: {results['health'].upper()}</h2>
    </body>
    </html>
    """
    return html
```

### CI Integration
```yaml
# GitHub Actions example
name: Test Pyramid Analysis

on: [push, pull_request]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Analyze Test Pyramid
        run: |
          python scripts/analyze_pyramid.py
      - name: Check Health
        run: |
          if [ "$PYRAMID_HEALTH" != "healthy" ]; then
            echo "⚠️ Test pyramid is unbalanced"
            echo "See recommendations above"
            exit 1
          fi
```

## Integration with Aether.go Methodology

### Pyramid + BMAD Metrics
```
Business Goal → Test Coverage Metric → Pyramid Recommendation
```

Example:
- Business Goal: "Reduce bug rate by 50%"
- BMAD Metric: "Production bugs < 5 per sprint"
- Pyramid Requirement: "80% unit coverage, 20% integration for all services"

### Pyramid + Spec Tracing
Link test files to spec requirements:
```typescript
/**
 * Spec: REQ-PAYMENT-001 - Payment processing
 * Coverage: Unit tests for payment calculation
 * Status: ✅ 95% coverage
 */
test('calculatePaymentTotal', () => {
  expect(calculatePaymentTotal(items, tax, discount)).toBe(expected);
});
```
