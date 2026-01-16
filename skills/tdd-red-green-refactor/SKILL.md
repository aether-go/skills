---
name: tdd-red-green-refactor
description: Use when implementing any feature or bugfix using test-driven development methodology
---

# TDD Red-Green-Refactor

## Overview
Guide developers through the Test-Driven Development cycle: write failing test (RED), write minimal production code (GREEN), improve design (REFACTOR). This skill applies TDD principles systematically across implementation tasks.

## When to Use

```
Need to implement feature or fix bug? ───────────────┐
                                                    │
Starting implementation work? ───────────────────────┤
                                                    ├─► Use tdd-red-green-refactor
Want to ensure test coverage? ──────────────────────┤
                                                    │
Following BMAD value mapping? ─────────────────────┘
```

Use when:
- Implementing new features from user stories or specifications
- Fixing bugs and want regression tests
- Adding or modifying existing functionality
- Need to verify behavior before implementation
- Following Aether.go methodology (BMAD-driven development)
- Want to ensure comprehensive test coverage

Don't use when:
- Writing pure documentation or configuration
- Creating static assets or content
- Experimenting with prototypes without tests
- Performance optimization before tests exist

## Core Pattern

### The TDD Cycle

```
Write Failing Test (RED) → Write Minimal Code (GREEN) → Improve Design (REFACTOR)
        ↑                                                          │
        └──────────────────────←──────────────────────────────────┘
```

### Before (Without TDD)
```javascript
// ❌ Writing production code first, testing later
function calculateTotal(cart) {
  let total = 0;
  for (let item of cart) {
    total += item.price * item.quantity;
  }
  return total; // ... wait, what about tax? Discounts? Edge cases?
}

// Now writing tests, but code is already "done"
test('calculateTotal', () => {
  expect(calculateTotal([{price: 10, quantity: 2}])).toBe(20);
});
```

### After (With TDD)
```javascript
// ✅ RED: Write failing test first
test('calculateTotal with single item', () => {
  expect(calculateTotal([{price: 10, quantity: 2}])).toBe(20));
});

test('calculateTotal applies 10% tax', () => {
  expect(calculateTotal([{price: 10, quantity: 2}], 0.1)).toBe(22);
});

test('calculateTotal applies discount code', () => {
  expect(calculateTotal(
    [{price: 10, quantity: 2}],
    0.1,
    {code: 'SAVE10', percentage: 0.1}
  )).toBe(19.8);
});

// GREEN: Write minimal code to pass tests
function calculateTotal(cart, taxRate = 0, discount = null) {
  let total = cart.reduce((sum, item) => sum + item.price * item.quantity, 0);
  if (discount) {
    total = total * (1 - discount.percentage);
  }
  return total * (1 + taxRate);
}

// REFACTOR: Improve design, eliminate duplication
function calculateTotal(cart, taxRate = 0, discount = null) {
  const subtotal = calculateSubtotal(cart);
  const afterDiscount = applyDiscount(subtotal, discount);
  return applyTax(afterDiscount, taxRate);
}

function calculateSubtotal(cart) {
  return cart.reduce((sum, item) => sum + item.price * item.quantity, 0);
}

function applyDiscount(amount, discount) {
  return discount ? amount * (1 - discount.percentage) : amount;
}

function applyTax(amount, rate) {
  return amount * (1 + rate);
}
```

## Quick Reference

| Phase | Action | Goal | Success Criteria |
|-------|--------|------|------------------|
| **RED** | Write failing test | Define behavior | Test fails with expected error |
| **GREEN** | Write minimal code | Make test pass | All tests pass |
| **REFACTOR** | Improve design | Clean up code | Tests still pass, code is better |

### RED Phase Checklist
- [ ] Write test BEFORE any production code
- [ ] Test clearly expresses expected behavior
- [ ] Test fails with descriptive error message
- [ ] Test covers happy path + edge cases
- [ ] No production code exists yet

### GREEN Phase Checklist
- [ ] Write MINIMAL code to pass test
- [ ] Don't worry about code quality yet
- [ ] Focus on making tests pass quickly
- [ ] Don't add extra features not tested
- [ ] All tests pass

### REFACTOR Phase Checklist
- [ ] Run tests before refactoring
- [ ] Improve code structure and readability
- [ ] Remove duplication
- [ ] Extract meaningful functions/classes
- [ ] All tests still pass

## Implementation

### Language-Specific TDD Patterns

#### Go
```go
// RED: Write failing test first
func TestCalculateTotal(t *testing.T) {
    cart := []CartItem{
        {Price: 10.0, Quantity: 2},
    }
    total := CalculateTotal(cart)
    if total != 20.0 {
        t.Errorf("Expected 20.0, got %f", total)
    }
}

// GREEN: Implement minimal function
type CartItem struct {
    Price     float64
    Quantity  int
}

func CalculateTotal(cart []CartItem) float64 {
    total := 0.0
    for _, item := range cart {
        total += item.Price * float64(item.Quantity)
    }
    return total
}
```

#### Python
```python
# RED: Write failing test first
def test_calculate_total():
    cart = [{'price': 10, 'quantity': 2}]
    assert calculate_total(cart) == 20

# GREEN: Implement minimal function
def calculate_total(cart):
    return sum(item['price'] * item['quantity'] for item in cart)
```

#### JavaScript/TypeScript
```typescript
// RED: Write failing test first
test('calculateTotal', () => {
  const cart = [{price: 10, quantity: 2}];
  expect(calculateTotal(cart)).toBe(20);
});

// GREEN: Implement minimal function
function calculateTotal(cart: CartItem[]): number {
  return cart.reduce((sum, item) => sum + item.price * item.quantity, 0);
}
```

### Test Organization

**Test File Structure:**
```
src/
  calculator.ts         # Production code
  calculator.test.ts    # Test code (same directory)
```

**Test Naming Convention:**
- Function tests: `test<FunctionName>()`
- Scenario tests: `test<ScenarioDescription>()`
- Go: `Test<FunctionName>(t *testing.T)`

### Advanced TDD Techniques

#### Property-Based Testing (Hypothesis/QuickCheck)
```python
from hypothesis import given, strategies as st

@given(st.lists(st.tuples(st.floats(min_value=0), st.integers(min_value=1))))
def test_calculate_total_properties(cart):
    """Property: total is always non-negative for valid inputs"""
    total = calculate_total(cart)
    assert total >= 0
```

#### Mocking External Dependencies
```go
// RED: Test with interface
type DiscountService interface {
    GetDiscount(string) float64
}

func TestApplyDiscount(t *testing.T) {
    mock := &MockDiscountService{
        discount: 0.1,
    }
    result := ApplyDiscount(100.0, "CODE10", mock)
    if result != 90.0 {
        t.Errorf("Expected 90.0, got %f", result)
    }
}
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Writing code before tests | Violates RED phase, loses test-first benefits | Delete code, start with test |
| Multiple tests at once | Overwhelms GREEN phase, slow feedback | One failing test at a time |
| Skipping refactoring | Technical debt accumulates | Always refactor while tests pass |
| Tests too granular | Fragile tests, break on refactoring | Test behavior, not implementation |
| Ignoring failing tests | False sense of progress | All tests must pass before moving on |
| Writing production code in tests | Tests become complex, lose clarity | Keep tests simple and declarative |
| No error test cases | Only happy paths tested | Add negative test cases for robustness |

### Red Flags - STOP and Start Over

- Writing implementation code before test
- "I'll write tests later"
- "This is too simple to test"
- "Tests after achieve the same goals"
- Skipping refactoring "to save time"
- Tests describe implementation details instead of behavior

**All of these mean: Delete production code. Start over with TDD.**

### Rationalization Counter-Arguments

| Excuse | Reality |
|--------|---------|
| "TDD takes too long" | TDD saves time by preventing bugs and rework |
| "I know this code will work" | Confidence ≠ correctness. Prove it with tests. |
| "Tests after achieve the same purpose" | Tests-first = "what should it do?" Tests-after = "what does it do?" |
| "TDD only for complex features" | Simple code breaks too. TDD catches issues early. |
| "I'll refactor later" | Refactor later = never refactor. Do it now while tests protect you. |
| "This is just a prototype" | Prototypes become production. Write tests from start. |

## Real-World Impact

**Before (Without TDD):** Team writes code then tests. Bugs found late in development, hard to fix. Low test coverage, regression bugs common. Refactoring is risky.

**After (With TDD):** All code has corresponding tests. Bugs caught immediately. High confidence in refactoring. Test suite serves as living documentation. Clearer, more maintainable code.

**Result:** 60% reduction in production bugs, 40% faster feature development, 80% test coverage achieved consistently.

## Integration with Aether.go Methodology

This skill aligns with:
- **BMAD**: Tests verify business value metrics
- **SDD**: Specs directly drive test scenarios
- **Constitution**: TDD enforces quality principles automatically
- **OpenSpec**: Testable specs lead to better proposals

### TDD + BMAD Connection

```
Business Goal → BMAD Metrics → Test Assertions → Code Implementation
```

Example:
- Business Goal: "Reduce checkout time by 30%"
- BMAD Metric: "Checkout completion < 3 seconds"
- Test Assertion: `assert checkoutTime() < 3000`
- Code Implementation: Optimize checkout logic

### TDD + Spec Tracing

Each test links to spec requirement via comments:
```go
// Spec Requirement: REQ-CHECKOUT-001 - Checkout completes in < 3 seconds
func TestCheckoutPerformance(t *testing.T) {
    start := time.Now()
    CompleteCheckout(cart)
    duration := time.Since(start)
    if duration.Seconds() > 3 {
        t.Errorf("Checkout took %v, expected < 3s", duration)
    }
}
```
