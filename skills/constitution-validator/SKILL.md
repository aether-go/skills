---
name: constitution-validator
description: Use when validating that code and specifications comply with architectural principles and constitutional constraints
---

# Constitution Validator

## Overview
Validate that code, specifications, and architectural decisions comply with the project's constitutional principles and quality standards. Enforces consistency and prevents architectural drift.

## When to Use

```
Code review needed? ────────────────────┐
                                        │
New architecture decision? ──────────────┤
                                        ├─► Use constitution-validator
PR ready to merge? ──────────────────────┤
                                        │
Compliance audit required? ──────────────┘
```

Use when:
- Reviewing pull requests
- Validating architectural decisions
- Conducting compliance audits
- Onboarding new developers
- Setting up CI validation gates
- Reviewing specifications

Don't use when:
- Writing code (use IDE/Editor)
- Simple style checks (use linters)
- Performance profiling

## Core Pattern

### Constitutional Principles

```markdown
## Project Constitution

### 1. Simplicity
- Code must be readable by developers 6 months later
- Avoid premature optimization
- Use standard libraries when possible

### 2. Testability
- All features must have tests
- Code should be testable without mocks for complexity
- Integration tests for service boundaries

### 3. Security First
- Validate all inputs
- Never log sensitive data
- Use parameterized queries

### 4. Performance
- API responses < 500ms P95
- Database queries < 100ms
- Page load < 3 seconds

### 5. Observability
- All errors logged with context
- Metrics for business KPIs
- Distributed tracing for requests

### 6. Modularity
- Single responsibility per module
- Clear interfaces between components
- Dependencies minimal and explicit
```

### Validation Process

```yaml
validation:
  scope:
    - code_review
    - spec_review
    - architecture_decision

  checks:
    - name: "Simplicity Check"
      rule: "Function complexity < 10"
      severity: "warning"

    - name: "Testability Check"
      rule: "Coverage > 80%"
      severity: "error"

    - name: "Security Check"
      rule: "No SQL injection vulnerabilities"
      severity: "critical"

    - name: "Performance Check"
      rule: "API response time < 500ms"
      severity: "error"

  report:
    format: "markdown"
    output: "validation-report.md"
```

## Implementation

### Validation Rules

```python
def validate_against_constitution(code, constitution):
    """Validate code against constitutional principles."""

    violations = []

    for principle in constitution.principles:
        if principle.name == "Testability":
            if calculate_coverage(code) < 0.8:
                violations.append({
                    'principle': 'Testability',
                    'rule': 'Coverage > 80%',
                    'severity': 'error',
                    'actual': f'{calculate_coverage(code)*100:.1f}%'
                })

        elif principle.name == "Simplicity":
            complexity = calculate_complexity(code)
            if complexity > 10:
                violations.append({
                    'principle': 'Simplicity',
                    'rule': 'Complexity < 10',
                    'severity': 'warning',
                    'actual': str(complexity)
                })

    return violations
```

### Automated CI Gate

```yaml
# .github/workflows/constitution-check.yaml
name: Constitution Validation

on: [pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Check Testability
        run: |
          coverage=$(npm test -- --coverage --silent | grep "All files" | awk '{print $4}' | sed 's/%//')
          if (( $(echo "$coverage < 80" | bc -l) )); then
            echo "❌ Coverage $coverage% below 80% threshold"
            exit 1
          fi

      - name: Check Security
        run: |
          npm audit --audit-level=high

      - name: Check Complexity
        run: |
          eslint --rule complexity: ['error', 10]
```

### Validation Report

```markdown
# Constitution Validation Report

**Date:** 2026-01-16
**Scope:** PR #1234 - Password Reset Feature

## Summary
| Principle | Status | Violations |
|-----------|---------|------------|
| Simplicity | ✅ Pass | 0 |
| Testability | ❌ Fail | 2 |
| Security | ✅ Pass | 0 |
| Performance | ⚠️ Warning | 1 |

## Testability Violations

### Violation 1: Coverage Below Threshold
- **Rule:** Coverage > 80%
- **Actual:** 72.5%
- **Files Affected:**
  - `src/services/password-reset.ts` (65%)
  - `src/utils/token-generator.ts` (50%)
- **Action Required:** Add tests for missing code paths

### Violation 2: Untested Edge Cases
- **Rule:** All error paths tested
- **Actual:** Missing tests for email service failure
- **Files Affected:** `src/services/email-service.ts`
- **Action Required:** Add test for email service error handling

## Performance Warning

### Warning 1: Slow Database Query
- **Rule:** Query time < 100ms
- **Actual:** 150ms average
- **Query:** `SELECT * FROM users WHERE email = ?`
- **Action Recommended:** Add index on email column

## Conclusion
**Cannot merge.** Fix testability violations before PR approval.
```

### Constitution Principles Template

```markdown
# Project Constitution

## Principles

### P1: [Principle Name]
**Description:** What this principle means

**Rules:**
- [ ] Specific rule 1
- [ ] Specific rule 2
- [ ] Specific rule 3

**Examples:**
- ✅ Good example following principle
- ❌ Bad example violating principle

**Checks:**
- Automated: Linter rules, CI gates
- Manual: Code review checklist items
```
