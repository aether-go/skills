---
name: tdd-cycle-runner
description: Use when executing the complete TDD red-green-refactor cycle as an atomic skill, bridging L4 test specifications to L5 implementation
---

# TDD Cycle Runner

## Overview
Execute the complete Test-Driven Development (TDD) red-green-refactor cycle as an atomic skill. Bridges L4 test specifications to L5 implementation in the Aether five-layer derivation model, ensuring strict adherence to P6: Test-First Principle.

## When to Use

```
Unit tests defined? ─────────────────────┐
                                         │
Need to implement code to pass tests? ───┤
                                         ├─► Use tdd-cycle-runner
L4 -> L5 derivation needed? ─────────────┤
                                         │
Following P6 Test-First Principle? ──────┘
```

Use when:
- Unit tests are defined and need implementation
- Following strict TDD methodology
- Bridging L4 test specifications to L5 implementation
- Need atomic red-green-refactor cycle execution
- Preparing for code-refactor-engine optimization

Don't use when:
- Tests are not yet defined (use unit-test-generator first)
- Only refactoring existing code (use code-refactor-engine)
- Writing tests for existing code (not test-first)

## Core Pattern

### L4 -> L5 Derivation Model

```
L4: Unit Test Specifications (Component Contract Layer)
    ├── UT-001: Test user registration with valid email
    ├── UT-002: Test user registration with invalid email
    └── UT-003: Test user registration with duplicate email
         |
         v
    TDD Cycle Runner
         |
         v
L5: Implementation Code (Unit Implementation Layer)
    ├── RED: Write failing test
    ├── GREEN: Write minimal code to pass
    └── REFACTOR: Improve design
```

### The TDD Cycle

```
Write Failing Test (RED) → Write Minimal Code (GREEN) → Improve Design (REFACTOR)
        ↑                                                          |
        └──────────────────────←───────────────────────────────────┘
```

### RED Phase

- Write test BEFORE any production code
- Test clearly expresses expected behavior
- Test fails with descriptive error message
- Test covers happy path + edge cases
- No production code exists yet

### GREEN Phase

- Write MINIMAL code to pass test
- Don't worry about code quality yet
- Focus on making tests pass quickly
- Don't add extra features not tested
- All tests pass

### REFACTOR Phase

- Improve design while tests pass
- Eliminate duplication
- Improve naming and readability
- Apply design patterns
- Ensure tests still pass

### Before (Without TDD Cycle)
```javascript
// Writing production code first, testing later
function registerUser(email, password) {
  // ... implementation without tests
  return user;
}

// Tests written after code is "done"
test('registerUser', () => {
  expect(registerUser('test@example.com', 'password')).toBeDefined();
});
```

### After (With TDD Cycle)
```javascript
// RED: Write failing test first
test('registerUser with valid email creates user', () => {
  const user = registerUser('test@example.com', 'SecurePass123!');
  expect(user.email).toBe('test@example.com');
  expect(user.id).toBeDefined();
});

test('registerUser with invalid email throws error', () => {
  expect(() => registerUser('invalid-email', 'password'))
    .toThrow('Invalid email format');
});

test('registerUser with duplicate email throws error', () => {
  registerUser('test@example.com', 'password');
  expect(() => registerUser('test@example.com', 'password'))
    .toThrow('Email already registered');
});

// GREEN: Write minimal code to pass tests
function registerUser(email, password) {
  if (!isValidEmail(email)) {
    throw new Error('Invalid email format');
  }
  if (userExists(email)) {
    throw new Error('Email already registered');
  }
  return createUser(email, password);
}

// REFACTOR: Improve design
class UserService {
  constructor(userRepository, emailValidator) {
    this.userRepository = userRepository;
    this.emailValidator = emailValidator;
  }
  
  register(email, password) {
    this.validateEmail(email);
    this.ensureUnique(email);
    return this.userRepository.create({ email, password });
  }
  
  validateEmail(email) {
    if (!this.emailValidator.isValid(email)) {
      throw new ValidationError('Invalid email format');
    }
  }
  
  ensureUnique(email) {
    if (this.userRepository.exists(email)) {
      throw new DuplicateError('Email already registered');
    }
  }
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
- [ ] All tests still pass
- [ ] Code is more readable
- [ ] Duplication is eliminated
- [ ] Naming is improved
- [ ] Design patterns applied appropriately

## Implementation

### TDD Cycle Execution

```python
class TDDCycleRunner:
    def __init__(self, test_specifications, code_template):
        self.tests = test_specifications
        self.code = code_template
        self.cycle_count = 0
        
    def execute_cycle(self):
        """Execute one complete TDD cycle."""
        
        # RED Phase
        self.red_phase()
        
        # GREEN Phase
        self.green_phase()
        
        # REFACTOR Phase
        self.refactor_phase()
        
        self.cycle_count += 1
        
    def red_phase(self):
        """Write failing test."""
        test = self.tests.next()
        self.write_test(test)
        assert self.run_tests() == 'fail', "Test should fail in RED phase"
        
    def green_phase(self):
        """Write minimal code to pass."""
        self.write_minimal_code()
        assert self.run_tests() == 'pass', "All tests should pass in GREEN phase"
        
    def refactor_phase(self):
        """Improve design while keeping tests green."""
        initial_tests = self.run_tests()
        self.improve_design()
        assert self.run_tests() == initial_tests, "Tests must stay green after refactor"
```

## Output Format

```yaml
tdd_cycle_report:
  cycle_id: "tdd-20250424-001"
  target: "UserService.register"
  cycles_completed: 3
  
  red_phase:
    - test_id: "ut-001"
      description: "Valid email creates user"
      status: "passed"
      error_message: "registerUser is not defined"
      
  green_phase:
    - test_id: "ut-001"
      implementation: "Minimal registerUser function"
      status: "passed"
      
  refactor_phase:
    - changes: ["Extracted UserService class", "Added dependency injection"]
      tests_status: "all_passing"
      
  final_state:
    tests_passing: 3
    tests_failing: 0
    code_quality_score: 0.92
    coverage: 100%
```

## Integration with Aether.go Methodology

- **Input from**: unit-test-generator (unit test specifications)
- **Output to**: code-refactor-engine (for further optimization)
- **Validates with**: correctness-checker (test correctness), boundedness-checker (cycle bounds)
- **Part of**: D5 Implementation Derivation Domain (L4 -> L5)

## Validation Rules

- Each cycle MUST complete RED -> GREEN -> REFACTOR
- Tests MUST fail in RED phase
- All tests MUST pass in GREEN phase
- Tests MUST still pass after REFACTOR
- No production code MUST exist before RED phase
- Implementation MUST be minimal in GREEN phase
