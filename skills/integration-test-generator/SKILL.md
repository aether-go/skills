---
name: integration-test-generator
description: Use when generating integration tests that verify component collaboration and data flow across internal system boundaries for L3 to L4 derivation
---

# Integration Test Generator

## Overview
Generate integration tests that verify component collaboration and data flow across internal system boundaries. Part of D4 Contract Derivation Domain, these tests validate System-Internal Component boundary at L4, ensuring modules work together correctly.

## When to Use

```
Component boundaries defined? ─────────────────┐
                                              │
Need integration test coverage? ───────────────┤
                                              ├─► Use integration-test-generator
L3 -> L4 derivation (internal boundary)? ─────┤
                                              │
Verifying component collaboration? ─────────────┘
```

Use when:
- Testing component-to-component interaction
- Validating System-Internal boundary (L3→L4)
- Verifying data flow between modules
- Checking transaction integrity
- Following service-oriented architecture

Don't use when:
- Only testing single component logic (use unit-test-generator)
- Only testing external API contracts (use contract-test-generator)
- Only testing user-facing flows (use e2e-test-generator)

## Core Pattern

### Integration Test Coverage (15% of Test Pyramid)

```
Test Pyramid
    ├── L2 System Tests (1%) - NFR validation
    ├── L3 E2E Tests (4%) - User journeys
    ├── L4 Integration Tests (15%) ← THIS SKILL
    ├── L4 Contract Tests (10%) - External APIs
    └── L5 Unit Tests (70%) - Business logic
```

### Integration Test Scope

```
System-Internal Component Boundary
    │
    ├── Service-to-Service Communication
    │     ├── AuthService → UserService
    │     ├── OrderService → PaymentService
    │     └── InventoryService → NotificationService
    │
    ├── Data Flow Validation
    │     ├── Request → Validation → Processing → Response
    │     ├── Database read/write cycles
    │     └── Cache invalidation
    │
    └── Transaction Boundaries
          ├── ACID transactions across services
          ├── Eventual consistency handling
          └── Distributed saga coordination
```

### Test Focus Areas

| Component Pair | Test Focus | Validation |
|----------------|------------|------------|
| Auth → User | Token propagation | User context available |
| Order → Inventory | Stock reservation | Decrement atomic |
| Payment → Order | Status update | Order state machine |
| Notification → Email | Queue processing | Email dispatched |

## Quick Reference

### Integration vs E2E vs Contract

| Aspect | Integration | E2E | Contract |
|--------|-------------|-----|----------|
| **Scope** | Components | User journeys | APIs |
| **Speed** | Medium | Slow | Fast |
| **Dependencies** | Internal | External | External |
| **Failures** | Module边界 | End-to-end | Interface |

## Implementation

### Integration Test Generator

```python
class IntegrationTestGenerator:
    def __init__(self, component_pairs, test_framework='jest'):
        self.pairs = component_pairs
        self.framework = test_framework
        self.tests = []
        
    def generate_tests(self):
        """Generate integration tests for component pairs."""
        
        for pair in self.pairs:
            test = {
                'id': f"int-{pair.source}-{pair.target}",
                'name': f"{pair.source} → {pair.target} integration",
                'components': [pair.source, pair.target],
                'test_cases': self.generate_test_cases(pair)
            }
            self.tests.append(test)
            
        return self.tests
    
    def generate_test_cases(self, pair):
        """Generate test cases for component interaction."""
        cases = []
        
        # Happy path
        cases.append({
            'type': 'positive',
            'description': f"{pair.source} successfully calls {pair.target}",
            'setup': pair.preconditions,
            'action': pair.interaction,
            'assertion': pair.expected_result
        })
        
        # Error handling
        cases.append({
            'type': 'error',
            'description': f"Error propagation from {pair.target}",
            'setup': pair.error_condition,
            'action': pair.interaction,
            'assertion': pair.error_handling
        })
        
        return cases
```

## Output Format

```yaml
integration_test_suite:
  suite_id: "int-20250424-001"
  framework: "jest"
  target_percentage: 15
  
  test_groups:
    - group: "auth-flow"
      description: "Authentication service integration"
      tests:
        - id: "int-auth-user-001"
          name: "AuthService → UserService token validation"
          components: ["AuthService", "UserService"]
          gwt:
            given: "AuthService has valid JWT token"
            when: "AuthService requests user context from UserService"
            then: "UserService returns user profile data"
          test_code: |
            test('token validation flow', async () => {
              const token = await authService.generateToken(userId);
              const context = await userService.getContext(token);
              expect(context.userId).toBe(userId);
            });
            
    - group: "order-flow"
      description: "Order processing integration"
      tests:
        - id: "int-order-inventory-001"
          name: "OrderService → InventoryService stock reservation"
          components: ["OrderService", "InventoryService"]
          gwt:
            given: "Product has 100 units in stock"
            when: "OrderService reserves 10 units"
            then: "InventoryService decrements stock atomically"
```

## Integration with Aether.go Methodology

- **Input from**: test-pyramid-deriver (test stratification), interface-contract-designer (contracts)
- **Output to**: test-pyramid-validator (coverage validation)
- **Validates with**: test-pyramid-analyzer (distribution check)
- **Part of**: D4 Contract Derivation Domain (L3 → L4 internal boundary)
