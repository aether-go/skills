---
name: generation-dispatcher
description: Use when evaluating task determinism, dispatching to traditional code generators vs AI generation, enforcing contract consistency gates, and routing for confidence-based human review. This skill unifies D4.5 Generation Dispatch Domain and replaces deterministic-evaluator, code-generator-dispatcher, contract-consistency-gate, and confidence-based-reviewer.
---

# Generation Dispatcher

## Overview

The unified skill for all L4→L4.5 generation dispatch work. This skill:
- Evaluates the **determinism score** of component contracts/tasks
- Routes tasks to appropriate **traditional code generators** (zero-token) or **AI generation channels**
- Enforces **contract consistency gates** (GATE-001) on all generated code
- Grades AI-generated code **confidence** and routes for human review

**Replaces** (consolidated from 4 skills):
- `deterministic-evaluator`
- `code-generator-dispatcher`
- `contract-consistency-gate`
- `confidence-based-reviewer`

## When to Use

```
Need to route code generation task? ─────────┐
                                             │
Evaluating if task is deterministic? ────────┤
                                             │
Enforcing contract compliance gates? ────────┼─► Use generation-dispatcher
                                             │
Grading AI-generated code confidence? ───────┤
                                             │
Need economic optimization (zero-token)? ────┘
```

Use when:
- Deciding whether to use traditional generator vs AI for a task
- Enforcing contract consistency on generated code
- Routing AI-generated code for human review based on confidence
- Tracking generation cost savings (token economy)
- Implementing the L4→L4.5 dispatch layer

Don't use when:
- Pure requirement analysis (use `requirement-analyzer`)
- Spec writing (use `spec-engineer`)
- Actual code generation (use `code-generator`)
- Test code generation (use `test-planner`)

## Core Pattern

### L4→L4.5 Dispatch Pipeline

```
Interface Contracts (L4 input from architecture-planner)
    │
    ├──► [1] Determinism Evaluation
    │         │
    │         │  Score: D(t) ∈ [0, 1]
    │         │  Threshold: θ = 0.80
    │         │
    │         ├── if D(t) ≥ 0.80 → Highly Deterministic
    │         │      └──► [2a] Dispatch to Traditional Generator
    │         │              │
    │         │              ▼
    │         │          Generated Code (zero-token)
    │         │
    │         └── if D(t) < 0.80 → Non-Deterministic
    │                  └──► [2b] Route to AI Generation
    │                          │
    │                          ▼
    │                      AI-Generated Code
    │                          │
    │                          ├──► [3] Contract Consistency Gate (GATE-001)
    │                          │         │
    │                          │         ├── PASS → [4] Confidence Grading
    │                          │         │              │
    │                          │         │              ├── ≥ 0.90 → Auto-approve
    │                          │         │              ├── 0.70-0.90 → Suggest confirmation
    │                          │         │              └── < 0.70 → Mandatory review
    │                          │         │
    │                          │         └── FAIL → [5] Iterate / Reject
    │                          │
    │                          ▼
    │                      Final Code (L4.5 output)
    │
    ▼
```

### Determinism Evaluation Dimensions

| Dimension | Weight | Description |
|-----------|--------|-------------|
| **Contract Completeness** | 0.30 | How fully the contract specifies the task |
| **Pattern Match** | 0.25 | Match against known generator patterns (CRUD, REST, DTO) |
| **Historical Success** | 0.20 | Past success rate of similar tasks with traditional generators |
| **Complexity** | 0.15 | Cyclomatic/cognitive complexity of the task |
| **Context Stability** | 0.10 | Stability of inputs and expected outputs |

### Score Classification

| Range | Classification | Action |
|-------|----------------|--------|
| 0.90 – 1.00 | **Highly Deterministic** | Traditional generation, minimal review |
| 0.80 – 0.89 | **Deterministic** | Traditional generation + lightweight review |
| 0.60 – 0.79 | **Semi-Deterministic** | AI generation + enhanced review |
| 0.40 – 0.59 | **Non-Deterministic** | AI generation + full test loop |
| 0.00 – 0.39 | **Highly Non-Deterministic** | AI generation + mandatory human review |

**Threshold**: θ = 0.80 (configurable)

### Traditional Code Generators Registry

| Generator | Use Case | Input Format | Output Language |
|-----------|----------|--------------|-----------------|
| **openapi-generator** | REST APIs from OpenAPI spec | OpenAPI 3.0/3.1 | Go, Java, TS, etc. |
| **sqlc** | Type-safe SQL from queries | .sql files | Go |
| **oapi-codegen** | Go from OpenAPI | OpenAPI 3.0 | Go |
| **protoc** | gRPC services | .proto files | Go, Java, etc. |
| **Buf** | Protobuf linting/breaking | .proto files | Multiple |
| **Wire** | Go dependency injection | Provider configs | Go |
| **Kotlinx.serialization** | Kotlin serialization | JsonSchema | Kotlin |
| **Vue Codegen** | Vue components from JSON | JSON Schema | Vue + TS |
| **JHipster** | Full Spring Boot + Angular app | JDL | Java + TS |
| **Terraformer** | IaC from cloud state | Cloud state | Terraform |
| **CUE** | Data validation & generation | CUE files | Multiple |

## Input Format

```yaml
dispatch_request:
  project: "Aether Platform"
  
  tasks:
    - id: "T-001"
      description: "Generate POST /users endpoint with validation"
      interface_contract: "IC-User-001"
      language: "go"
      framework: "gin"
    - id: "T-002"
      description: "Implement password hashing with bcrypt"
      interface_contract: "IC-Auth-002"
      language: "go"
  
  # Determinism configuration
  determinism_threshold: 0.80
  
  # Generator registry (or use default)
  generators:
    - name: "openapi-generator"
      enabled: true
      version: "7.0.0"
    - name: "sqlc"
      enabled: true
      version: "1.25.0"
  
  # GATE-001 configuration
  gate:
    enabled: true
    checks:
      - "interface_compliance"
      - "type_safety"
      - "behavior_match"
      - "dependency_bounds"
      - "performance_budget"
  
  # Confidence thresholds
  confidence:
    auto_approve: 0.90
    suggest_confirmation: 0.70
    mandatory_review: 0.00
  
  # Economic tracking
  track_costs: true
```

## Output Format

```yaml
dispatch_result:
  project: "Aether Platform"
  timestamp: "2026-06-02T10:00:00Z"
  
  task_results:
    - task_id: "T-001"
      description: "POST /users endpoint"
      
      # === Step 1: Determinism Evaluation ===
      determinism_evaluation:
        contract_completeness: 0.95
        pattern_match: 0.90
        historical_success: 0.92
        complexity: 0.30  # Low complexity
        context_stability: 0.95
        score: 0.85
        classification: "Deterministic"
        threshold_met: true
      
      # === Step 2a: Traditional Generator Dispatch ===
      dispatch:
        generator: "oapi-codegen"
        generator_version: "1.12.0"
        estimated_tokens: 0
        estimated_time_seconds: 5
        output_path: "internal/api/user_handler.go"
      
      # === Step 3: Contract Consistency Gate ===
      gate:
        result: "PASS"
        checks:
          interface_compliance: PASS
          type_safety: PASS
          behavior_match: PASS
          dependency_bounds: PASS
          performance_budget: PASS
      
      # === Step 4: Confidence Grading (for traditional) ===
      confidence:
        score: 0.99  # Deterministic generators are near-100% reliable
        grade: "high"
        action: "auto_approve"
        human_review_required: false
      
      generated_files:
        - path: "internal/api/user_handler.go"
          lines: 87
          confidence: 0.99
    
    - task_id: "T-002"
      description: "Password hashing with bcrypt"
      
      determinism_evaluation:
        contract_completeness: 0.80
        pattern_match: 0.70
        historical_success: 0.85
        complexity: 0.40
        context_stability: 0.90
        score: 0.73
        classification: "Semi-Deterministic"
        threshold_met: false
      
      # === Step 2b: AI Generation ===
      dispatch:
        channel: "ai_generation"
        model: "claude-opus-4"
        estimated_tokens: 2500
        estimated_cost_usd: 0.075
        output_path: "internal/auth/password.go"
      
      gate:
        result: "PASS"
        checks:
          interface_compliance: PASS
          type_safety: PASS
          behavior_match: PASS
          dependency_bounds: PASS
          performance_budget: PASS
      
      confidence:
        score: 0.87
        grade: "medium"
        action: "suggest_confirmation"
        human_review_required: true
        review_priority: "medium"
        suggested_reviewer: "auth-team-lead"
      
      generated_files:
        - path: "internal/auth/password.go"
          lines: 45
          confidence: 0.87
  
  # === Economic Summary ===
  economics:
    total_tasks: 2
    traditional_generated: 1
    ai_generated: 1
    tokens_saved: 0  # By using traditional for T-001
    ai_tokens_used: 2500
    estimated_cost_usd: 0.075
    generation_coverage_rate: 0.50  # 50% deterministic
    efficiency_ratio: 0.50  # 50% zero-token
  
  # === Gate Summary ===
  gate_summary:
    total_checks: 10
    passed: 10
    failed: 0
    warnings: 0
```

## Implementation

### Step 1: Determinism Evaluation

```python
def evaluate_determinism(task: dict) -> dict:
    """Score the determinism of a generation task."""
    scores = {
        "contract_completeness": score_contract_completeness(task),
        "pattern_match": score_pattern_match(task),
        "historical_success": score_historical_success(task),
        "complexity": score_complexity(task),  # Lower complexity = higher determinism
        "context_stability": score_context_stability(task),
    }
    weights = {
        "contract_completeness": 0.30,
        "pattern_match": 0.25,
        "historical_success": 0.20,
        "complexity": 0.15,
        "context_stability": 0.10,
    }
    total = sum(scores[k] * weights[k] for k in scores)
    return {
        "scores": scores,
        "score": total,
        "classification": classify(total),
        "threshold_met": total >= 0.80,
    }
```

**Determinism Indicators** (boost score):
- Input fully specified by OpenAPI/JSON Schema
- Output structure mechanical-mapped from input
- No business rule variants
- Template-able pattern (CRUD, DTO, REST routes, DB migrations)

**Non-Determinism Indicators** (lower score):
- Complex business rules with variants
- State machine with edge cases
- Ambiguous error handling strategy
- Novel algorithm or pattern

### Step 2a: Traditional Generator Dispatch

```python
def dispatch_traditional(task: dict, generators: list) -> dict:
    """Match task to appropriate traditional generator."""
    matches = match_generators(task, generators)
    if not matches:
        return {"generator": None, "fallback": "ai_generation"}
    best = matches[0]
    return {
        "generator": best.name,
        "version": best.version,
        "estimated_tokens": 0,
        "estimated_time_seconds": estimate_time(best, task),
        "command": best.generate_command(task),
    }
```

### Step 2b: AI Generation Routing

```python
def route_ai(task: dict) -> dict:
    """Route non-deterministic task to AI generation."""
    return {
        "channel": "ai_generation",
        "model": select_model(task),  # Based on complexity
        "estimated_tokens": estimate_tokens(task),
        "estimated_cost_usd": estimate_cost(task),
        "context_files": gather_context(task),
    }
```

### Step 3: Contract Consistency Gate (GATE-001)

For all generated code (traditional or AI), verify:

| Check | Description | Tool |
|-------|-------------|------|
| **Interface Compliance** | Implements declared interface | go vet, TypeScript compiler |
| **Type Safety** | Types match across boundaries | go vet, tsc |
| **Behavior Match** | Output matches contract semantics | Integration tests |
| **Dependency Bounds** | Within P5 limit (≤5 core deps) | dep check, custom rule |
| **Performance Budget** | Within declared NFR budget | Benchmarks, load tests |

```python
def enforce_gate(code: str, contract: dict) -> dict:
    """Run GATE-001 checks on generated code."""
    results = {
        "interface_compliance": check_interface(code, contract),
        "type_safety": check_types(code, contract),
        "behavior_match": check_behavior(code, contract),
        "dependency_bounds": check_deps(code, max_deps=5),
        "performance_budget": check_perf(code, contract.perf_budget),
    }
    all_pass = all(r.status == "PASS" for r in results.values())
    return {
        "result": "PASS" if all_pass else "FAIL",
        "checks": results,
    }
```

### Step 4: Confidence-Based Routing

For AI-generated code, grade confidence and route:

| Confidence | Action | Human Review |
|------------|--------|--------------|
| ≥ 0.90 | **Auto-approve** | None (audit log only) |
| 0.70 – 0.90 | **Suggest confirmation** | Reviewer confirms or rejects |
| 0.00 – 0.70 | **Mandatory review** | Reviewer must approve before merge |

**Confidence Sources** (weighted):
- Model's own confidence score (40%)
- Test pass rate on generated code (30%)
- Contract gate result (15%)
- Historical patterns from similar tasks (10%)
- Code complexity metrics (5%)

```python
def grade_confidence(generated_code: str, tests_passed: bool, 
                     gate_result: dict, similar_history: list) -> dict:
    """Grade AI-generated code confidence."""
    model_conf = get_model_confidence(generated_code)
    test_score = 1.0 if tests_passed else 0.5
    gate_score = 1.0 if gate_result["result"] == "PASS" else 0.0
    history_score = avg(similar_history) if similar_history else 0.5
    complexity_score = 1.0 - measure_complexity(generated_code) / 10
    
    total = (model_conf * 0.40 + test_score * 0.30 + 
             gate_score * 0.15 + history_score * 0.10 + 
             complexity_score * 0.05)
    
    return {
        "score": total,
        "grade": "high" if total >= 0.90 else "medium" if total >= 0.70 else "low",
        "action": "auto_approve" if total >= 0.90 
                  else "suggest_confirmation" if total >= 0.70
                  else "mandatory_review",
    }
```

### Economic Tracking

Track cost savings from using traditional generators:

```yaml
economics:
  total_tasks: N
  traditional_generated: M
  ai_generated: K  # K = N - M
  tokens_saved: sum(ai_tokens_estimate) for traditional tasks
  ai_tokens_used: actual tokens for AI tasks
  estimated_cost_usd: cost of AI tokens
  generation_coverage_rate: M / N  # % of tasks zero-token
  efficiency_ratio: tokens_saved / (tokens_saved + ai_tokens_used)
```

## Validation Rules

- ✅ All tasks have determinism score before dispatch
- ✅ All generated code passes GATE-001 (no exceptions)
- ✅ AI confidence < 0.70 always requires human review (P12)
- ✅ Traditional generator coverage tracked per iteration
- ✅ Economic metrics exported to `metrics-tracker`

## Integration with Aether.go Methodology

- **Input from**:
  - `architecture-planner` (interface contracts)
  - `test-planner` (test contracts)
- **Output to**:
  - `code-generator` (actual code generation)
  - `metrics-tracker` (cost/efficiency metrics)
  - `constitution-validator` (P8, P12 enforcement)
- **Part of**: D4.5 Generation Dispatch Domain
- **Principle alignment**:
  - **P8 Tool-System-Adaptation**: Optimal generator selection
  - **P7 Constraint-Mechanization**: GATE-001 enforcement
  - **P12 Human-AI-Boundary**: Confidence-based routing
  - **P11 Non-Functional-Built-in**: Performance gate

## Examples

### Example 1: Standard CRUD API

```yaml
tasks: 12
traditional_generated: 9  # CRUD endpoints from OpenAPI
ai_generated: 3  # Complex business logic
tokens_saved: 28000
cost_usd: 0.12
coverage_rate: 0.75
gate_result: 12/12 PASS
```

### Example 2: Mixed System

```yaml
tasks: 30
traditional_generated: 18  # Schemas, migrations, simple handlers
ai_generated: 12  # Business rules, state machines, complex logic
coverage_rate: 0.60
gates_failed: 0
human_review_required: 4
```

## Migration Notes

This skill consolidates the following previously separate skills:
- `deterministic-evaluator` — Step 1
- `code-generator-dispatcher` — Step 2a
- `contract-consistency-gate` — Step 3
- `confidence-based-reviewer` — Step 4

**Invocation parameters**:
- `action: evaluate` → Step 1
- `action: dispatch` → Step 2 (a or b)
- `action: gate` → Step 3
- `action: grade` → Step 4
- `action: full` (default) → All steps
