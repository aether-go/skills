---
name: requirement-analyzer
description: Use when collecting business requirements, decomposing goals into functional requirements, classifying them into 13 categories, mapping to business value via BMAD, defining metrics, and establishing traceability. This skill unifies L1→L2 derivation (D1 Value Derivation Domain) and replaces business-requirements-collector, business-value-mapper, requirement-classifier, value-decomposer, metrics-definer, and requirements-to-code-docs.
---

# Requirement Analyzer

## Overview

The unified entry point for all L1→L2 derivation work. This skill:
- Collects and structures business requirements from stakeholders
- Decomposes business goals into measurable functional requirements
- Classifies requirements into 13 ISO/IEC 25010:2023 categories
- Maps requirements to business value using the BMAD framework
- Defines metrics for tracking business and technical success
- Establishes traceability between business goals, functional requirements, and downstream artifacts

**Replaces** (consolidated from 6 skills):
- `business-requirements-collector`
- `business-value-mapper`
- `requirement-classifier`
- `value-decomposer`
- `metrics-definer`
- `requirements-to-code-docs`

## When to Use

```
Starting a new project? ───────────────────┐
                                           │
Need to clarify business goals? ───────────┤
                                           │
Establishing requirements traceability? ───┼─► Use requirement-analyzer
                                           │
Defining success metrics? ─────────────────┤
                                           │
Classifying existing requirements? ────────┘
```

Use when:
- Beginning a new project or feature initiative
- Need to translate business goals into actionable functional requirements
- Want to establish bidirectional traceability from business goals to implementation
- Need to define measurable success criteria
- Classifying existing requirements into the 13-category framework
- Generating documentation from requirements

Don't use when:
- Only writing test cases (use `test-planner`)
- Working on architecture decisions (use `architecture-planner`)
- Doing detailed technical specification (use `spec-engineer`)

## Core Pattern

### L1→L2 Derivation Pipeline

```
Business Goals (L1)
    │
    ├──► [1] Collect & Clarify (business-requirements-collector)
    │         │
    │         ▼
    │     Structured Requirements
    │         │
    │         ├──► [2] Classify by 13 categories (requirement-classifier)
    │         │         │
    │         │         ▼
    │         │     Categorized Requirements
    │         │         │
    │         │         ├──► [3] BMAD Value Mapping (business-value-mapper)
    │         │         │         │
    │         │         │         ▼
    │         │         │     Value Maps
    │         │         │
    │         │         ├──► [4] Decompose to FRs (value-decomposer)
    │         │         │         │
    │         │         │         ▼
    │         │         │     Functional Requirements
    │         │         │
    │         │         └──► [5] Define Metrics (metrics-definer)
    │         │                   │
    │         │                   ▼
    │         │               Measurable Criteria
    │         │
    │         └──► [6] Generate Docs (requirements-to-code-docs)
    │                   │
    │                   ▼
    │               Documentation Set
    │
    ▼
Functional Requirements (L2) with full traceability
```

### 13-Category Classification Framework (ISO/IEC 25010:2023)

All requirements are classified into one of 13 categories:

**3 Source Categories:**
| ID | Category | Description |
|----|----------|-------------|
| `REQ-BUS` | Business | High-level business goals and outcomes |
| `REQ-FUNC` | Functional | Required system behaviors and features |
| `REQ-USER` | User | User needs, personas, and journeys |

**8 Quality Categories:**
| ID | Category | ISO Characteristic |
|----|----------|---------------------|
| `REQ-PERF` | Performance | Performance efficiency |
| `REQ-COMP` | Compatibility | Compatibility |
| `REQ-USE` | Usability | Usability |
| `REQ-REL` | Reliability | Reliability |
| `REQ-SEC` | Security | Security |
| `REQ-MAIN` | Maintainability | Maintainability |
| `REQ-PORT` | Portability | Portability |
| `REQ-COMP-FUNC` | Functional Suitability | Functional suitability |

**2 Architecture/Data Categories:**
| ID | Category | Description |
|----|----------|-------------|
| `REQ-ARCH` | Architecture | Architectural constraints and decisions |
| `REQ-DATA` | Data | Data model and lifecycle requirements |

### Cross-Category Relationship Types

| Relation | Description |
|----------|-------------|
| `drives` | This requirement drives another |
| `constrains` | Imposes constraints on another |
| `mandates` | Mandatory dependency |
| `depends_on` | Has a dependency on |
| `conflicts_with` | Mutual exclusion or conflict |
| `trades_off` | Trade-off relationship |
| `validates` | Validates or verifies |
| `supports` | Provides support for |
| `enables` | Enables another |
| `influences` | Influences design or behavior |

## Input Format

```yaml
requirement_request:
  project:
    name: "Aether Platform"
    context: "Greenfield SaaS product"
    stakeholders:
      - {role: "Product Owner", name: "Alice"}
      - {role: "Tech Lead", name: "Bob"}
  
  # Phase 1: Initial Collection
  initial_signals:
    - "Reduce user onboarding time by 50%"
    - "Support 10K concurrent users"
    - "GDPR compliance required"
  
  # Or existing requirements to classify
  existing_requirements:
    - id: "BR-001"
      description: "Users should be able to sign up with email"
      source: "stakeholder-interview-2025-01-15"
  
  # Configuration
  classification:
    framework: "ISO-25010-2023"
    required_categories: ["REQ-BUS", "REQ-FUNC", "REQ-PERF", "REQ-SEC"]
  
  metrics:
    baseline_window: "30d"
    target_window: "90d"
  
  traceability:
    enabled: true
    storage: ".aether/state/traceability/"
```

## Output Format

```yaml
requirement_analysis_result:
  project: "Aether Platform"
  timestamp: "2026-06-02T10:00:00Z"
  
  # === Phase 1 Output: Collected Requirements ===
  business_goals:
    - id: "BG-001"
      statement: "Reduce user onboarding time by 50%"
      success_metric: "Time-to-first-value < 5 minutes"
      priority: "must"
      category: "REQ-BUS"
  
  # === Phase 2 Output: Classified Requirements ===
  classified_requirements:
    - id: "REQ-FUNC-001"
      category: "Functional"
      iso_subcharacteristic: "Functional completeness"
      statement: "Email/password signup with verification"
      priority: "must"
      traceability:
        source: "BG-001"
        relationships: [{target: "REQ-PERF-001", type: "constrains"}]
      acceptance_criteria:
        - "User submits email and password"
        - "System sends verification email within 30s"
        - "User clicks verification link, account activated"
  
  # === Phase 3 Output: BMAD Value Maps ===
  value_maps:
    - business_goal: "BG-001"
      metric: "Onboarding completion rate"
      current: 0.65
      target: 0.85
      action: "Implement streamlined signup flow"
      data: ["signup_events", "verification_events"]
  
  # === Phase 4 Output: Functional Requirements ===
  functional_requirements:
    - id: "FR-001"
      derived_from: "REQ-FUNC-001"
      statement: "POST /api/v1/auth/signup with email/password validation"
      api_contract:
        request: {email: "string", password: "string"}
        response_2xx: {user_id: "uuid", verification_token: "string"}
        response_4xx: [{code: 400, error: "invalid_email"}]
      test_criteria:
        - "Valid input creates user and returns 201"
        - "Duplicate email returns 409"
        - "Invalid email format returns 400"
  
  # === Phase 5 Output: Metrics Definition ===
  metrics:
    business_metrics:
      - name: "Onboarding completion rate"
        formula: "verified_users / signup_started"
        target: 0.85
        current: 0.65
        collection: "events.signup_completed / events.signup_started"
    technical_metrics:
      - name: "Signup API p95 latency"
        target: 200ms
        current: "TBD"
        collection: "http_server_requests_seconds_bucket"
  
  # === Phase 6 Output: Traceability & Docs ===
  traceability_matrix:
    BG-001 → [REQ-FUNC-001, REQ-PERF-001] → [FR-001, FR-002]
    coverage:
      functional: "100% (3/3 FRs traced)"
      business: "100% (2/2 goals traced)"
      orphans: []
  
  documentation:
    - path: ".aether/docs/requirements/business-goals.md"
      type: "goals"
    - path: ".aether/docs/requirements/functional-requirements.md"
      type: "functional"
    - path: ".aether/docs/requirements/traceability-matrix.md"
      type: "traceability"
```

## Implementation

### Step 1: Collect & Clarify Business Goals

Use the standard 6-question framework to clarify each business goal:

```python
def clarify_business_goal(goal: str) -> dict:
    """Apply 6 clarifying questions to a business goal."""
    return {
        "who": who_benefits_from_this(goal),
        "what": what_outcome_is_expected(goal),
        "when": when_is_success_measured(goal),
        "where": where_in_user_journey(goal),
        "why": why_is_this_important(goal),
        "how_much": what_is_the_target_metric(goal),
    }
```

Common business goal patterns:

| Pattern | Typical Decomposition |
|---------|----------------------|
| Grow user base | Multi-channel signup, onboarding, referral program |
| Increase revenue | Pricing tiers, payment integration, upsell flows |
| Reduce costs | Automation, performance optimization, caching |
| Improve UX | User research, A/B testing, accessibility |
| Ensure compliance | Audit trails, data governance, security controls |
| Scale operations | Load balancing, async processing, microservices |

### Step 2: Classify Requirements

Apply the 13-category framework to each requirement:

```python
def classify_requirement(requirement: dict) -> dict:
    """Classify a requirement into one of 13 categories."""
    # Analyze text, source, and stakeholder type
    # Match against category definitions
    # Detect cross-category relationships
    pass
```

Classification rules:
- Each requirement gets exactly one primary category
- Detect cross-category relationships (`drives`, `constrains`, etc.)
- Validate against ISO/IEC 25010:2023 subcharacteristics
- Flag ambiguous requirements for human review

### Step 3: BMAD Value Mapping

For each business goal, build a BMAD matrix:

```yaml
bmad_matrix:
  - business_goal: "Reduce onboarding time"
    metric: "Time-to-first-value"
    current: 12min
    target: 5min
    actions:
      - "Streamline signup (3 fields → 2)"
      - "Add social login (Google, GitHub)"
      - "Skip email verification for known domains"
    data_sources:
      - "events.signup_started"
      - "events.first_action_completed"
```

### Step 4: Decompose to Functional Requirements

Each requirement (especially `REQ-FUNC`) becomes one or more functional requirements with API contracts:

```yaml
functional_requirement:
  id: "FR-001"
  derived_from: "REQ-FUNC-001"
  statement: "System shall provide POST /api/v1/auth/signup endpoint"
  api_contract:
    method: POST
    path: "/api/v1/auth/signup"
    request_schema: {email: "string", password: "string"}
    response_2xx: {user_id: "uuid", verification_token: "string"}
    response_4xx: [{status: 400, error: "validation_failed"}]
    response_5xx: [{status: 500, error: "internal_error"}]
  test_criteria: [...]
  priority: "must"
  estimated_effort: "M"
```

### Step 5: Define Metrics

For each functional requirement, define:
- **Business metric**: KPI tied to business goal
- **Technical metric**: SLO/SLI for service quality
- **Collection method**: Where the metric data comes from

```yaml
metrics:
  business:
    - name: "Onboarding completion rate"
      formula: "verified_users / signup_started"
      target: 0.85
      collection: "events"
  technical:
    - name: "Signup API p95 latency"
      target: "200ms"
      collection: "prometheus"
    - name: "Error rate"
      target: "<0.1%"
      collection: "prometheus"
```

### Step 6: Generate Documentation & Traceability

Generate three artifacts:
1. **Per-category requirement files** in `.aether/docs/requirements/{category}.md`
2. **Traceability matrix** in `.aether/state/traceability/matrix.yml`
3. **Summary report** in `.aether/docs/requirements/README.md`

## Validation Rules

- ✅ Each functional requirement traces to at least one business goal
- ✅ Each business goal has at least one measurable metric
- ✅ Priorities are `must` / `should` / `could` / `won't`
- ✅ "Must" priority items have explicit acceptance criteria
- ✅ Cross-category relationships are detected and validated
- ✅ No orphan requirements (untraced to goals)
- ✅ No goal coverage gaps (each goal has at least one FR)

## Integration with Aether.go Methodology

- **Input from**: Stakeholders, business context, existing documentation
- **Output to**:
  - `architecture-planner` (L2 design)
  - `spec-engineer` (L3 specification)
  - `test-planner` (L4 test strategy)
- **Part of**: D1 Value Derivation Domain
- **Principle alignment**:
  - **P1 Purpose-Driven**: Every FR traces to a business goal
  - **P7 Context-First**: Goal clarification precedes implementation
  - **P9 Recursive-Optimization**: Metrics feedback drives improvement

## Examples

### Example 1: New E-commerce Project

```yaml
project: "Online marketplace"
business_goals:
  - "Increase seller signups by 200% in Q3"
  - "Reduce cart abandonment by 30%"
functional_requirements_count: 24
metrics_defined: 12
traceability_coverage: "100%"
```

### Example 2: Classifying Legacy Requirements

```yaml
input: 47 existing requirements from Confluence export
classified:
  REQ-FUNC: 18
  REQ-PERF: 6
  REQ-SEC: 8
  REQ-USER: 7
  REQ-DATA: 4
  REQ-ARCH: 4
cross_category_relations: 23
orphan_requirements: 0
coverage_gaps: []
```

## Migration Notes

This skill consolidates the following previously separate skills:
- `business-requirements-collector` — Phase 1 collection
- `business-value-mapper` — Phase 3 BMAD
- `requirement-classifier` — Phase 2 13-category
- `value-decomposer` — Phase 4 L1→L2 derivation
- `metrics-definer` — Phase 5 metrics
- `requirements-to-code-docs` — Phase 6 docs

For backward compatibility, the following keywords in skill-invocation context are still recognized:
- "collect requirements" → invokes Phase 1
- "classify" → invokes Phase 2
- "BMAD" / "value map" → invokes Phase 3
- "decompose" / "FR" → invokes Phase 4
- "define metric" / "KPI" → invokes Phase 5
- "generate docs" / "trace" → invokes Phase 6
