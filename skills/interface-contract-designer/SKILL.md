---
name: interface-contract-designer
description: Use when designing interface contracts between system components with complete input/output/precondition/postcondition/exception definitions for P4 Interface-First Principle compliance
---

# Interface Contract Designer

## Overview
Design comprehensive interface contracts between system components following P4: Interface-First Principle. Each contract includes complete definitions of input, output, precondition, postcondition, and exception handling to ensure system boundary clarity and enable contract testing.

## When to Use

```
Component boundaries identified? ─────────────┐
                                              │
Need interface definitions? ───────────────────┤
                                              ├─► Use interface-contract-designer
P4 Interface-First compliance needed? ────────┤
                                              │
Preparing for contract-test-generator? ───────┘
```

Use when:
- Designing interfaces between components or services
- Following P4: Interface-First Principle
- Preparing for contract-test-generator input
- Defining API boundaries for microservices
- Establishing component interaction contracts

Don't use when:
- Only implementing internal component logic (use tdd-cycle-runner)
- Contract already exists and is validated
- Only documenting existing interfaces (use architecture-decision-recorder)

## Core Pattern

### Interface Contract Structure

```
Interface Contract
    ├── Input
    │     ├── Type
    │     ├── Format
    │     ├── Constraints
    │     └── Boundary Values
    │
    ├── Output
    │     ├── Type
    │     ├── Format
    │     └── Success/Failure Semantics
    │
    ├── Precondition
    │     ├── Required State
    │     └── Assumptions
    │
    ├── Postcondition
    │     ├── Guaranteed State
    │     └── Side Effects
    │
    └── Exception
          ├── Error Codes
          ├── Exception Types
          └── Recovery Strategies
```

### Contract Design Example

```
Service: UserRegistration
    │
    ▼
Interface Contract: registerUser
    │
    ├── Input:
    │     ├── email: String (format: email RFC 5322)
    │     ├── password: String (constraints: 8+ chars, 1 uppercase, 1 number)
    │     └── profile: Object {name, phone?, address?}
    │
    ├── Output:
    │     ├── Success: {userId: UUID, token: JWT}
    │     └── Failure: {error: ErrorCode, message: String}
    │
    ├── Precondition:
    │     ├── email not exists in system
    │     ├── password meets complexity requirements
    │     └── profile.name is non-empty
    │
    ├── Postcondition:
    │     ├── user created in database
    │     ├── verification email sent
    │     └── session token generated
    │
    └── Exception:
          ├── DUPLICATE_EMAIL: "Email already registered"
          ├── INVALID_PASSWORD: "Password does not meet requirements"
          └── VALIDATION_ERROR: "Profile validation failed"
```

### Before (Without Interface Contracts)
```yaml
component: "UserService"
method: "register"

implementation:
  - "Just write the code"
  - "Figure out inputs as we go"
  
result:
  - Unclear data format expectations
  - Missing error handling
  - No way to validate contract
  - Contract tests impossible
```

### After (With Interface Contracts)
```yaml
component: "UserService"
contract: "registerUser"
version: "1.0.0"

input:
  email:
    type: "string"
    format: "email"
    constraints: "RFC 5322 compliant"
    required: true
    
  password:
    type: "string"
    constraints: "min_length: 8, uppercase: 1, number: 1"
    required: true
    
output:
  success:
    userId: "UUID"
    token: "JWT"
  failure:
    error: "ErrorCode"
    message: "string"

precondition:
  - "email_not_exists(email)"
  - "password MeetsComplexity(password)"
  
postcondition:
  - "user Created in DB"
  - "verification Email Sent"
  
exception:
  - code: "DUPLICATE_EMAIL"
    http_status: 409
    message: "Email already registered"
```

## Quick Reference

### Contract Completeness Checklist

| Element | Required Fields | Validation |
|---------|----------------|------------|
| **Input** | type, format, constraints | Boundary value analysis |
| **Output** | success type, failure type | Both paths defined |
| **Precondition** | state requirements | Testable predicates |
| **Postcondition** | guaranteed state | Observable effects |
| **Exception** | error codes, recovery | All failure modes |

### Design Principles

1. **Explicit over Implicit**: All assumptions must be stated
2. **Complete Failure Coverage**: Every failure mode defined
3. **Reversible Design**: Postconditions describe observable state
4. **Testable Contracts**: Preconditions/postconditions are verifiable

## Implementation

### Contract Definition Generator

```python
class InterfaceContractDesigner:
    def __init__(self, component_name, operation_name):
        self.component = component_name
        self.operation = operation_name
        self.contract = {
            'input': {},
            'output': {'success': {}, 'failure': {}},
            'precondition': [],
            'postcondition': [],
            'exception': []
        }
        
    def add_input(self, name, type, format=None, constraints=None, required=True):
        """Define input parameter."""
        self.contract['input'][name] = {
            'type': type,
            'format': format,
            'constraints': constraints,
            'required': required
        }
        
    def add_precondition(self, predicate, description):
        """Define precondition."""
        self.contract['precondition'].append({
            'predicate': predicate,
            'description': description,
            'testable': True
        })
        
    def add_postcondition(self, predicate, description):
        """Define postcondition."""
        self.contract['postcondition'].append({
            'predicate': predicate,
            'description': description,
            'observable': True
        })
        
    def add_exception(self, code, message, http_status=500):
        """Define exception case."""
        self.contract['exception'].append({
            'code': code,
            'message': message,
            'http_status': http_status
        })
        
    def validate_completeness(self):
        """Validate contract completeness."""
        issues = []
        
        if not self.contract['input']:
            issues.append("No input parameters defined")
            
        if not self.contract['output']['success']:
            issues.append("No success output defined")
            
        if not self.contract['precondition']:
            issues.append("No preconditions defined")
            
        if not self.contract['postcondition']:
            issues.append("No postconditions defined")
            
        if not self.contract['exception']:
            issues.append("No exception handling defined")
            
        return {
            'complete': len(issues) == 0,
            'issues': issues
        }
```

## Output Format

```yaml
interface_contract:
  contract_id: "ic-20250424-001"
  component: "UserService"
  operation: "registerUser"
  version: "1.0.0"
  
  input:
    email:
      type: "string"
      format: "email/rfc5322"
      constraints: "required, valid format"
      boundary_values: ["valid@example.com", "invalid@", "@nodomain"]
      
    password:
      type: "string" 
      constraints: "min_length:8, uppercase:1, digit:1"
      boundary_values: ["Pass1234", "short", "nouppercase", "nocaps123"]
      
  output:
    success:
      type: "object"
      fields:
        userId: "UUID"
        token: "JWT"
      http_status: 201
        
    failure:
      type: "object"
      fields:
        error: "ErrorCode"
        message: "string"
      http_status: 400/409/500
      
  precondition:
    - predicate: "email_not_exists(email)"
      description: "Email must not be registered"
      
    - predicate: "password MeetsComplexity(password)"
      description: "Password must meet requirements"
      
  postcondition:
    - predicate: "user Created in database"
      description: "New user record exists"
      
    - predicate: "verification_email_sent(email)"
      description: "Verification email dispatched"
      
  exception:
    - code: "DUPLICATE_EMAIL"
      http_status: 409
      message: "Email already registered"
      recovery: "Suggest login or password reset"
      
    - code: "INVALID_PASSWORD"
      http_status: 400
      message: "Password does not meet requirements"
      recovery: "Return password requirements"
      
  completeness:
    p4_compliant: true
    testable: true
    contract_tests_possible: true
```

## Integration with Aether.go Methodology

- **Input from**: data-flow-analyzer (component boundaries), architecture-pattern-selector (patterns)
- **Output to**: contract-test-generator (contract tests), tdd-cycle-runner (unit tests)
- **Validates with**: correctness-checker (contract validity), consistency-checker (boundary consistency)
- **Part of**: D2 Architecture Derivation Domain (L2 → Component Contracts)

## Validation Rules

- Every input parameter MUST have type and constraints defined
- Every operation MUST have success and failure output defined
- Every operation MUST have at least one precondition
- Every operation MUST have at least one postcondition
- Every expected failure MUST have exception defined
- Contract MUST be testable (pre/postconditions must be verifiable)
