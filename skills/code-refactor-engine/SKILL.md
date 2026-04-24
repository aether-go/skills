---
name: code-refactor-engine
description: Use when refactoring implementation code to improve design while maintaining test coverage, supporting P9 recursive self-optimization
---

# Code Refactor Engine

## Overview
Refactor implementation code to improve design while maintaining test coverage. Supports P9: Recursive Self-Optimization Principle by continuously improving code quality through automated refactoring patterns.

## When to Use

```
Implementation code exists? ─────────────┐
                                         │
Need to improve design? ─────────────────┤
                                         ├─► Use code-refactor-engine
Tests are passing? ──────────────────────┤
                                         │
Following P9 optimization principle? ────┘
```

Use when:
- Implementation code exists and needs design improvement
- Tests are passing and need to remain passing
- Following P9 recursive self-optimization
- Need to eliminate technical debt
- Preparing for performance optimization

Don't use when:
- Tests are failing (fix tests first)
- No tests exist (use tdd-cycle-runner first)
- Only renaming variables (use IDE refactoring)
- Architecture needs change (use architecture-pattern-selector)

## Core Pattern

### Refactoring Process

```
Current Code
    |
    v
Identify Code Smells
    |
    v
Select Refactoring Pattern
    |
    v
Apply Refactoring
    |
    v
Run Tests (Must Pass)
    |
    v
Evaluate Improvement
    |
    v
Commit or Revert
```

### Common Refactoring Patterns

| Pattern | When to Use | Example |
|---------|-------------|---------|
| **Extract Method** | Method is too long | Break 50-line method into 3 methods |
| **Extract Class** | Class has multiple responsibilities | Separate UserAuth from UserProfile |
| **Move Method** | Method uses more features of another class | Move validateEmail to EmailValidator |
| **Replace Conditional with Polymorphism** | Complex switch/if-else | Replace with Strategy pattern |
| **Introduce Parameter Object** | Method has too many parameters | Group params into UserRegistrationRequest |
| **Replace Magic Numbers** | Hard-coded values | Extract MAX_RETRY_COUNT constant |
| **Remove Duplication** | Repeated code blocks | Extract common logic into helper method |

### Before (Before Refactoring)
```typescript
class UserController {
  async handleRequest(req: Request, res: Response) {
    const { email, password, firstName, lastName, phone, address } = req.body;
    
    // Validation
    if (!email || !email.includes('@')) {
      return res.status(400).json({ error: 'Invalid email' });
    }
    if (!password || password.length < 8) {
      return res.status(400).json({ error: 'Invalid password' });
    }
    if (!firstName || !lastName) {
      return res.status(400).json({ error: 'Name required' });
    }
    
    // Business logic
    const existingUser = await db.users.findOne({ email });
    if (existingUser) {
      return res.status(409).json({ error: 'Email exists' });
    }
    
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await db.users.create({
      email,
      password: hashedPassword,
      firstName,
      lastName,
      phone,
      address,
      createdAt: new Date()
    });
    
    // Response
    return res.status(201).json({
      id: user.id,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName
    });
  }
}
```

### After (After Refactoring)
```typescript
// Extracted validation logic
class UserRegistrationValidator {
  validate(data: UserRegistrationRequest): ValidationResult {
    const errors: string[] = [];
    
    if (!EmailValidator.isValid(data.email)) {
      errors.push('Invalid email format');
    }
    if (!PasswordValidator.isValid(data.password)) {
      errors.push('Password must be at least 8 characters');
    }
    if (!data.firstName || !data.lastName) {
      errors.push('First and last name are required');
    }
    
    return errors.length > 0 
      ? ValidationResult.failure(errors)
      : ValidationResult.success();
  }
}

// Extracted parameter object
class UserRegistrationRequest {
  constructor(
    public readonly email: string,
    public readonly password: string,
    public readonly firstName: string,
    public readonly lastName: string,
    public readonly phone?: string,
    public readonly address?: string
  ) {}
}

// Refactored controller
class UserController {
  constructor(
    private userService: IUserService,
    private validator: UserRegistrationValidator
  ) {}
  
  async register(req: Request, res: Response) {
    const request = new UserRegistrationRequest(
      req.body.email,
      req.body.password,
      req.body.firstName,
      req.body.lastName,
      req.body.phone,
      req.body.address
    );
    
    const validation = this.validator.validate(request);
    if (!validation.isValid) {
      return res.status(400).json({ errors: validation.errors });
    }
    
    try {
      const user = await this.userService.register(request);
      return res.status(201).json(user.toResponse());
    } catch (error) {
      if (error instanceof DuplicateUserError) {
        return res.status(409).json({ error: 'Email already registered' });
      }
      throw error;
    }
  }
}
```

## Quick Reference

### Code Smells Detection

| Smell | Detection | Refactoring |
|-------|-----------|-------------|
| **Long Method** | > 20 lines | Extract Method |
| **Large Class** | > 200 lines | Extract Class |
| **Primitive Obsession** | Raw types for domain concepts | Introduce Value Object |
| **Feature Envy** | Method uses more of another class | Move Method |
| **Switch Statements** | Complex conditionals | Replace with Polymorphism |
| **Temporary Field** | Fields only used in some methods | Extract Class |
| **Refused Bequest** | Subclass doesn't use parent methods | Replace Inheritance with Delegation |
| **Divergent Change** | Class changes for different reasons | Extract Class |
| **Shotgun Surgery** | Change requires many small edits | Move Method, Inline Class |
| **Parallel Inheritance** | Mirror class hierarchies | Bridge Pattern |

### Refactoring Safety Rules

1. **Tests Must Pass**: All tests MUST pass before and after refactoring
2. **Small Steps**: Make small, incremental changes
3. **Version Control**: Commit after each successful refactoring
4. **No Behavior Change**: Refactoring MUST NOT change behavior
5. **Code Review**: Review refactored code for readability

## Implementation

### Refactoring Engine

```python
class CodeRefactorEngine:
    def __init__(self, code, tests):
        self.code = code
        self.tests = tests
        self.smells = []
        
    def analyze(self):
        """Analyze code for smells."""
        self.smells = [
            self.detect_long_methods(),
            self.detect_large_classes(),
            self.detect_duplication(),
            self.detect_primitive_obsession(),
            self.detect_feature_envy()
        ]
        return self.smells
    
    def refactor(self, smell):
        """Apply refactoring for detected smell."""
        
        # Ensure tests pass before refactoring
        assert self.run_tests() == 'pass', "Tests must pass before refactoring"
        
        # Apply refactoring
        refactored_code = self.apply_refactoring(smell)
        
        # Ensure tests still pass
        assert self.run_tests() == 'pass', "Tests must pass after refactoring"
        
        return refactored_code
    
    def detect_long_methods(self):
        """Detect methods longer than 20 lines."""
        long_methods = []
        for method in self.code.methods:
            if method.line_count > 20:
                long_methods.append({
                    'smell': 'long_method',
                    'method': method.name,
                    'lines': method.line_count,
                    'suggestion': 'extract_method'
                })
        return long_methods
    
    def apply_refactoring(self, smell):
        """Apply appropriate refactoring pattern."""
        
        refactorings = {
            'long_method': self.extract_method,
            'large_class': self.extract_class,
            'duplication': self.remove_duplication,
            'primitive_obsession': self.introduce_value_object,
            'feature_envy': self.move_method
        }
        
        return refactorings[smell['smell']](smell)
```

## Output Format

```yaml
refactoring_report:
  target_file: "user-controller.ts"
  analysis_date: "2025-04-24T12:00:00Z"
  
  smells_detected:
    - type: "long_method"
      location: "UserController.handleRequest"
      severity: "high"
      lines: 45
      
    - type: "primitive_obsession"
      location: "UserController.handleRequest parameters"
      severity: "medium"
      
  refactorings_applied:
    - pattern: "extract_method"
      location: "UserController.handleRequest"
      description: "Extracted validation logic into UserRegistrationValidator"
      tests_status: "passing"
      
    - pattern: "introduce_parameter_object"
      location: "UserController.handleRequest"
      description: "Created UserRegistrationRequest class"
      tests_status: "passing"
      
  metrics_before:
    average_method_length: 45
    class_responsibilities: 3
    code_duplication: 15%
    
  metrics_after:
    average_method_length: 12
    class_responsibilities: 1
    code_duplication: 5%
    
  improvement:
    maintainability: "+40%"
    testability: "+30%"
    readability: "+50%"
```

## Integration with Aether.go Methodology

- **Input from**: tdd-cycle-runner (implementation code), contract-driven-code-generator (generated code)
- **Output to**: recursive-optimizer (optimization feedback)
- **Validates with**: correctness-checker (behavior preservation), test-pyramid-analyzer (coverage maintenance)
- **Part of**: D5 Implementation Derivation Domain (L4 -> L5 optimization)

## Validation Rules

- All tests MUST pass before refactoring
- All tests MUST pass after refactoring
- Behavior MUST NOT change
- Code coverage MUST NOT decrease
- Code smells MUST be reduced
- Readability MUST improve
