---
name: code-generator-dispatcher
description: Use when dispatching deterministic tasks to appropriate traditional code generators based on pattern matching and generator capability. Part of D4.5 Generation Dispatch Domain.
---

# Code Generator Dispatcher

## Overview
Dispatch deterministic tasks to appropriate traditional code generators based on pattern matching, generator capability, and historical performance. Ensures optimal generator selection for maximum token savings and reliability.

## When to Use

```
Deterministic task identified? ──────────┐
                                         │
Need to select generator? ───────────────┤
                                         ├─► Use code-generator-dispatcher
Multiple generators available? ──────────┤
                                         │
Optimizing for token savings? ───────────┘
```

Use when:
- deterministic-evaluator has classified task as deterministic (score >= 0.8)
- Need to select the most appropriate traditional generator
- Multiple generators could handle the task
- Optimizing for token savings and reliability

Don't use when:
- Task is classified as non-deterministic
- No matching generator exists
- Only AI generation is available

## Core Pattern

### Dispatch Process

```
Deterministic Task
    ├── Pattern Analysis
    ├── Generator Registry Lookup
    ├── Capability Matching
    ├── Historical Performance Check
    └── Load Balancing
         |
         v
    Selected Generator
         |
         v
    Generation Execution
         |
         v
    Output Verification
```

### Generator Registry

| Generator | Patterns | Languages | Confidence |
|-----------|----------|-----------|------------|
| openapi-go-gin | REST API, OpenAPI | Go | 0.95 |
| sqlc-generator | SQL queries | Go | 0.92 |
| proto-gen-go | Protocol Buffers | Go | 0.94 |
| ent-generator | Entity models | Go | 0.88 |
| swagger-ts-axios | REST API, OpenAPI | TypeScript | 0.90 |
| prisma-generator | Database schema | TypeScript | 0.91 |

### Dispatch Rules

1. **Exact Pattern Match**: Select generator with highest pattern confidence
2. **Historical Performance**: Prefer generators with > 90% historical success
3. **Language Alignment**: Match target language of the project
4. **Load Balancing**: Distribute across available generators if multiple match
5. **Fallback Chain**: If primary fails, try secondary generators

## Input Format

```yaml
dispatch_request:
  task_id: "task-001"
  determinism_score: 0.92
  classification: highly_deterministic
  
  task_description:
    type: "rest_api"
    interface: "UserService"
    methods: ["Create", "Read", "Update", "Delete"]
    target_language: "go"
    framework: "gin"
  
  constraints:
    max_latency: "5s"
    preferred_generators: ["openapi-go-gin"]
    avoid_generators: []
```

## Output Format

```yaml
dispatch_result:
  task_id: "task-001"
  selected_generator: "openapi-go-gin"
  
  selection_reason:
    pattern_match: 0.95
    historical_success: 0.93
    language_match: true
    capability_match: true
  
  fallback_chain:
    - "openapi-go-fiber"
    - "generic-code-generator"
  
  execution:
    status: success
    output_path: "src/api/user.go"
    generated_lines: 245
    generation_time: "2.3s"
  
  token_savings:
    estimated_tokens_saved: 1200
    cost_reduction: "$0.024"
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: deterministic-evaluator, DispatchOrchestrator
- **Output to**: contract-consistency-gate, generated code
- **Part of**: D4.5 Generation Strategy Dispatch Domain

## Examples

### Example 1: API Endpoint Generation
```yaml
task: "Generate user CRUD endpoints"
generator: "openapi-go-gin"
reason: "Exact OpenAPI pattern match, 95% historical success"
output: "src/api/user.go"
token_savings: 1200
```

### Example 2: Database Model Generation
```yaml
task: "Generate user entity models"
generator: "ent-generator"
reason: "Entity pattern match, Go language alignment"
output: "src/ent/user.go"
token_savings: 800
```
