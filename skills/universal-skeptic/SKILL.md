---
name: universal-skeptic
description: Use when performing cross-domain skepticism verification covering correctness, completeness, consistency, and boundedness. This skill unifies the skeptic verification layer and replaces correctness-checker, completeness-checker, consistency-checker, and boundedness-checker.
---

# Universal Skeptic

## Overview

The unified skill for cross-domain skepticism verification. This skill orchestrates four dimensions of skeptical verification:
- **Correctness**: Factual accuracy and logical consistency
- **Completeness**: Coverage of all required elements
- **Consistency**: Cross-layer and cross-domain alignment
- **Boundedness**: Optimization limits and termination

**Replaces** (consolidated from 4 skills):
- `correctness-checker`
- `completeness-checker`
- `consistency-checker`
- `boundedness-checker`

## When to Use

```
Need to verify AI-generated content? ────────┐
                                             │
Validating output before deployment? ────────┤
                                             │
Need cross-layer consistency check? ─────────┼─► Use universal-skeptic
                                             │
Verifying optimization stays bounded? ───────┤
                                             │
Reviewing spec/code/spec coherence? ─────────┘
```

## 4 Verification Dimensions

| Dimension | Question | Checks |
|-----------|----------|--------|
| **Correctness** | Is it factually accurate? | Facts, technical claims, logic |
| **Completeness** | Does it cover everything? | Required elements, edge cases, scenarios |
| **Consistency** | Do all parts agree? | Cross-layer, cross-domain alignment |
| **Boundedness** | Will it stay within limits? | Optimization bounds, termination |

## Core Pattern

```
Subject (artifact, decision, output)
    │
    ├──► [1] Correctness Check
    │         ├── Fact verification
    │         ├── Logical consistency
    │         ├── Technical accuracy
    │         └── Reference standards
    │
    ├──► [2] Completeness Check
    │         ├── Required elements present
    │         ├── Edge cases covered
    │         ├── Scenarios enumerated
    │         └── Documentation complete
    │
    ├──► [3] Consistency Check
    │         ├── Cross-layer alignment
    │         ├── Cross-domain coherence
    │         ├── Terminology consistent
    │         └── Traceability intact
    │
    └──► [4] Boundedness Check
              ├── Optimization within limits
              ├── Termination criteria met
              ├── Resource usage bounded
              └── No runaway changes
    │
    ▼
Verification Report
```

## Input Format

```yaml
skeptic_request:
  subject:
    type: "code"  # code | spec | decision | output
    identifier: "auth-service"
  
  dimensions:
    - "correctness"
    - "completeness"
    - "consistency"
    - "boundedness"
  
  # Optional: focused dimension
  focus: null  # "correctness" | "completeness" | "consistency" | "boundedness"
  
  # Context for checks
  context:
    spec_references: ["SPEC-FUNC-001", "SPEC-FUNC-002"]
    related_components: ["user-service", "email-service"]
    standards: ["ISO-25010-2023", "OWASP-Top-10"]
  
  # For boundedness check
  optimization_context:
    target_metric: "test_coverage"
    current: 0.78
    target: 0.85
    history: [0.70, 0.72, 0.75, 0.78]
    max_iterations: 10
```

## Output Format

```yaml
skeptic_report:
  subject: "auth-service"
  timestamp: "2026-06-02T10:00:00Z"
  
  overall_verdict: "PASS"  # PASS | PASS_WITH_CONCERNS | FAIL
  
  # === Dimension 1: Correctness ===
  correctness:
    status: "PASS"
    score: 0.95
    checks:
      - {check: "Password hashing uses bcrypt", result: "PASS"}
      - {check: "JWT validation uses HS256", result: "PASS"}
      - {check: "Rate limiting at 100 req/min", result: "PASS"}
      - {check: "OWASP top 10 compliance", result: "PASS"}
    issues: []
  
  # === Dimension 2: Completeness ===
  completeness:
    status: "PASS_WITH_CONCERNS"
    score: 0.88
    checks:
      - {check: "All 8 functional requirements implemented", result: "PASS"}
      - {check: "Positive paths covered", result: "PASS"}
      - {check: "Negative paths covered", result: "PASS"}
      - {check: "Boundary conditions covered", result: "WARNING", detail: "Missing: max email length boundary"}
      - {check: "Error cases covered", result: "PASS"}
    issues:
      - severity: "low"
        description: "Missing boundary test for max email length (320 chars per RFC 5321)"
        recommendation: "Add test for max email length"
  
  # === Dimension 3: Consistency ===
  consistency:
    status: "PASS"
    score: 0.93
    checks:
      - {check: "Spec ↔ Code alignment", result: "PASS", detail: "All 8 FRs implemented as spec'd"}
      - {check: "L1-L5 traceability", result: "PASS", detail: "100% bidirectional"}
      - {check: "Terminology consistent", result: "PASS"}
      - {check: "Cross-component contracts aligned", result: "PASS"}
    issues: []
  
  # === Dimension 4: Boundedness ===
  boundedness:
    status: "PASS"
    score: 1.0
    checks:
      - {check: "Test coverage improvement bounded", result: "PASS", detail: "Monotonically increasing: 0.70 → 0.78"}
      - {check: "Token consumption bounded", result: "PASS", detail: "Below budget"}
      - {check: "Iteration limit respected", result: "PASS", detail: "8/10 iterations used"}
      - {check: "Convergence criteria met", result: "PASS", detail: "Δ=0.03, within ε=0.05"}
    issues: []
  
  # === Summary ===
  summary:
    dimensions_passed: 4
    dimensions_with_concerns: 1
    dimensions_failed: 0
    total_issues: 1
    critical_issues: 0
    
  recommendation: "Approve with minor follow-up: add max email length boundary test"
```

## Implementation

### Correctness Check

```python
def check_correctness(subject: dict, standards: list) -> dict:
    """Verify factual and technical accuracy."""
    issues = []
    # Check against known standards
    for standard in standards:
        violations = check_against_standard(subject, standard)
        issues.extend(violations)
    # Check logical consistency
    logical_issues = check_logical_consistency(subject)
    issues.extend(logical_issues)
    return {
        "status": "PASS" if not issues else "FAIL",
        "score": 1.0 - len(issues) / 10,
        "issues": issues,
    }
```

### Completeness Check

```python
def check_completeness(subject: dict, requirements: list) -> dict:
    """Verify all required elements are present."""
    missing = []
    for req in requirements:
        if not has_element(subject, req):
            missing.append({"requirement": req, "status": "MISSING"})
    return {
        "status": "PASS" if not missing else "WARNING" if len(missing) <= 2 else "FAIL",
        "score": 1.0 - len(missing) / len(requirements),
        "missing": missing,
    }
```

### Consistency Check

```python
def check_consistency(subject: dict, references: list) -> dict:
    """Verify cross-layer/cross-domain alignment."""
    issues = []
    for ref in references:
        alignment = check_alignment(subject, ref)
        if not alignment["aligned"]:
            issues.append({
                "type": "alignment",
                "reference": ref["name"],
                "discrepancy": alignment["discrepancy"],
            })
    return {
        "status": "PASS" if not issues else "FAIL",
        "score": 1.0 - len(issues) / max(len(references), 1),
        "issues": issues,
    }
```

### Boundedness Check

```python
def check_boundedness(history: list, target: float, max_iterations: int) -> dict:
    """Verify optimization stays bounded."""
    # Monotonicity
    monotonic = all(history[i] <= history[i+1] for i in range(len(history)-1))
    # Boundedness
    bounded = all(0 <= h <= 1.0 for h in history)
    # Termination
    converged = abs(history[-1] - target) < 0.05
    # Iteration limit
    within_limit = len(history) <= max_iterations
    return {
        "monotonic": monotonic,
        "bounded": bounded,
        "converged": converged,
        "within_iteration_limit": within_limit,
        "status": "PASS" if all([monotonic, bounded, within_limit]) else "FAIL",
    }
```

## Validation Rules

- ✅ All 4 dimensions evaluated (or focused subset)
- ✅ Issues categorized by severity
- ✅ Recommendations actionable
- ✅ PASS / PASS_WITH_CONCERNS / FAIL verdict clear
- ✅ Traceability to standards maintained

## Integration with Aether.go Methodology

- **Input from**: Any artifact, output, or decision
- **Output to**:
  - `methodology-fusion-orchestrator` (skepticism reports)
  - `architecture-auditor` (skeptical findings)
  - `recursive-optimizer` (optimization bounds)
- **Part of**: Skeptic Verification Layer
- **Principle alignment**:
  - **P12 Human-AI-Boundary**: Critical decisions verified
  - **P13 Recursive-Optimization**: Boundedness check

## Migration Notes

This skill consolidates 4 previously separate skills:
- `correctness-checker` → Dimension 1
- `completeness-checker` → Dimension 2
- `consistency-checker` → Dimension 3
- `boundedness-checker` → Dimension 4

**Invocation parameters**:
- `dimensions: [correctness, completeness, consistency, boundedness]` → All (default)
- `focus: correctness` → Single dimension
- `focus: boundedness` → Single dimension (most common for recursive optimization)
