---
name: deterministic-evaluator
description: Use when evaluating the determinism score of a component contract or task to decide whether it should be routed to traditional code generators or AI generation channels. Part of D4.5 Generation Dispatch Domain.
---

# Deterministic Evaluator

## Overview
Evaluate the determinism score of a component contract or implementation task. Determines whether a task can be handled by traditional deterministic code generators (score >= 0.8) or requires AI generation (score < 0.8). Core component of Layer 4.5 generation strategy dispatch.

## When to Use

```
Component contract defined? ──────────────┐
                                         │
Need to choose generation strategy? ─────┤
                                         ├─► Use deterministic-evaluator
Task type unclear? ──────────────────────┤
                                         │
DispatchOrchestrator needs input? ───────┘
```

Use when:
- Component contracts are defined and generation strategy needs to be decided
- DispatchOrchestrator needs determinism evaluation input
- Need to classify tasks as deterministic vs AI-generated
- Optimizing token economics by maximizing deterministic generation

Don't use when:
- No component contracts exist
- Only code review is needed
- Task is purely creative with no patterns

## Core Pattern

### Evaluation Process

```
Component Contract / Task Description
    ├── Contract Completeness (0.3)
    ├── Pattern Match (0.25)
    ├── Historical Success (0.2)
    ├── Complexity (0.15)
    └── Context Stability (0.1)
         |
         v
    Determinism Score (0-1)
         |
         ├── >= 0.8 → Deterministic → Traditional Generator
         └── < 0.8 → Non-Deterministic → AI Generation
```

### Evaluation Dimensions

| Dimension | Weight | Description | Scoring Criteria |
|-----------|--------|-------------|-----------------|
| **Contract Completeness** | 0.30 | Are all interfaces, types, pre/post conditions fully defined? | 1.0 = fully defined, 0.0 = undefined |
| **Pattern Match** | 0.25 | Does a matching code generator pattern exist? | 1.0 = exact match, 0.0 = no match |
| **Historical Success** | 0.20 | Historical success rate of similar tasks | 1.0 = 100% success, 0.0 = 0% success |
| **Complexity** | 0.15 | Task complexity (inverse scoring) | 1.0 = simple, 0.0 = highly complex |
| **Context Stability** | 0.10 | Are dependencies and context stable? | 1.0 = stable, 0.0 = unstable |

### Score Classification

| Score Range | Classification | Recommended Action |
|-------------|---------------|-------------------|
| 0.90-1.00 | Highly Deterministic | Direct traditional generation, minimal review |
| 0.80-0.89 | Deterministic | Traditional generation + lightweight review |
| 0.60-0.79 | Semi-Deterministic | AI generation + enhanced review |
| 0.40-0.59 | Non-Deterministic | AI generation + full test loop |
| 0.00-0.39 | Highly Non-Deterministic | AI generation + mandatory human review |

## Input Format

```yaml
evaluation_request:
  task_id: "task-001"
  contract:
    interface: "UserService"
    methods:
      - name: "Register"
        input: "RegisterRequest"
        output: "RegisterResponse"
        errors: ["ValidationError", "DuplicateError"]
    types:
      - name: "RegisterRequest"
        fields:
          - {name: "email", type: "string", validation: "email"}
          - {name: "password", type: "string", validation: "min:8"}
    preconditions:
      - "email not exists in database"
    postconditions:
      - "user created with hashed password"
  
  available_generators:
    - "openapi-go-gin"
    - "sqlc-generator"
    - "proto-gen-go"
  
  historical_data:
    similar_tasks: 45
    success_rate: 0.93
  
  context:
    dependencies_stable: true
    schema_frozen: true
```

## Output Format

```yaml
evaluation_result:
  task_id: "task-001"
  determinism_score: 0.92
  classification: highly_deterministic
  
  dimension_scores:
    contract_completeness: 0.95
    pattern_match: 0.90
    historical_success: 0.93
    complexity: 0.85
    context_stability: 1.00
  
  recommendation:
    generation_type: deterministic
    generator: "openapi-go-gin"
    review_level: minimal
    estimated_token_savings: 1200
  
  confidence: 0.94
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: interface-contract-designer, component contract definitions
- **Output to**: code-generator-dispatcher, DispatchOrchestrator
- **Part of**: D4.5 Generation Strategy Dispatch Domain

## Examples

### Example 1: Highly Deterministic API Endpoint
```yaml
task: "Generate CRUD endpoints for User entity"
contract: {fully defined with OpenAPI spec}
pattern: "openapi-go-gin"
history: {95% success rate}
score: 0.95
result: deterministic
```

### Example 2: Non-Deterministic Business Logic
```yaml
task: "Implement recommendation algorithm"
contract: {partially defined}
pattern: none
history: {30% success rate}
score: 0.35
result: ai_generation
```
