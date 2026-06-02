---
name: reverse-engineering-suite
description: Use when extracting specifications, architecture, and behavior from existing legacy systems for L1 derivation in brownfield projects. Implements characterization tests, static + dynamic analysis, and progressive documentation.
---

# Reverse Engineering Suite

## Overview

The unified skill for extracting specifications from legacy systems. This skill:
- Performs static analysis (AST, dependency graphs, type extraction)
- Performs dynamic analysis (runtime behavior capture, log mining, traffic replay)
- Generates characterization tests that lock existing behavior
- Produces L1 specifications traceable to original code
- Supports the Harness Reverse Construction scenario

**Used in scenarios**: Reverse Engineering, Harness Reverse Construction

## When to Use

```
Modifying legacy system? ──────────────────────┐
                                              │
Need to understand existing behavior? ────────┤
                                              │
Need characterization tests? ─────────────────┼─► Use reverse-engineering-suite
                                              │
Migrating to new tech stack? ─────────────────┤
                                              │
Want to document undocumented code? ──────────┘
```

## Core Pattern

### Reverse Engineering Process

```
Legacy System
    │
    ├──► [1] Static Analysis
    │         ├── AST parsing (Go, TypeScript, Python, Java)
    │         ├── Dependency graph (callers, callees)
    │         ├── Type/schema extraction
    │         ├── API endpoint discovery
    │         ├── Data model extraction
    │         └── Business rule mining (constants, validation logic)
    │
    ├──► [2] Dynamic Analysis
    │         ├── Runtime behavior capture (profiling, tracing)
    │         ├── Traffic log analysis (access patterns, edge cases)
    │         ├── Error case enumeration (exception logs)
    │         ├── Performance baseline (p50/p95/p99 latency)
    │         └── User journey reconstruction
    │
    ├──► [3] Characterization Tests
    │         ├── Lock existing behavior
    │         ├── Edge case enumeration
    │         ├── Create regression suite
    │         ├── Enable safe modification
    │         └── Document implicit contracts
    │
    └──► [4] Specification Reconstruction
              ├── L1 Functional requirements from code
              ├── L2 Architecture from dependency graph
              ├── L3 NFRs from performance baseline
              ├── Cross-reference to test scenarios
              └── Generate L1 specs for downstream workflow
    │
    ▼
Reverse-Engineered Specification (L1 output)
```

## When to Use Each Phase

| Phase | When |
|-------|------|
| Static Analysis | Always start here; provides structural understanding |
| Dynamic Analysis | When behavior unclear from code; logs available |
| Characterization Tests | Before any modification; locks behavior |
| Spec Reconstruction | After understanding is sufficient |

## Input Format

```yaml
reverse_engineering_request:
  project: "Legacy PHP Monolith"
  
  source:
    code_path: "src/"
    language: "php"  # php | go | python | java | javascript | typescript
    size_loc: 50000
    has_tests: false
    has_documentation: false
    has_logs: true
    log_paths: ["var/log/", "storage/logs/"]
    has_traffic: true
    traffic_capture: "nginx_access.log"
  
  # Scope
  scope:
    target:
      type: "full_system"  # full_system | module | service
      modules: ["user-management", "orders", "checkout"]
    
  # Goals
  goals:
    - "Document existing behavior"
    - "Enable safe refactoring"
    - "Identify dead code"
    - "Extract business rules"
    - "Plan migration"
  
  # Tooling
  tools:
    static_analysis: ["php-parser", "ast-extractor"]
    dynamic_analysis: ["log-miner", "traffic-replay"]
    test_framework: "pest"  # For characterization tests
```

## Output Format

```yaml
reverse_engineering_result:
  project: "Legacy PHP Monolith"
  timestamp: "2026-06-02T10:00:00Z"
  
  # === Static Analysis ===
  static_analysis:
    modules: 12
    total_files: 245
    total_loc: 50234
    avg_cyclomatic_complexity: 14.2
    
    dependency_graph:
      nodes: 87  # Classes/modules
      edges: 312
      cycles: 3  # Cyclic dependencies (problematic)
    
    api_endpoints_discovered:
      - {method: POST, path: "/api/users", handler: "UserController::create"}
      - {method: GET, path: "/api/users/:id", handler: "UserController::show"}
      - {method: POST, path: "/api/orders", handler: "OrderController::create"}
      # ... 24 more
    
    data_models:
      - {entity: "User", fields: 12, file: "app/Models/User.php"}
      - {entity: "Order", fields: 18, file: "app/Models/Order.php"}
    
    business_rules_mined:
      - "Order cannot be cancelled after 24 hours"
      - "User must verify email before placing order"
      - "Discount applies only to orders > $50"
    
    dead_code_identified:
      files: 5
      unused_functions: 23
      commented_code_blocks: 47
  
  # === Dynamic Analysis ===
  dynamic_analysis:
    runtime_traces: 150  # Sample executions captured
    user_journeys_reconstructed: 8
    
    common_flows:
      - journey: "User signup"
        steps: 5
        frequency: 1200/day
        success_rate: 0.85
      - journey: "Place order"
        steps: 8
        frequency: 800/day
        success_rate: 0.92
    
    edge_cases_observed:
      - "Concurrent order placement causes race condition"
      - "Large cart (>100 items) times out"
    
    performance_baseline:
      p50_latency_ms: 250
      p95_latency_ms: 850
      p99_latency_ms: 2500
      throughput_rps: 200
      error_rate: 0.02  # 2% error rate observed
  
  # === Characterization Tests ===
  characterization_tests:
    framework: "pest"
    tests_generated: 156
    coverage:
      statements: 0.68
      branches: 0.55
      paths: 0.42
    
    by_module:
      - {module: "user-management", tests: 45, coverage: 0.75}
      - {module: "orders", tests: 62, coverage: 0.70}
      - {module: "checkout", tests: 49, coverage: 0.60}
    
    key_behaviors_locked:
      - "User creation with duplicate email returns error code E_DUP_EMAIL"
      - "Order total calculation includes tax and shipping"
      - "Empty cart checkout returns validation error"
  
  # === Specification Reconstruction ===
  specification:
    functional_requirements:
      - id: "FR-001"
        statement: "User registration via email and password"
        source: "UserController::create, lines 12-48"
        original_behavior: "..."
        traceability: {code: "UserController.php:12-48"}
      # ... 23 more FRs
    
    non_functional_requirements:
      - id: "NFR-PERF-001"
        statement: "p95 latency < 850ms (current baseline)"
        source: "Performance baseline measurement"
      - id: "NFR-REL-001"
        statement: "Current error rate: 2% (target for new system: <0.1%)"
        source: "Runtime trace analysis"
    
    business_rules:
      - "Order cancellation window: 24 hours"
      - "Discount eligibility: orders > $50"
    
    api_contract_summary:
      total_endpoints: 28
      request_schemas_extracted: 28
      response_schemas_extracted: 28
      implicit_dependencies: 12  # E.g., auth required but not declared
    
    next_steps:
      - "Use extracted FRs in standard workflow (requirement-analyzer)"
      - "Use characterization tests in test-planner (L4 contracts)"
      - "Plan migration with strangler-pattern (architecture-planner)"
  
  # === Migration Plan (Optional) ===
  migration_plan:
    strategy: "strangler"  # strangler | big-bang | parallel
    suggested_phases:
      - phase: 1
        scope: "user-management"
        duration: "4 weeks"
        risk: "low"
      - phase: 2
        scope: "orders"
        duration: "6 weeks"
        risk: "medium"
      - phase: 3
        scope: "checkout"
        duration: "8 weeks"
        risk: "high"
```

## Implementation Tools

### Static Analysis by Language

| Language | Tools | What to Extract |
|----------|-------|-----------------|
| **PHP** | php-parser, nikic/php-parser | Classes, methods, dependencies |
| **Go** | go/ast, go-callvis | Packages, functions, call graph |
| **Python** | ast, pylint, vulture | Modules, classes, unused code |
| **Java** | javap, JDepend | JARs, packages, dependencies |
| **TypeScript** | tsc, ts-morph | Types, interfaces, imports |

### Dynamic Analysis Techniques

| Technique | Captures | Tool |
|-----------|----------|------|
| **Profiling** | Function call frequency, duration | pprof (Go), xhprof (PHP) |
| **Tracing** | Distributed request flow | Jaeger, Zipkin |
| **Log mining** | Error patterns, access patterns | ELK, Splunk |
| **Traffic replay** | Production traffic replayed in test | GoReplay, tcpreplay |

### Characterization Test Patterns

```php
// Example characterization test (Pest PHP)
// Lock existing behavior; tests the current output, not desired output
test('user registration with valid email returns user_id', function () {
    $response = $this->postJson('/api/users', [
        'email' => 'newuser@example.com',
        'password' => 'SecurePass123!',
    ]);
    
    // Lock the current behavior (may be imperfect)
    $response->assertStatus(201);
    $response->assertJsonStructure(['user_id']);
    expect($response->json('user_id'))->toBeString();
});

test('user registration with duplicate email returns specific error', function () {
    $this->postJson('/api/users', [
        'email' => 'existing@example.com',
        'password' => 'Pass123!',
    ]);
    
    $response = $this->postJson('/api/users', [
        'email' => 'existing@example.com',
        'password' => 'Pass456!',
    ]);
    
    // Lock current behavior, even if not ideal
    $response->assertStatus(409);
    $response->assertJson(['error' => 'E_DUP_EMAIL']);
});
```

## Integration with Aether.go Methodology

- **Input from**: Legacy code, logs, traffic
- **Output to**:
  - `requirement-analyzer` (extracted FRs)
  - `test-planner` (characterization tests as L4 contracts)
  - `architecture-planner` (extracted architecture)
- **Part of**: D6 Scenario Adaptation Domain (specialized workflow)
- **Principle alignment**:
  - **P0 Context-Adaptation**: Exempts P2 for legacy parts
  - **P6 Occam's Razor**: Relaxed for legacy dependencies
  - **P9 Test-First**: Characterization tests before changes

## Migration Notes

- This skill is standalone and does not merge with another
- Used as Stage 0 in the workflow when project is brownfield
- Can also be invoked for periodic documentation of legacy systems
