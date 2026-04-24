---
name: contract-driven-code-generator
description: Use when generating implementation code from interface contracts, ensuring strict contract compliance and L4->L5 derivation alignment
---

# Contract-Driven Code Generator

## Overview
Generate implementation code from L4 interface contracts, ensuring strict contract compliance and L4->L5 derivation alignment. Enforces P4: Interface-First Principle by generating code that strictly adheres to pre-defined interface specifications.

## When to Use

```
Interface contracts defined? ────────────┐
                                         │
Need implementation code? ───────────────┤
                                         ├─► Use contract-driven-code-generator
L4 -> L5 derivation needed? ─────────────┤
                                         │
Following P4 Interface-First Principle? ─┘
```

Use when:
- Interface contracts are defined and need implementation
- Following contract-first development methodology
- Bridging L4 interface contracts to L5 implementation
- Need to ensure strict contract compliance
- Preparing for code-refactor-engine optimization

Don't use when:
- Interfaces are not yet defined (use interface-contract-designer first)
- Only writing tests (use tdd-cycle-runner)
- Only refactoring existing code (use code-refactor-engine)

## Core Pattern

### L4 -> L5 Derivation Model

```
L4: Interface Contracts (Component Contract Layer)
    ├── IC-001: UserService interface
    │   ├── register(email, password) -> User
    │   ├── login(email, password) -> AuthToken
    │   └── logout(token) -> void
    ├── IC-002: OrderService interface
    └── IC-003: PaymentService interface
         |
         v
    Contract-Driven Code Generator
         |
         v
L5: Implementation Code (Unit Implementation Layer)
    ├── UserServiceImpl implements UserService
    ├── OrderServiceImpl implements OrderService
    └── PaymentServiceImpl implements PaymentService
```

### Contract Compliance Rules

| Contract Element | Implementation Requirement |
|-----------------|---------------------------|
| **Method Signature** | MUST match exactly (name, params, return type) |
| **Preconditions** | MUST validate and enforce |
| **Postconditions** | MUST guarantee |
| **Error Handling** | MUST throw specified exceptions |
| **Side Effects** | MUST document and minimize |
| **Performance** | MUST meet specified SLAs |

### Before (Without Contract-Driven Generation)
```typescript
// Developer writes implementation without contract
class UserService {
  async createUser(data: any) {
    // No contract enforcement
    // May deviate from interface
    // Unclear error handling
    return await db.users.create(data);
  }
}
```

### After (With Contract-Driven Generation)
```typescript
// Interface Contract (L4)
interface IUserService {
  register(email: string, password: string): Promise<User>;
  login(email: string, password: string): Promise<AuthToken>;
  logout(token: string): Promise<void>;
}

// Implementation generated from contract (L5)
class UserService implements IUserService {
  constructor(
    private userRepository: IUserRepository,
    private emailValidator: IEmailValidator,
    private passwordHasher: IPasswordHasher,
    private tokenGenerator: ITokenGenerator
  ) {}
  
  async register(email: string, password: string): Promise<User> {
    // Precondition: validate email format
    if (!this.emailValidator.isValid(email)) {
      throw new ValidationError('Invalid email format');
    }
    
    // Precondition: check uniqueness
    if (await this.userRepository.exists(email)) {
      throw new DuplicateError('Email already registered');
    }
    
    // Implementation
    const hashedPassword = await this.passwordHasher.hash(password);
    const user = await this.userRepository.create({
      email,
      password: hashedPassword,
      createdAt: new Date()
    });
    
    // Postcondition: user must have ID
    if (!user.id) {
      throw new InternalError('User creation failed');
    }
    
    return user;
  }
  
  async login(email: string, password: string): Promise<AuthToken> {
    // Precondition: validate email format
    if (!this.emailValidator.isValid(email)) {
      throw new ValidationError('Invalid email format');
    }
    
    // Implementation
    const user = await this.userRepository.findByEmail(email);
    if (!user) {
      throw new AuthenticationError('Invalid credentials');
    }
    
    const isValidPassword = await this.passwordHasher.verify(password, user.password);
    if (!isValidPassword) {
      throw new AuthenticationError('Invalid credentials');
    }
    
    // Postcondition: generate valid token
    const token = await this.tokenGenerator.generate(user.id);
    return token;
  }
  
  async logout(token: string): Promise<void> {
    // Precondition: validate token format
    if (!token || token.length < 10) {
      throw new ValidationError('Invalid token');
    }
    
    // Implementation
    await this.tokenGenerator.revoke(token);
  }
}
```

## Quick Reference

### Contract Elements

| Element | Description | Implementation |
|---------|-------------|----------------|
| **Interface** | Defines service contract | MUST implement all methods |
| **Preconditions** | Conditions that must hold before execution | MUST validate and enforce |
| **Postconditions** | Conditions that must hold after execution | MUST guarantee |
| **Invariants** | Conditions that always hold | MUST maintain |
| **Exceptions** | Error conditions and responses | MUST throw specified exceptions |
| **SLAs** | Performance and availability requirements | MUST meet specified thresholds |

### Code Generation Rules

1. **Signature Compliance**: Method signatures MUST match interface exactly
2. **Dependency Injection**: Dependencies MUST be injected via constructor
3. **Precondition Validation**: All preconditions MUST be validated
4. **Error Handling**: Specified exceptions MUST be thrown
5. **Postcondition Guarantee**: Postconditions MUST be guaranteed
6. **Logging**: Key operations SHOULD be logged
7. **Metrics**: Performance SHOULD be measured

## Implementation

### Contract Parsing

```python
class ContractParser:
    def parse_interface(self, contract_file):
        """Parse interface contract into structured format."""
        
        contract = {
            'name': extract_interface_name(contract_file),
            'methods': [],
            'dependencies': []
        }
        
        for method in extract_methods(contract_file):
            contract['methods'].append({
                'name': method.name,
                'params': method.parameters,
                'return_type': method.return_type,
                'preconditions': method.preconditions,
                'postconditions': method.postconditions,
                'exceptions': method.exceptions
            })
        
        return contract
```

### Code Generation

```python
class ContractDrivenCodeGenerator:
    def __init__(self, contract):
        self.contract = contract
        
    def generate_implementation(self):
        """Generate implementation code from contract."""
        
        code = []
        
        # Generate class declaration
        code.append(f"class {self.contract.name}Impl implements {self.contract.name} {{")
        
        # Generate constructor with dependency injection
        code.append(self.generate_constructor())
        
        # Generate method implementations
        for method in self.contract.methods:
            code.append(self.generate_method(method))
        
        code.append("}")
        
        return "\n".join(code)
    
    def generate_method(self, method):
        """Generate method implementation from contract."""
        
        code = []
        
        # Method signature
        code.append(f"  async {method.name}({self.format_params(method.params)}): Promise<{method.return_type}> {{")
        
        # Precondition validation
        for precondition in method.preconditions:
            code.append(f"    // Precondition: {precondition.description}")
            code.append(f"    if (!({precondition.condition})) {{")
            code.append(f"      throw new {precondition.exception}('{precondition.message}');")
            code.append("    }")
        
        # Implementation placeholder
        code.append("    // TODO: Implement business logic")
        code.append("    throw new Error('Not implemented');")
        
        # Postcondition guarantee
        for postcondition in method.postconditions:
            code.append(f"    // Postcondition: {postcondition.description}")
        
        code.append("  }")
        
        return "\n".join(code)
```

## Output Format

```yaml
contract_implementation:
  contract_id: "ic-001"
  interface: "UserService"
  implementation: "UserServiceImpl"
  
  methods:
    - name: "register"
      signature_match: true
      preconditions_validated: 2
      postconditions_guaranteed: 1
      exceptions_handled: 2
      
    - name: "login"
      signature_match: true
      preconditions_validated: 1
      postconditions_guaranteed: 1
      exceptions_handled: 1
      
  compliance_score: 1.0
  generated_at: "2025-04-24T12:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: interface-contract-designer (interface contracts)
- **Output to**: code-refactor-engine (for optimization)
- **Validates with**: correctness-checker (contract compliance), consistency-checker (interface alignment)
- **Part of**: D5 Implementation Derivation Domain (L4 -> L5)

## Validation Rules

- Implementation MUST implement all interface methods
- Method signatures MUST match exactly
- All preconditions MUST be validated
- All postconditions MUST be guaranteed
- Specified exceptions MUST be thrown
- Dependencies MUST be injected via constructor
