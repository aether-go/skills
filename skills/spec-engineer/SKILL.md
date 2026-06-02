---
name: spec-engineer
description: Use when parsing requirements into structured specifications, designing use cases, writing Gherkin BDD scenarios, generating ATDD acceptance tests, validating scenario completeness, analyzing NFRs, and managing spec versions. This skill unifies D3 Specification Derivation Domain and replaces spec-parser, usecase-designer, bdd-scenario-writer, atdd-acceptance-test-generator, spec-to-scenario, scenario-completeness-checker, nfr-analyzer, and spec-version-manager.
---

# Spec Engineer

## Overview

The unified skill for all L2→L3 specification work. This skill:
- Parses natural language requirements into structured technical specifications
- Designs use cases with bidirectional traceability
- Writes Gherkin BDD scenarios in Given-When-Then format
- Generates executable ATDD acceptance tests
- Validates scenario coverage completeness (positive/negative/boundary)
- Analyzes non-functional requirements (NFRs) per ISO/IEC 25010:2023
- Manages specification versions with evolution tracking

**Replaces** (consolidated from 8 skills):
- `spec-parser`
- `usecase-designer`
- `bdd-scenario-writer`
- `atdd-acceptance-test-generator`
- `spec-to-scenario`
- `scenario-completeness-checker`
- `nfr-analyzer`
- `spec-version-manager`

## When to Use

```
Need to write technical specs? ──────────────┐
                                             │
Designing use cases? ────────────────────────┤
                                             │
Writing GWT / BDD scenarios? ────────────────┼─► Use spec-engineer
                                             │
Generating executable acceptance tests? ─────┤
                                             │
Analyzing non-functional requirements? ──────┤
                                             │
Managing spec versions? ─────────────────────┘
```

Use when:
- Translating requirements into structured specifications
- Designing use cases from functional requirements
- Writing Gherkin feature files for BDD
- Creating executable ATDD tests (Cypress, Playwright, etc.)
- Checking scenario coverage (positive/negative/boundary)
- Analyzing NFRs (performance, security, reliability, etc.)
- Tracking spec evolution over time

Don't use when:
- Pure business analysis (use `requirement-analyzer`)
- Architecture decisions (use `architecture-planner`)
- Test code generation beyond acceptance tests (use `test-planner`)

## Core Pattern

### L2→L3 Specification Pipeline

```
Functional Requirements (L2 input)
    │
    ├──► [1] Parse into Structured Specs (spec-parser)
    │         │
    │         ▼
    │     Structured Specifications
    │         │
    │         ├──► [2] Design Use Cases (usecase-designer)
    │         │         │
    │         │         ▼
    │         │     Use Case Models
    │         │         │
    │         │         ├──► [3] Write GWT Scenarios (bdd-scenario-writer)
    │         │         │         │
    │         │         │         ▼
    │         │         │     Gherkin Feature Files
    │         │         │
    │         │         ├──► [4] Generate ATDD Tests (atdd-acceptance-test-generator)
    │         │         │         │
    │         │         │         ▼
    │         │         │     Executable Acceptance Tests
    │         │         │
    │         │         └──► [5] Validate Completeness (scenario-completeness-checker)
    │         │                   │
    │         │                   ▼
    │         │               Coverage Report
    │         │
    │         ├──► [6] Analyze NFRs (nfr-analyzer)
    │         │         │
    │         │         ▼
    │         │     NFR Specifications
    │         │
    │         └──► [7] Manage Versions (spec-version-manager)
    │                   │
    │                   ▼
    │               Versioned Specs
    │
    ▼
Acceptance Specifications (L3 output) with traceability
```

### 13-Category Spec Templates (per ISO/IEC 25010:2023)

The skill uses a 13-category template structure that mirrors the requirement categories:

| Template ID | Category | Type |
|-------------|----------|------|
| `SPEC-BUS-{N}` | Business | Source |
| `SPEC-FUNC-{N}` | Functional | Source |
| `SPEC-USER-{N}` | User | Source |
| `SPEC-PERF-{N}` | Performance | Quality |
| `SPEC-COMPAT-{N}` | Compatibility | Quality |
| `SPEC-USE-{N}` | Usability | Quality |
| `SPEC-REL-{N}` | Reliability | Quality |
| `SPEC-SEC-{N}` | Security | Quality |
| `SPEC-MAIN-{N}` | Maintainability | Quality |
| `SPEC-PORT-{N}` | Portability | Quality |
| `SPEC-FUNC-SUIT-{N}` | Functional Suitability | Quality |
| `SPEC-ARCH-{N}` | Architecture | Cross-cutting |
| `SPEC-DATA-{N}` | Data | Cross-cutting |

### Gherkin BDD Structure

```gherkin
Feature: User authentication
  
  Background:
    Given a registered user with email "user@example.com"
    And the user is not currently logged in
  
  Scenario: Successful login
    When the user submits valid credentials
    Then the system returns a JWT token
    And logs the login event
    
  Scenario: Invalid password
    When the user submits an invalid password
    Then the system returns 401 Unauthorized
    And increments the failed login counter
    
  Scenario: Account locked after 5 failures
    Given the user has 4 consecutive failed logins
    When the user submits an invalid password
    Then the system returns 401 Unauthorized
    And locks the account for 15 minutes
    
  Scenario Outline: Email format validation
    When the user submits email "<email>"
    Then the response status is <status>
    
    Examples:
      | email              | status |
      | user@example.com   | 201    |
      | invalid            | 400    |
      | @example.com       | 400    |
```

### Use Case Template

```yaml
use_case:
  id: "UC-001"
  name: "Register new user"
  primary_actor: "End user"
  secondary_actors: ["Email service", "Audit logger"]
  
  preconditions:
    - "User is not already registered"
    - "Email service is available"
  
  postconditions:
    success:
      - "User account created in database"
      - "Verification email sent"
      - "Audit log entry created"
    failure:
      - "No partial state in database"
  
  main_flow:
    - step: 1
      actor: "End user"
      action: "Submits email and password"
    - step: 2
      actor: "System"
      action: "Validates input format"
    - step: 3
      actor: "System"
      action: "Hashes password (bcrypt)"
    - step: 4
      actor: "System"
      action: "Persists user record"
    - step: 5
      actor: "System"
      action: "Queues verification email"
  
  alternative_flows:
    - id: "AF-1"
      trigger: "Email already registered"
      result: "Return 409 Conflict"
    - id: "AF-2"
      trigger: "Email service unavailable"
      result: "Persist user, retry email send async"
  
  traceability:
    fr: ["FR-001"]
    requirements: ["REQ-FUNC-001"]
    scenarios: ["scenario_signup_success", "scenario_signup_duplicate"]
```

## Input Format

```yaml
spec_engineering_request:
  project: "Aether Platform"
  source: "requirement-analyzer"  # upstream skill
  
  # Parsing input
  requirements:
    - id: "REQ-FUNC-001"
      statement: "User signup with email and password"
      priority: "must"
  
  # Use case design input
  actors:
    - {id: "user", type: "primary"}
    - {id: "admin", type: "secondary"}
  
  # BDD input
  bdd_framework: "gherkin"  # gherkin | specflow | cucumber
  
  # ATDD input
  atdd_framework: "playwright"  # playwright | cypress | selenium
  
  # NFR input
  nfr_targets:
    performance: {p95_latency_ms: 200, throughput_rps: 1000}
    security: {auth: "jwt", encryption: "TLS1.3"}
    reliability: {uptime: "99.9%", recovery_rto: "1h"}
  
  # Versioning
  versioning:
    enabled: true
    storage: ".aether/state/specs/"
```

## Output Format

```yaml
spec_engineering_result:
  project: "Aether Platform"
  timestamp: "2026-06-02T10:00:00Z"
  
  # === Step 1 Output: Structured Specs ===
  structured_specs:
    - id: "SPEC-FUNC-001"
      category: "Functional"
      derived_from: "REQ-FUNC-001"
      specification: |
        The system shall provide user registration via email and password.
        Inputs: email (string, RFC 5322), password (string, min 8 chars)
        Output: 201 Created with user_id, 400 for validation errors,
                409 for duplicate email
      priority: "must"
  
  # === Step 2 Output: Use Cases ===
  use_cases:
    - id: "UC-001"
      name: "Register new user"
      # ... full UC template above
  
  # === Step 3 Output: Gherkin Scenarios ===
  gherkin_files:
    - path: "features/user_signup.feature"
      feature: "User registration"
      scenarios: 8
      coverage: "positive: 3, negative: 3, boundary: 2"
  
  # === Step 4 Output: ATDD Tests ===
  atdd_tests:
    - path: "e2e/user_signup.spec.ts"
      framework: "playwright"
      executable: true
      tests: 8
  
  # === Step 5 Output: Coverage Validation ===
  coverage_validation:
    total_scenarios: 24
    positive_paths: {count: 8, coverage: "100%"}
    negative_paths: {count: 10, coverage: "100%"}
    boundary_conditions: {count: 6, coverage: "85%"}
    missing:
      - "FR-005: error path for timeout not covered"
    orphans: []
  
  # === Step 6 Output: NFR Analysis ===
  nfr_specifications:
    - id: "NFR-PERF-001"
      category: "Performance"
      iso_subcharacteristic: "Time behavior"
      target: "p95 latency < 200ms"
      measurement: "http_server_requests_seconds{quantile=0.95}"
      validation: "Load test with k6, 1000 concurrent users"
    - id: "NFR-SEC-001"
      category: "Security"
      iso_subcharacteristic: "Confidentiality"
      target: "All data in transit encrypted"
      measurement: "TLS 1.3 enforced"
      validation: "Security scan + manual cert verification"
  
  # === Step 7 Output: Versioned Specs ===
  versioned_specs:
    current_version: "v1.2.0"
    history:
      - version: "v1.0.0"
        date: "2026-01-15"
        changes: "Initial spec set"
      - version: "v1.1.0"
        date: "2026-03-20"
        changes: "Added NFR-SEC-002 (rate limiting)"
      - version: "v1.2.0"
        date: "2026-06-02"
        changes: "Added UC-008 (password reset), refactored UC-001"
  
  traceability:
    requirements_covered: "24/24 (100%)"
    frs_covered: "12/12 (100%)"
    bidirectional: true
```

## Implementation

### Step 1: Parse to Structured Specs

For each requirement, produce a structured spec following the 13-category templates:

```yaml
spec_template:
  id: "SPEC-{CATEGORY}-{N}"
  category: ""
  derived_from: ""  # REQ-{CATEGORY}-{N}
  specification: ""  # Detailed prose spec
  priority: ""  # must | should | could | won't
  acceptance_criteria: []
  traceability:
    requirements: []
    frs: []
    scenarios: []
```

### Step 2: Design Use Cases

For each functional requirement:
1. Identify primary and secondary actors
2. Define preconditions and postconditions
3. Map main flow step by step
4. Identify alternative flows (error cases, edge cases)
5. Link to requirements and scenarios

### Step 3: Write GWT Scenarios

For each use case:
1. Identify main flow scenarios (happy paths)
2. Identify alternative flow scenarios (error paths)
3. Identify boundary conditions (limits, edge cases)
4. Write in Given-When-Then format
5. Use Scenario Outlines for parameterized cases
6. Output as `.feature` files

### Step 4: Generate ATDD Tests

For each Gherkin scenario:
1. Map GWT steps to executable test code
2. Use page objects for UI interactions
3. Use API client for backend calls
4. Output executable tests in the chosen framework
5. Ensure tests are runnable in CI

### Step 5: Validate Completeness

Check coverage across three dimensions:
- **Positive paths**: All happy paths covered
- **Negative paths**: All error cases covered
- **Boundary conditions**: Edge cases, limits, empty/null inputs

Report missing scenarios as actionable items.

### Step 6: Analyze NFRs

For each NFR target:
1. Map to ISO/IEC 25010:2023 subcharacteristic
2. Define measurable target
3. Define measurement method
4. Define validation strategy (test type + tool)
5. Link to specific test generation (perf, security, etc.)

### Step 7: Manage Versions

Track spec evolution:
- Semantic versioning (major.minor.patch)
- Change log with rationale
- Impact analysis (which FRs, UCs, scenarios affected)
- Bidirectional links between versions

## Validation Rules

- ✅ Every spec traces to a requirement (L2→L1 link)
- ✅ Every use case has at least one GWT scenario
- ✅ Every functional requirement has positive, negative, and boundary scenarios
- ✅ ATDD tests are executable and pass in CI
- ✅ NFRs have measurable targets and validation methods
- ✅ Spec versions are tracked with change rationale

## Integration with Aether.go Methodology

- **Input from**: `requirement-analyzer` (functional requirements)
- **Output to**:
  - `test-planner` (L4 test strategy from scenarios)
  - `generation-dispatcher` (acceptance test generation)
- **Part of**: D3 Specification Derivation Domain
- **Principle alignment**:
  - **P1 Purpose-Driven**: Specs serve business goals
  - **P2 Planning-Driven**: Specs precede code
  - **P4 Interface-First**: Specs define contract boundaries

## Examples

### Example 1: New Feature Spec

```yaml
feature: "Password reset"
use_cases: 3
gherkin_scenarios: 9
atdd_tests: 9
nfrs_added: 2
spec_version: "v1.2.0"
```

### Example 2: NFR-Heavy Spec

```yaml
project: "High-frequency trading system"
nfrs:
  performance: {latency_p99: "5ms", throughput: "1M ops/sec"}
  reliability: {uptime: "99.999%", mttr: "5min"}
  security: {compliance: ["PCI-DSS", "SOC2"]}
test_requirements:
  load_test: "k6 with 10x peak load"
  chaos_test: "Network partition, disk failure"
  security_scan: "OWASP ZAP + manual pen test"
```

## Migration Notes

This skill consolidates the following previously separate skills:
- `spec-parser` — Step 1
- `usecase-designer` — Step 2
- `bdd-scenario-writer` — Step 3
- `atdd-acceptance-test-generator` — Step 4
- `spec-to-scenario` — Step 3 (overlaps with bdd-scenario-writer)
- `scenario-completeness-checker` — Step 5
- `nfr-analyzer` — Step 6
- `spec-version-manager` — Step 7
