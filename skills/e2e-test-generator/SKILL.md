---
name: e2e-test-generator
description: Use when generating end-to-end acceptance tests that verify complete user journeys across system boundaries for L3 to L4 derivation validation
---

# E2E Test Generator

## Overview
Generate end-to-end (E2E) acceptance tests that verify complete user journeys across system boundaries. Part of D4 Contract Derivation Domain, these tests validate the User-System boundary at L4, ensuring complete business flows work as expected from user's perspective.

## When to Use

```
Complete user journey defined? ───────────────┐
                                              │
Need E2E test coverage? ──────────────────────┤
                                              ├─► Use e2e-test-generator
L3 -> L4 derivation (user boundary)? ────────┤
                                              │
Validating L3 acceptance criteria? ───────────┘
```

Use when:
- Validating complete user journeys
- Testing User-System boundary (L3→L4)
- Verifying end-to-end business flows
- Preparing for acceptance validation
- Following ATDD methodology

Don't use when:
- Only testing internal component logic (use unit-test-generator)
- Only testing service integrations (use integration-test-generator)
- Only testing API contracts (use contract-test-generator)

## Core Pattern

### E2E Test Coverage (4% of Test Pyramid)

```
Test Pyramid
    ├── L2 System Tests (1%) - NFR validation
    ├── L3 E2E Tests (4%) ← THIS SKILL
    ├── L4 Integration Tests (15%) - Component协作
    ├── L4 Contract Tests (10%) - API契约
    └── L5 Unit Tests (70%) - Business logic
```

### E2E Test Scope

```
User-System Boundary
    │
    ├── UI Interaction Flows
    │     ├── Login → Dashboard → Action → Logout
    │     ├── Browse → Select → Checkout → Confirmation
    │     └── Search → Filter → View → Interact
    │
    ├── Complete Business Scenarios
    │     ├── User registration flow
    │     ├── Order placement and fulfillment
    │     └── Data export and reporting
    │
    └── Cross-Cutting Concerns
          ├── Authentication persistence
          ├── Session management
          └── Error recovery UX
```

### Test Structure

```gherkin
功能: 用户登录
  场景: 成功登录
    给定 用户已在注册页面注册
    当 用户输入正确邮箱和密码
    那么 用户成功登录
    而且 显示用户Dashboard
```

## Quick Reference

### E2E Test Characteristics

| Aspect | Scope |
|--------|-------|
| **Coverage** | Critical user journeys only |
| **Speed** | Slow (minutes per test) |
| **Reliability** | Lower (UI dependencies) |
| **Debugging** | Harder (multiple layers) |
| **Maintenance** | High (UI changes break tests) |

### When to Write E2E Tests

- Critical paths only (login, checkout, etc.)
- After integration tests pass
- For acceptance criteria validation
- For regression prevention

## Implementation

### E2E Test Generator

```python
class E2ETestGenerator:
    def __init__(self, user_journeys, test_framework='playwright'):
        self.journeys = user_journeys
        self.framework = test_framework
        self.tests = []
        
    def generate_tests(self):
        """Generate E2E tests from user journeys."""
        
        for journey in self.journeys:
            test = {
                'id': f"e2e-{journey.id}",
                'name': journey.name,
                'steps': self.generate_steps(journey),
                'assertions': self.generate_assertions(journey)
            }
            self.tests.append(test)
            
        return self.tests
    
    def generate_steps(self, journey):
        """Generate test steps from journey."""
        steps = []
        for action in journey.actions:
            step = {
                'action': action.type,  # click, type, navigate
                'target': action.selector,
                'value': action.value
            }
            steps.append(step)
        return steps
```

## Output Format

```yaml
e2e_test_suite:
  suite_id: "e2e-20250424-001"
  framework: "playwright"
  target_percentage: 4
  
  tests:
    - id: "e2e-login-001"
      name: "User login flow"
      priority: "critical"
      gwt:
        given: "User is on login page"
        when: "User enters valid credentials"
        then: "User is logged in and redirected to dashboard"
      steps:
        - action: "navigate"
          target: "/login"
        - action: "fill"
          target: "#email"
          value: "user@example.com"
        - action: "fill"
          target: "#password"
          value: "SecurePass123"
        - action: "click"
          target: "#login-button"
      assertions:
        - "url contains /dashboard"
        - "#user-menu is visible"
        - "Welcome message appears"
        
    - id: "e2e-checkout-001"
      name: "Complete checkout flow"
      priority: "critical"
      gwt:
        given: "User has items in cart"
        when: "User completes checkout"
        then: "Order is confirmed and email sent"
```

## Integration with Aether.go Methodology

- **Input from**: test-pyramid-deriver (test stratification), bdd-scenario-writer (scenarios)
- **Output to**: test-pyramid-validator (coverage validation)
- **Validates with**: test-pyramid-analyzer (distribution check)
- **Part of**: D4 Contract Derivation Domain (L3 → L4 user boundary)
