---
name: spec-to-code-tracer
description: Use when establishing bidirectional traceability between specifications and code implementations
---

# Spec to Code Tracer

## Overview
Create and maintain bidirectional traceability matrix linking specification requirements to code implementations and tests. Ensures every requirement is implemented and every code change is traceable to requirements.

## When to Use

```
Starting new feature? ──────────────────┐
                                        │
Need compliance audit? ──────────────────┤
                                        ├─► Use spec-to-code-tracer
Impact analysis for changes? ───────────┤
                                        │
Regulatory requirements? ───────────────┘
```

Use when:
- Implementing features from specs
- Conducting impact analysis
- Regulatory compliance audits
- Quality assurance
- Code reviews
- Generating test coverage reports

## Core Pattern

### Traceability Matrix

```yaml
traceability_matrix:
  spec_id: "REQ-ORDER-001"
  title: "Order Processing"

  requirements:
    - id: "REQ-001"
      description: "User can create order"
      status: "implemented"
      files:
        - "src/services/order-service.ts"
        - "src/controllers/order-controller.ts"
      tests:
        - "src/tests/order-service.test.ts"
        - "src/tests/order-integration.test.ts"
      last_updated: "2024-01-16"

    - id: "REQ-002"
      description: "Order validation"
      status: "implemented"
      files:
        - "src/validators/order-validator.ts"
      tests:
        - "src/tests/order-validator.test.ts"
      last_updated: "2024-01-16"

    - id: "REQ-003"
      description: "Order cancellation"
      status: "pending"
      files: []
      tests: []
      last_updated: null
```

## Implementation

### Automatic Traceability

```python
def extract_traceability_annotations(code):
    """Extract @spec annotations from code."""

    pattern = r'@spec\(([^)]+)\)'
    matches = re.findall(pattern, code)

    traceability = []
    for match in matches:
        spec_id = match.split(',')[0].strip().strip('"\'')
        traceability.append({
            'spec_id': spec_id,
            'file': file_path,
            'line': line_number
        })

    return traceability
```

### Code with Traceability

```typescript
// @spec(REQ-ORDER-001, "User can create order")
export async function createOrder(orderData: OrderRequest): Promise<Order> {
  // Implementation
}

// @spec(REQ-ORDER-002, "Order validation")
export function validateOrder(order: Order): ValidationResult {
  // Implementation
}

// @spec(REQ-ORDER-001, "User can create order")
describe('createOrder', () => {
  it('should create order successfully', async () => {
    // Test
  });
});
```

### Impact Analysis

```python
def analyze_impact(changed_files, traceability_matrix):
    """Analyze which requirements are affected by code changes."""

    affected_specs = set()

    for file in changed_files:
        for req in traceability_matrix:
            if file in req['files']:
                affected_specs.add(req['spec_id'])

    return list(affected_specs)
```
