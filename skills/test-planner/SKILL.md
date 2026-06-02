---
name: test-planner
description: Use when deriving test stratification plans from GWT scenarios, generating tests at all pyramid layers (unit/integration/contract/E2E/system/SIT), validating test proportions, and designing chaos experiments. This skill unifies D4 Contract Derivation Domain and replaces test-pyramid-deriver, test-pyramid-validator, e2e-test-generator, integration-test-generator, contract-test-generator, system-test-generator, unit-test-generator, sit-scenario-generator, chaos-test-designer, and non-functional-gate-checker.
---

# Test Planner

## Overview

The unified skill for all L3→L4 contract derivation and L4→L5 test code generation. This skill:
- Derives test stratification plans from GWT acceptance scenarios (test pyramid)
- Validates test proportions against the pyramid model
- Generates tests at all 5 layers: unit, contract, integration, E2E, system
- Generates SIT (System Integration Test) scenarios across services
- Designs chaos engineering experiments
- Verifies non-functional requirements (NFRs) as automated gates

**Replaces** (consolidated from 10 skills):
- `test-pyramid-deriver`
- `test-pyramid-validator`
- `unit-test-generator`
- `integration-test-generator`
- `contract-test-generator`
- `e2e-test-generator`
- `system-test-generator`
- `sit-scenario-generator`
- `chaos-test-designer`
- `non-functional-gate-checker`

## When to Use

```
Need test strategy from scenarios? ───────────┐
                                              │
Generating tests at any layer? ───────────────┤
                                              │
Validating test pyramid proportions? ─────────┼─► Use test-planner
                                              │
Designing chaos experiments? ─────────────────┤
                                              │
Verifying NFRs (perf, security, etc.)? ───────┘
```

Use when:
- Deriving test plans from acceptance scenarios
- Generating test code at any pyramid layer
- Validating test pyramid proportions (70/15/10/4/1)
- Designing chaos engineering experiments
- Setting up NFR verification gates
- Multi-service integration test scenarios

Don't use when:
- Pure business analysis (use `requirement-analyzer`)
- Specification writing (use `spec-engineer`)
- TDD cycle execution (use `tdd-cycle-runner`)
- Architecture-level test decisions (use `architecture-planner`)

## Core Pattern

### Test Pyramid (5 Layers)

```
       ╔══════════════════════════════╗  ← System tests (~1%)
       ║   Performance, Security,     ║   NFR validation
       ║   Reliability, Chaos         ║
       ╚══════════════════════════════╝
       ╔══════════════════════════════╗  ← E2E tests (~4%)
       ║   User journeys, UI flows    ║   Critical paths only
       ╚══════════════════════════════╝
       ╔══════════════════════════════╗  ← Integration tests (~15%)
       ║   Component collaboration    ║   Service boundaries
       ║   Internal APIs              ║
       ╚══════════════════════════════╝
       ╔══════════════════════════════╗  ← Contract tests (~10%)
       ║   API contracts (Pact, etc.) ║   CDC, schema validation
       ╚══════════════════════════════╝
       ╔══════════════════════════════╗  ← Unit tests (~70%)
       ║   Function/method logic      ║   Boundary values, equiv classes
       ║   Algorithms, state machines ║
       ╚══════════════════════════════╝
```

### L3→L4→L5 Test Pipeline

```
Acceptance Scenarios (L3 input from spec-engineer)
    │
    ├──► [1] Identify System Boundaries
    │         │
    │         ▼
    │     Boundary Map
    │         │
    │         ├──► [2] Derive Test Pyramid Plan
    │         │         │
    │         │         ▼
    │         │     Stratification Plan (70/15/10/4/1)
    │         │         │
    │         │         ├──► [3] Generate Unit Tests (70%)
    │         │         │         │
    │         │         │         ▼
    │         │         │     tests/unit/*.test.go
    │         │         │
    │         │         ├──► [4] Generate Contract Tests (10%)
    │         │         │         │
    │         │         │         ▼
    │         │         │     tests/contract/*.pact.json
    │         │         │
    │         │         ├──► [5] Generate Integration Tests (15%)
    │         │         │         │
    │         │         │         ▼
    │         │         │     tests/integration/*.test.go
    │         │         │
    │         │         ├──► [6] Generate E2E Tests (4%)
    │         │         │         │
    │         │         │         ▼
    │         │         │     e2e/*.spec.ts (Playwright)
    │         │         │
    │         │         └──► [7] Generate System Tests (1%)
    │         │                   │
    │         │                   ▼
    │         │               tests/system/* (k6, security scans)
    │         │
    │         ├──► [8] Generate SIT Scenarios (multi-service)
    │         │         │
    │         │         ▼
    │         │     tests/sit/*.test.go
    │         │
    │         ├──► [9] Design Chaos Experiments
    │         │         │
    │         │         ▼
    │         │     chaos/experiments/*.yaml
    │         │
    │         └──► [10] Validate Pyramid Proportions + NFR Gates
    │                   │
    │                   ▼
    │               Validation Report
    │
    ▼
Test Suite (L4→L5 output) ready for execution
```

### Boundary Identification Rules (L3→L4)

For each acceptance scenario, identify system boundaries:

| Boundary Type | Test Type | Validation Focus | Example |
|---------------|-----------|------------------|---------|
| User ↔ System | E2E test | Complete user journey | Signup → Verify → First action |
| System ↔ External service | Contract test | API compatibility | Order → Payment provider |
| System ↔ Internal component | Integration test | Component collaboration | Order service → Inventory service |
| Component internal logic | Unit test | Business rules | Tax calculation, validation |

## Input Format

```yaml
test_planning_request:
  project: "Aether Platform"
  source: "spec-engineer"
  
  # Required: acceptance scenarios
  acceptance_scenarios:
    - id: "scenario_signup_success"
      gwt: |
        Given a new user with valid email
        When they submit the signup form
        Then the system creates an account
        And sends a verification email
    # ... more scenarios
  
  # System boundaries (from architecture-planner)
  boundaries:
    - {type: "user-system", description: "Web client ↔ API gateway"}
    - {type: "system-external", description: "API ↔ Email service (SendGrid)"}
    - {type: "system-internal", description: "Auth service ↔ User service"}
  
  # Tech stack
  tech_stack:
    backend: "go"
    frontend: "vue3"
    test_frameworks:
      unit: "go test"
      integration: "go test + testcontainers"
      contract: "pact-go"
      e2e: "playwright"
      system: "k6"
  
  # Pyramid targets (override defaults if needed)
  pyramid:
    unit: 0.70
    contract: 0.10
    integration: 0.15
    e2e: 0.04
    system: 0.01
  
  # NFRs from spec-engineer
  nfrs:
    - {id: "NFR-PERF-001", target: "p95 < 200ms", validation: "k6 load test"}
    - {id: "NFR-SEC-001", target: "no high vulnerabilities", validation: "OWASP ZAP"}
  
  # Configuration
  include_chaos: true
  include_sit: true
  validate_proportions: true
```

## Output Format

```yaml
test_planning_result:
  project: "Aether Platform"
  timestamp: "2026-06-02T10:00:00Z"
  
  # === Step 1: Boundary Map ===
  boundary_map:
    - {boundary: "user-system", tests_generated: ["e2e_signup", "e2e_login"]}
    - {boundary: "system-external-email", tests_generated: ["contract_email_send"]}
    - {boundary: "system-internal-auth-user", tests_generated: ["integration_auth_user"]}
  
  # === Step 2: Test Pyramid Plan ===
  pyramid_plan:
    total_scenarios: 24
    by_layer:
      unit: {target: 168, actual: 165, percentage: 0.69}
      contract: {target: 24, actual: 26, percentage: 0.11}
      integration: {target: 36, actual: 35, percentage: 0.15}
      e2e: {target: 10, actual: 9, percentage: 0.04}
      system: {target: 2, actual: 2, percentage: 0.01}
  
  # === Step 3: Unit Tests ===
  unit_tests:
    - path: "internal/users/service_test.go"
      framework: "go test"
      test_count: 45
      coverage_target: 0.85
      techniques: ["boundary_value_analysis", "equivalence_partitioning"]
    # ... 6 more unit test files
  
  # === Step 4: Contract Tests ===
  contract_tests:
    - path: "tests/contract/email_service_pact_test.go"
      framework: "pact-go"
      consumer: "auth-service"
      provider: "email-service"
      interactions: 3
    - path: "tests/contract/payment_api_pact_test.go"
      framework: "pact-go"
      consumer: "order-service"
      provider: "payment-provider"
      interactions: 5
  
  # === Step 5: Integration Tests ===
  integration_tests:
    - path: "tests/integration/auth_user_integration_test.go"
      framework: "go test + testcontainers"
      components: ["auth-service", "user-service", "postgres"]
      setup: "Docker Compose with PostgreSQL, Redis"
    # ... more integration tests
  
  # === Step 6: E2E Tests ===
  e2e_tests:
    - path: "e2e/user_signup.spec.ts"
      framework: "playwright"
      user_journey: "New user signup to first action"
      test_count: 5
      browsers: ["chromium", "firefox", "webkit"]
  
  # === Step 7: System Tests ===
  system_tests:
    - type: "performance"
      tool: "k6"
      path: "tests/load/signup_load.js"
      target: "p95 < 200ms at 1000 RPS"
    - type: "security"
      tool: "OWASP ZAP"
      path: "tests/security/zap_baseline.yaml"
      target: "no high vulnerabilities"
    - type: "chaos"
      tool: "Chaos Mesh"
      path: "chaos/experiments/db_failure.yaml"
      target: "service recovers within 30s"
  
  # === Step 8: SIT Scenarios ===
  sit_scenarios:
    - name: "End-to-end order flow"
      services_involved: ["web", "order-svc", "payment-svc", "inventory-svc", "email-svc"]
      scenario: "Place order → Verify payment → Check inventory → Confirm email"
  
  # === Step 9: Chaos Experiments ===
  chaos_experiments:
    - name: "Database connection loss"
      target: "auth-service"
      injection: "Kill PostgreSQL connection for 30s"
      expected_outcome: "Service returns 503, retries on recovery"
      rollback: "Auto-reconnect on database recovery"
    - name: "Network partition between services"
      target: "auth-service ↔ user-service"
      injection: "Block network traffic for 60s"
      expected_outcome: "Graceful degradation with circuit breaker"
  
  # === Step 10: Validation Report ===
  validation_report:
    pyramid_compliance: "PASS"
    proportions:
      unit: 0.69  # target 0.70, within tolerance
      contract: 0.11  # target 0.10, within tolerance
      integration: 0.15  # target 0.15, exact
      e2e: 0.04  # target 0.04, exact
      system: 0.01  # target 0.01, exact
    nfr_gates:
      performance: {status: "configured", tool: "k6"}
      security: {status: "configured", tool: "OWASP ZAP"}
      reliability: {status: "configured", tool: "Chaos Mesh"}
    coverage:
      frs_covered: "12/12 (100%)"
      scenarios_covered: "24/24 (100%)"
      orphan_tests: 0
    warnings:
      - "Unit test coverage slightly below target (0.69 vs 0.70)"
    failures: []
```

## Implementation

### Step 1: Identify System Boundaries

For each acceptance scenario, analyze:
- Which actors are involved?
- Which components are touched?
- Where do data flows cross system boundaries?
- What external dependencies are involved?

Map each scenario to one or more boundary types.

### Step 2: Derive Test Pyramid Plan

Calculate test allocation:

```python
def derive_pyramid(total_scenarios: int, pyramid: dict) -> dict:
    return {
        layer: int(total_scenarios * percentage)
        for layer, percentage in pyramid.items()
    }
```

Default targets: 70/10/15/4/1 (unit/contract/integration/e2e/system)

### Step 3: Generate Unit Tests (70%)

For each function/method:
- Apply **boundary value analysis** (min, min-1, max, max+1)
- Apply **equivalence partitioning** (valid/invalid classes)
- Cover happy path + key error paths
- Use mock interfaces for dependencies
- Output to `tests/unit/` or co-located `*_test.go`

```go
// Generated unit test example
func TestPasswordValidator_Valid(t *testing.T) {
    tests := []struct{
        name string
        input string
        want bool
    }{
        {"min_valid", "Pass123!", true},
        {"max_valid", strings.Repeat("a", 72), true},  // bcrypt max
        {"too_short", "Pass1!", false},
        {"no_upper", "password1!", false},
        {"no_digit", "Password!", false},
        {"no_special", "Password1", false},
    }
    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got := ValidatePassword(tt.input)
            if got != tt.want {
                t.Errorf("got %v, want %v", got, tt.want)
            }
        })
    }
}
```

### Step 4: Generate Contract Tests (10%)

For each API boundary:
- Use **consumer-driven contracts** (Pact, etc.)
- Consumer defines expected interactions
- Provider verifies it can satisfy them
- Use JSON Schema for request/response validation

```yaml
# Generated contract test example
pact:
  consumer: "auth-service"
  provider: "email-service"
  interactions:
    - description: "send verification email"
      request:
        method: POST
        path: /v1/emails
        body: {to: "user@example.com", template: "verify", data: {token: "abc123"}}
      response:
        status: 202
        body: {message_id: "msg-123"}
```

### Step 5: Generate Integration Tests (15%)

For each component collaboration:
- Use **testcontainers** for real databases, message brokers
- Test actual data flow between components
- Use shared test database (migrations + seed)
- Verify state changes at each step

```go
// Generated integration test example
func TestAuthFlow_RegisterAndLogin(t *testing.T) {
    ctx := context.Background()
    db := testcontainers.NewPostgres(ctx, t)
    defer db.Terminate(ctx)
    
    authSvc := auth.NewService(db)
    userSvc := user.NewService(db)
    
    // Test full flow
    err := authSvc.Register(ctx, "user@example.com", "Pass123!")
    require.NoError(t, err)
    
    token, err := authSvc.Login(ctx, "user@example.com", "Pass123!")
    require.NoError(t, err)
    assert.NotEmpty(t, token)
    
    // Verify state
    user, err := userSvc.GetByEmail(ctx, "user@example.com")
    require.NoError(t, err)
    assert.Equal(t, "user@example.com", user.Email)
}
```

### Step 6: Generate E2E Tests (4%)

For each critical user journey:
- Cover happy path + 1-2 key error paths
- Use **page objects** for maintainability
- Run across multiple browsers
- Capture screenshots for visual regression

```typescript
// Generated E2E test example
test('user can sign up and verify email', async ({ page }) => {
  await page.goto('/signup');
  await page.fill('[data-testid=email]', 'user@example.com');
  await page.fill('[data-testid=password]', 'Pass123!');
  await page.click('[data-testid=submit]');
  
  await expect(page.locator('[data-testid=success]')).toBeVisible();
});
```

### Step 7: Generate System Tests (1%)

For each NFR:
- **Performance**: k6 load test scripts
- **Security**: OWASP ZAP baseline scan
- **Reliability**: Chaos engineering experiments
- **Scalability**: Soak tests, stress tests

```javascript
// Generated k6 load test
import http from 'k6/http';
import { check } from 'k6';

export const options = {
  stages: [
    { duration: '30s', target: 100 },
    { duration: '1m', target: 1000 },
    { duration: '30s', target: 0 },
  ],
  thresholds: {
    'http_req_duration{quantile=0.95}': ['p(95)<200'],
  },
};

export default function() {
  const res = http.post('https://api.example.com/v1/auth/signup', 
    JSON.stringify({ email: 'user@example.com', password: 'Pass123!' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
  check(res, { 'status is 201': (r) => r.status === 201 });
}
```

### Step 8: Generate SIT Scenarios (Multi-service)

For cross-service integration:
- Identify user journeys spanning multiple services
- Generate tests that exercise the full path
- Use service virtualization for unavailable services

### Step 9: Design Chaos Experiments

For each potential failure mode:
- Define steady state (success metric)
- Inject failure (kill pod, network partition, latency)
- Define expected behavior (graceful degradation, recovery)
- Define rollback strategy

```yaml
# Generated chaos experiment
apiVersion: chaos-mesh.org/v1alpha1
kind: PodChaos
metadata:
  name: db-connection-loss
spec:
  action: pod-kill
  mode: one
  selector:
    namespaces: ["aether"]
    labelSelectors:
      app: postgres
  duration: "30s"
  scheduler:
    cron: "@every 5m"
```

### Step 10: Validate Pyramid + NFR Gates

Check:
- Test proportions within tolerance (typically ±5%)
- No orphan tests (all tests linked to FR)
- NFRs have automated verification configured
- No anti-patterns (e.g., E2E tests for unit-level logic)

## Validation Rules

- ✅ Pyramid proportions within tolerance (±5% of target)
- ✅ All tests trace to functional requirements
- ✅ No orphan tests (untraced)
- ✅ NFRs have automated verification configured
- ✅ Unit tests cover boundary values and equivalence classes
- ✅ Contract tests use CDC pattern
- ✅ E2E tests focus on critical user journeys only
- ✅ Chaos experiments have explicit expected behavior

## Integration with Aether.go Methodology

- **Input from**:
  - `spec-engineer` (acceptance scenarios, NFRs)
  - `architecture-planner` (boundaries, contracts)
- **Output to**:
  - `tdd-cycle-runner` (execute tests)
  - `code-generator` (implements to make tests pass)
  - `deployment-orchestrator` (runs tests in CI)
- **Part of**: D4 Contract Derivation Domain
- **Principle alignment**:
  - **P6 Test-First**: Tests generated before code
  - **P4 Interface-First**: Contract tests verify boundaries
  - **P11 NFR-Built-in**: System tests verify NFRs

## Examples

### Example 1: Standard E-commerce App

```yaml
total_scenarios: 24
pyramid: 165 unit, 26 contract, 35 integration, 9 e2e, 2 system
total_tests: 237
nfrs_with_automated_gates: 5
chaos_experiments: 3
sit_scenarios: 2
validation: PASS
```

### Example 2: Microservices Platform

```yaml
total_services: 8
contract_pairs: 14
integration_test_pairs: 12
sit_scenarios: 4
chaos_experiments: 6
performance_tests: 3
validation: PASS with warnings (e2e slightly under target)
```

## Migration Notes

This skill consolidates the following previously separate skills:
- `test-pyramid-deriver` — Step 2
- `test-pyramid-validator` — Step 10
- `unit-test-generator` — Step 3
- `contract-test-generator` — Step 4
- `integration-test-generator` — Step 5
- `e2e-test-generator` — Step 6
- `system-test-generator` — Step 7
- `sit-scenario-generator` — Step 8
- `chaos-test-designer` — Step 9
- `non-functional-gate-checker` — Step 10 (NFR gates)

**Test Layer Parameterization**:
When invoking this skill, use the `test_layer` parameter to focus on a specific layer:
- `test_layer: unit` → Step 3
- `test_layer: contract` → Step 4
- `test_layer: integration` → Step 5
- `test_layer: e2e` → Step 6
- `test_layer: system` → Step 7
- `test_layer: sit` → Step 8
- `test_layer: chaos` → Step 9
- `test_layer: validate` → Step 10
- `test_layer: all` (default) → Full pipeline
