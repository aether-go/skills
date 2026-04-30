---
name: confidence-based-reviewer
description: Use when grading AI-generated code confidence and routing to appropriate human review level. Implements confidence threshold routing with leaf node strategy. Part of D4.5 Generation Dispatch Domain and D5 Implementation Domain.
---

# Confidence-Based Reviewer

## Overview
Grade AI-generated code confidence and route to appropriate human review level. Implements confidence threshold routing (>90% auto-approve, 70-90% suggest confirmation, <70% mandatory human review) with leaf node strategy for high-confidence tasks.

## When to Use

```
AI code generated? ──────────────────────┐
                                         │
Need confidence grading? ────────────────┤
                                         ├─► Use confidence-based-reviewer
Human review routing needed? ────────────┤
                                         │
DispatchOrchestrator needs review? ──────┘
```

Use when:
- AI has generated code (non-deterministic tasks)
- Need to assess confidence level for human review routing
- DispatchOrchestrator needs review grading
- Optimizing human review effort through confidence-based routing

Don't use when:
- Code was generated deterministically (already verified by contract-consistency-gate)
- Only syntax checking is needed
- No human review process exists

## Core Pattern

### Confidence Grading Process

```
AI Generated Code
    ├── Code Quality Assessment
    ├── Contract Alignment Check
    ├── Test Coverage Evaluation
    ├── Pattern Consistency Check
    └── Historical Similarity Score
         |
         v
    Confidence Score (0-1)
         |
         ├── > 0.90 → Auto-approve (Leaf Node Strategy)
         ├── 0.70-0.90 → Suggest Confirmation
         └── < 0.70 → Mandatory Human Review
```

### Grading Dimensions

| Dimension | Weight | Description |
|-----------|--------|-------------|
| **Code Quality** | 0.30 | Syntax correctness, style compliance, complexity |
| **Contract Alignment** | 0.25 | Conformance to interface contracts |
| **Test Coverage** | 0.20 | Generated tests cover code paths |
| **Pattern Consistency** | 0.15 | Consistency with existing codebase patterns |
| **Historical Similarity** | 0.10 | Similarity to historically successful code |

### Confidence Threshold Routing

| Confidence Range | Action | Human Involvement | Review Type |
|-----------------|--------|-------------------|-------------|
| > 0.90 | Auto-approve | None (leaf node strategy) | Automated only |
| 0.70 - 0.90 | Suggest confirmation | Optional review | Lightweight |
| < 0.70 | Mandatory human review | Required | Full review |

### Leaf Node Strategy
When confidence > 0.90 and task is a leaf node (no further decomposition):
- Auto-approve without human intervention
- Log decision for audit
- Include in periodic review samples (5% sampling)

## Input Format

```yaml
review_request:
  task_id: "task-001"
  generated_code:
    path: "src/service/order.go"
    language: "go"
    lines: 128
    content: "..."
  
  contract:
    interface: "OrderService"
    methods: ["Create", "Cancel", "GetStatus"]
  
  context:
    existing_patterns: ["repository-pattern", "service-layer"]
    test_framework: "testify"
    code_style: "go-standard"
  
  historical_data:
    similar_tasks: 23
    success_rate: 0.87
```

## Output Format

```yaml
review_result:
  task_id: "task-001"
  confidence_score: 0.88
  grading: suggested_confirm
  
  dimension_scores:
    code_quality: 0.90
    contract_alignment: 0.85
    test_coverage: 0.82
    pattern_consistency: 0.92
    historical_similarity: 0.88
  
  routing:
    action: suggest_confirmation
    human_review_required: false
    review_type: lightweight
    auto_approve_eligible: false
  
  recommendations:
    - "Add edge case test for empty order"
    - "Consider extracting validation logic"
  
  leaf_node:
    is_leaf: true
    would_auto_approve: false  # confidence < 0.90
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: AI generation channel, DispatchOrchestrator
- **Output to**: HumanAIBoundaryGuard, L5 implementation layer
- **Part of**: D4.5 Generation Strategy Dispatch Domain, D5 Implementation Domain

## Examples

### Example 1: Auto-approve
```yaml
task: "Generate database migration"
confidence: 0.94
grading: auto_approve
action: proceed_without_review
reason: "High confidence, leaf node, deterministic pattern"
```

### Example 2: Suggest Confirmation
```yaml
task: "Implement payment webhook handler"
confidence: 0.82
grading: suggested_confirm
action: lightweight_review
reason: "Good confidence but complex business logic"
```

### Example 3: Mandatory Review
```yaml
task: "Implement recommendation algorithm"
confidence: 0.58
grading: mandatory_review
action: full_human_review
reason: "Novel algorithm, low historical similarity"
```
