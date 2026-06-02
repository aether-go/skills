---
name: constitution-validator
description: Use when validating code and specifications against all 15 Aether constitutional principles (P0-P14), detecting principle conflicts, resolving via dynamic weighting, and enforcing mechanized constraints. This skill unifies the constitution enforcement layer and replaces constitution-validator, principle-consistency-checker, and constraint-check-runner.
---

# Constitution Validator

## Overview

The unified skill for validating compliance with the Aether constitutional principles. This skill:
- Validates code and specs against all 15 principles (P0–P14)
- Detects principle conflicts and resolves via dynamic weighting
- Executes mechanized constraints (GATE-001)
- Applies contextual exemptions (POC, emergency, legacy, AI-native)
- Generates compliance reports with severity levels

**Replaces** (consolidated from 3 skills):
- `constitution-validator`
- `principle-consistency-checker`
- `constraint-check-runner`

## 15 Constitutional Principles (Method Paper V3.0)

### Meta Principle

| # | Name | Description |
|---|------|-------------|
| **P0** | **Context-Adaptation** | Dynamically adjust principle strength based on project context (no rigid enforcement) |

### Planning Stage

| # | Name | Description |
|---|------|-------------|
| **P1** | **Purpose-Driven** | Technical decisions trace to business goals; ends with business value validation |
| **P2** | **Planning-Driven** | Detailed, verifiable planning before code; can be relaxed in AI-native mode |
| **P3** | **Intent-Hierarchization** | Layered intent (business/functional/implementation) with independent verification |

### Design Stage

| # | Name | Description |
|---|------|-------------|
| **P4** | **Modularity-Orthogonality** | High cohesion, low coupling, orthogonal concerns |
| **P5** | **Interface-First** | Interface contracts defined and validated before implementation |
| **P6** | **Occam's Razor** | Simplest design; core dependencies ≤ 5 |
| **P7** | **Constraint-Mechanization** | Constraints executable as automated rules, not manual review |

### Implementation & Generation Stage

| # | Name | Description |
|---|------|-------------|
| **P8** | **Tool-System-Adaptation** | Choose optimal generator (zero-token traditional vs AI) per task |
| **P9** | **Test-First** | Failing tests before implementation; tests protect refactoring |
| **P10** | **Context-First** | AI-assisted dev quality ∝ input context quality |
| **P11** | **Non-Functional-Built-in** | Performance/security/reliability defined as automated gates |

### Verification Stage

| # | Name | Description |
|---|------|-------------|
| **P12** | **Human-AI-Boundary** | Critical decisions human-confirmed; confidence-based AI routing |

### Evolution Stage

| # | Name | Description |
|---|------|-------------|
| **P13** | **Recursive-Self-Optimization** | Self-improvement via feedback ("execute-measure-learn-improve") |
| **P14** | **Knowledge-Engine-Skill-Assetization** | Code-graph, repo-wiki, skill library as org memory |

## When to Use

```
Need constitution compliance check? ────────┐
                                           │
Detecting principle conflicts? ─────────────┤
                                           │
Applying exemptions for scenario? ─────────┼─► Use constitution-validator
                                           │
Executing mechanized constraints? ─────────┤
                                           │
CI gate for principle compliance? ─────────┘
```

Use when:
- Validating code/specs against constitutional principles
- Resolving principle conflicts (P0 dynamic weighting)
- Enforcing constraints in CI
- Applying scenario-specific exemptions
- Generating compliance reports

## Core Pattern

### Validation Pipeline

```
Subject (code or spec)
    │
    ├──► [1] Load Active Principles (15 with strengths)
    │         │
    │         │  Applies P0 dynamic weighting:
    │         │  - emergency: reduce P9 to 0.4
    │         │  - POC: exempt P2, P5
    │         │  - AI-native: reduce P2 detail, strict P5+P7
    │         │
    │         ▼
    │     Active Principle Set
    │         │
    │         ├──► [2] Per-Principle Validation
    │         │         │
    │         │         ▼
    │         │     Per-Principle Reports
    │         │         │
    │         │         ├──► [3] Conflict Detection
    │         │         │         │
    │         │         │         ▼
    │         │         │     Conflict Report
    │         │         │
    │         │         └──► [4] Mechanized Constraint Checks (P7)
    │         │                   │
    │         │                   ▼
    │         │               Constraint Results
    │         │
    │         ▼
    │     Aggregated Compliance Report
    │         │
    │         ▼
    │     [5] Issue Routing
    │         │
    │         ├── PASS → Continue
    │         ├── WARNING → Log, continue
    │         └── FAIL → Block + notify
    │
    ▼
```

### Dynamic Principle Weighting (P0)

P0 (Context-Adaptation) dynamically adjusts principle strength:

| Scenario | Active Adjustments |
|----------|-------------------|
| **Standard** | All principles at 1.0 strength |
| **Emergency** | P9 (Test-First) → 0.4; P2 (Planning) → 0.5; 24h remediation required |
| **POC** | P2 (Planning) → exempt; P5 (Interface) → exempt; P6 (Occam) → 0.7 |
| **Legacy** | P2 (Planning) → exempt; P6 (Occam) → 0.5 (existing deps) |
| **AI-Native** | P2 (Planning) → 0.6 (structured intent); P5 (Interface) → 1.2 (strict); P7 (Constraint) → 1.2 (strict) |
| **Harness Reverse** | P2 (Planning) → exempt for legacy; new code → 1.0 |

### Mechanized Constraints (P7)

Constraints are loaded from `constraints/*.yml` and executed as automated checks:

```yaml
# constraints/dependencies.yml
name: "Dependency Bounds (P6)"
type: "dependency"
rule: "core_dependencies <= 5"
severity: "warning"
exempt_scenarios: ["legacy"]
tools:
  - "go mod graph | wc -l"
  - "npm ls --depth=0 | wc -l"
```

```yaml
# constraints/naming.yml
name: "Naming Conventions"
type: "naming"
rule: "package names lowercase, no underscores"
severity: "warning"
tools: ["golangci-lint"]
```

```yaml
# constraints/interface.yml
name: "Interface Compliance (P5)"
type: "interface"
rule: "all exported functions have declared interfaces"
severity: "error"
tools: ["go vet", "tsc --noEmit"]
```

```yaml
# constraints/performance.yml
name: "Performance Budget (P11)"
type: "performance"
rule: "p95 latency < 200ms for signup endpoint"
severity: "error"
tools: ["k6"]
```

### Confidence-Based Human-AI Boundary (P12)

| AI Confidence | Action | Human Review |
|---------------|--------|--------------|
| ≥ 0.90 | Auto-approve | None (audit log) |
| 0.70 – 0.90 | Suggest confirmation | Reviewer confirms |
| < 0.70 | Mandatory review | Required before merge |

## Input Format

```yaml
validation_request:
  subject:
    type: "code"  # code | spec | architecture
    path: "internal/auth/"
    files: ["user_service.go", "user_handler.go"]
  
  # Or for spec validation
  spec:
    type: "specification"
    id: "SPEC-FUNC-001"
  
  # Active scenario (drives P0 weighting)
  scenario: "standard"  # standard | emergency | poc | legacy | ai-native | harness-reverse
  
  # Override principle strengths (optional)
  principle_overrides:
    p9_test_first: 0.4  # For emergency
  
  # Constraints to enforce
  constraints:
    - path: "constraints/dependencies.yml"
    - path: "constraints/naming.yml"
    - path: "constraints/interface.yml"
    - path: "constraints/performance.yml"
  
  # Reporting
  report_format: "detailed"  # summary | detailed | json
  fail_on: "error"  # error | warning | never
```

## Output Format

### Summary Report

```yaml
validation_report:
  subject: "internal/auth/"
  scenario: "standard"
  timestamp: "2026-06-02T10:00:00Z"
  
  overall: "PASS"  # PASS | WARNING | FAIL
  summary:
    principles_checked: 15
    principles_passed: 14
    principles_warned: 1
    principles_failed: 0
    constraints_executed: 4
    constraints_passed: 4
    constraints_failed: 0
  
  principle_results:
    p0_context_adaptation: 
      status: PASS
      note: "Standard scenario, all principles at full strength"
    p1_purpose_driven:
      status: PASS
      evidence: "All functions trace to REQ-FUNC-001 via @purpose annotation"
    p2_planning_driven:
      status: PASS
      evidence: "ADR-003 exists for auth approach"
    p5_interface_first:
      status: PASS
      evidence: "UserService interface declared before implementation"
    p6_occams_razor:
      status: WARNING
      detail: "6 core dependencies detected (target ≤5)"
      suggestion: "Consider replacing custom logger with zap (already imported)"
    p7_constraint_mechanization:
      status: PASS
      evidence: "Constraints executed via GATE-001"
    p9_test_first:
      status: PASS
      evidence: "Test coverage: 87% (target 80%)"
    p11_non_functional_built_in:
      status: PASS
      evidence: "Performance budget configured, NFR tests in CI"
    # ... other principles
  
  constraint_results:
    - name: "Dependency Bounds (P6)"
      status: PASS
      result: "5 core dependencies"
    - name: "Naming Conventions"
      status: PASS
      result: "All packages comply"
    - name: "Interface Compliance (P5)"
      status: PASS
      result: "All exports have interfaces"
    - name: "Performance Budget (P11)"
      status: PASS
      result: "p95: 145ms < 200ms target"
  
  conflicts:
    - principles: ["P5", "P6"]
      description: "Interface segregation adds files vs Occam's minimalism"
      resolution: "Apply P5 (higher priority in AI-native mode)"
      weighted_score: {p5: 1.2, p6: 0.7}
  
  exemptions:
    - principle: "P2"
      scenario: "ai-native"
      rationale: "Structured intent replaces detailed planning"
  
  next_action: "proceed"
```

## Implementation

### Step 1: Load Active Principles

```python
def load_active_principles(scenario: str, overrides: dict = None) -> dict:
    """Load principle strengths adjusted for scenario."""
    base = {p: 1.0 for p in PRINCIPLES}  # All 15 at 1.0
    
    adjustments = {
        "emergency": {"p9": 0.4, "p2": 0.5},
        "poc": {"p2": 0, "p5": 0, "p6": 0.7},  # 0 = exempt
        "legacy": {"p2": 0, "p6": 0.5},
        "ai-native": {"p2": 0.6, "p5": 1.2, "p7": 1.2, "p8": 1.3},
        "harness-reverse": {"p2": 0},  # For legacy parts
    }
    
    if scenario in adjustments:
        for p, strength in adjustments[scenario].items():
            base[p] = strength
    
    if overrides:
        base.update(overrides)
    
    return base
```

### Step 2: Per-Principle Validation

For each principle, run automated checks:

| Principle | Automated Check | Tool |
|-----------|----------------|------|
| P1 Purpose-Driven | Trace from code to business goal | `@purpose` annotation, AST analysis |
| P2 Planning-Driven | ADRs exist for major decisions | ADR file presence |
| P3 Intent-Hierarchization | Intent layers present | `.aether/intent/` structure |
| P4 Modularity | Cyclomatic complexity, coupling | golangci-lint, custom metric |
| P5 Interface-First | Interfaces declared before impl | go vet, tsc |
| P6 Occam's Razor | Core deps ≤ 5 | go.mod, package.json |
| P7 Constraint-Mechanization | Constraints executable | GATE-001 presence |
| P8 Tool-System-Adaptation | Generator coverage tracked | metrics-tracker |
| P9 Test-First | Test coverage, test-first order | Coverage tool, git log |
| P10 Context-First | Context quality score | context-manager |
| P11 NFR-Built-in | NFR tests in CI | k6, OWASP ZAP |
| P12 Human-AI-Boundary | Confidence routing | generation-dispatcher |
| P13 Recursive-Optimization | Feedback loops present | recursive-optimizer |
| P14 Knowledge-Engine | Code graph exists | code-graph-analyzer |

### Step 3: Conflict Detection

Detect principles that conflict:

```python
def detect_conflicts(results: dict) -> list:
    """Identify principle conflicts and resolve."""
    conflicts = []
    # Example: P5 (Interface segregation) vs P6 (Occam's minimalism)
    if results["p5"]["status"] == "PASS" and results["p6"]["status"] == "WARNING":
        # Likely too many small interfaces
        if count_interfaces() > threshold:
            conflicts.append({
                "principles": ["p5", "p6"],
                "description": "Interface proliferation conflicts with minimalism",
                "resolution": "Apply P5 (interface stability) but consolidate related interfaces",
            })
    return conflicts
```

### Step 4: Mechanized Constraint Execution

```python
def execute_constraints(constraints: list, subject: dict) -> list:
    """Execute constraint checks from constraints/*.yml."""
    results = []
    for constraint in constraints:
        tool = constraint["tool"]
        rule = constraint["rule"]
        try:
            output = run_tool(tool, subject)
            result = evaluate_rule(rule, output)
            results.append({
                "name": constraint["name"],
                "status": "PASS" if result.passed else "FAIL",
                "result": result.detail,
            })
        except Exception as e:
            results.append({
                "name": constraint["name"],
                "status": "ERROR",
                "error": str(e),
            })
    return results
```

### Step 5: Issue Routing

```python
def route_issues(report: dict, fail_on: str) -> str:
    """Determine action based on report and threshold."""
    if report["summary"]["principles_failed"] > 0 and fail_on == "error":
        return "BLOCK"
    if report["summary"]["principles_warned"] > 0 and fail_on == "warning":
        return "WARN"
    return "PROCEED"
```

## Validation Rules

- ✅ All 15 principles evaluated for any subject
- ✅ Dynamic weighting applied per P0
- ✅ Conflicts detected and resolved with weighted priority
- ✅ Exemptions applied per scenario
- ✅ Constraints executed via GATE-001
- ✅ Compliance report generated with severity

## Integration with Aether.go Methodology

- **Input from**: Any code/spec subject
- **Output to**:
  - CI/CD pipeline (gate enforcement)
  - `architecture-auditor` (deep audit)
  - `metrics-tracker` (compliance trends)
- **Part of**: Constitution Enforcement Layer
- **Principle alignment**: Validates **all 15 principles** (P0-P14)

## CI/CD Integration

```yaml
# .github/workflows/constitution.yml
name: Constitution Check
on: [push, pull_request]
jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run constitution-validator
        run: |
          constitution-validator validate \
            --scenario "${{ vars.SCENARIO || 'standard' }}" \
            --constraints constraints/*.yml \
            --fail-on error
```

## Migration Notes

This skill consolidates 3 previously separate skills:
- `constitution-validator` — Per-principle validation
- `principle-consistency-checker` — Conflict detection + dynamic weighting
- `constraint-check-runner` — Mechanized constraint execution (GATE-001)

**Invocation parameters**:
- `action: validate` → All steps
- `action: weight` → Step 1 only (P0 dynamic weighting)
- `action: detect-conflicts` → Step 3
- `action: execute-constraints` → Step 4
- `action: report` → Generate report
