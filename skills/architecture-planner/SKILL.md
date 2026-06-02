---
name: architecture-planner
description: Use when designing system architecture, recording decisions, selecting patterns and tech stack, analyzing data flow, designing interface contracts, and applying the Strangler pattern. This skill unifies D2 Architecture Derivation Domain and replaces architecture-decision-recorder, architecture-pattern-selector, tech-stack-selector, data-flow-analyzer, interface-contract-designer, and strangler-pattern-suite.
---

# Architecture Planner

## Overview

The unified skill for all L2 architecture derivation work. This skill:
- Records architecture decisions with business justification (ADRs)
- Selects appropriate architecture patterns based on requirements
- Selects technology stack (languages, frameworks, databases, infrastructure)
- Analyzes data flow and identifies bottlenecks
- Designs interface contracts (P4 Interface-First Principle)
- Provides Strangler pattern for incremental architecture migration

**Replaces** (consolidated from 6 skills):
- `architecture-decision-recorder`
- `architecture-pattern-selector`
- `tech-stack-selector`
- `data-flow-analyzer`
- `interface-contract-designer` *(also see Notes below)*
- `strangler-pattern-suite`

> **Note**: While `interface-contract-designer` is listed as a separate skill (25-skill target), its core capabilities are also exposed here. Callers should use `interface-contract-designer` for deep contract work, but `architecture-planner` covers the essentials.

## When to Use

```
Starting architecture design? ───────────────┐
                                            │
Recording an ADR? ───────────────────────────┤
                                            │
Choosing a tech stack? ─────────────────────┼─► Use architecture-planner
                                            │
Designing API contracts? ───────────────────┤
                                            │
Migrating legacy via Strangler? ────────────┘
```

Use when:
- Beginning architecture design for a new system
- Recording significant architecture decisions
- Selecting tech stack for application, data, infrastructure layers
- Analyzing data flow and identifying bottlenecks
- Defining interface contracts (input/output/pre/post conditions)
- Incrementally replacing legacy components (Strangler pattern)

Don't use when:
- Only writing use cases or GWT scenarios (use `spec-engineer`)
- Pure code generation (use `code-generator`)
- Deployment concerns (use `deployment-orchestrator`)

## Core Pattern

### L2 Architecture Derivation Pipeline

```
Functional Requirements (L2 input)
    │
    ├──► [1] Pattern Selection
    │         │
    │         ▼
    │     Architecture Pattern Candidates
    │         │
    │         ├──► [2] Tech Stack Selection
    │         │         │
    │         │         ▼
    │         │     Tech Stack Decisions
    │         │         │
    │         │         ├──► [3] Data Flow Analysis
    │         │         │         │
    │         │         │         ▼
    │         │         │     Data Flow Diagrams
    │         │         │
    │         │         ├──► [4] Interface Contract Design (P4)
    │         │         │         │
    │         │         │         ▼
    │         │         │     Interface Contracts
    │         │         │
    │         │         └──► [5] ADR Recording
    │         │                   │
    │         │                   ▼
    │         │               ADRs in registry
    │         │
    │         └──► [6] Strangler Migration Plan (if needed)
    │
    ▼
Architecture Specification (L2 output)
```

### Architecture Decision Record (ADR) Template

```yaml
adr:
  id: "ADR-003"
  title: "Use event-driven architecture for order processing"
  status: "accepted"  # proposed | accepted | deprecated | superseded
  date: "2026-06-02"
  deciders: ["tech-lead", "architect"]
  
  context:
    business_driver: "BG-001"  # Links to business goal
    problem: "Synchronous order processing creates latency spikes"
    constraints:
      - "Must maintain eventual consistency"
      - "Cannot exceed 200ms p95 latency"
  
  decision: "Adopt event-driven architecture using Kafka for order events"
  
  consequences:
    positive:
      - "Decoupled producers and consumers"
      - "Improved throughput and resilience"
    negative:
      - "Eventual consistency requires careful UX design"
      - "Increased operational complexity"
  
  alternatives_considered:
    - option: "Synchronous REST with caching"
      rejected_because: "Doesn't solve latency spike problem"
    - option: "Direct message queue (RabbitMQ)"
      rejected_because: "Less mature ecosystem for our scale"
  
  traceability:
    functional_requirements: ["FR-005", "FR-006"]
    principles_satisfied: ["P3 Modularity", "P4 Interface-First"]
```

### Architecture Pattern Selection Matrix

| Pattern | Best For | Avoid When | Key Characteristics |
|---------|----------|------------|---------------------|
| **Layered** | CRUD apps, simple domains | Complex domains, frequent changes | Clear layers, top-down |
| **Microservices** | Large teams, independent deployment | Small teams, low complexity | Decentralized, autonomous |
| **Event-Driven** | Async processing, high throughput | Simple request-response | Loose coupling, eventual consistency |
| **Hexagonal (Ports & Adapters)** | Long-lived business logic | Simple CRUD apps | Domain-centric, testable |
| **CQRS** | Read-heavy, complex domains | Simple CRUD, low scale | Separate read/write models |
| **Serverless** | Sporadic workloads, cost optimization | Long-running, high throughput | Pay-per-use, managed scaling |
| **Strangler** | Migrating legacy systems | Greenfield, no legacy | Incremental replacement |

### Tech Stack Selection Dimensions

The skill considers these dimensions when selecting tech stack:

| Dimension | Constraints |
|-----------|-------------|
| **Application type** | Web app, API, CLI, mobile, embedded |
| **Language** | Team expertise, ecosystem, performance |
| **Framework** | Conventions, learning curve, productivity |
| **Database** | Data shape, consistency, scale |
| **Caching** | Read pattern, invalidation strategy |
| **Messaging** | Async requirements, ordering, delivery guarantees |
| **Infrastructure** | Cloud, on-prem, edge |
| **P5 Constraint** | Core dependencies ≤ 5 (Occam's Razor) |

## Input Format

```yaml
architecture_request:
  project: "Aether Platform"
  functional_requirements:
    - "FR-001: User signup"
    - "FR-005: Order processing"
  
  constraints:
    team_size: 5
    expertise: ["go", "typescript", "postgres"]
    performance:
      p95_latency: 200ms
      throughput: 1000 rps
    compliance: ["GDPR", "SOC2"]
    budget: "low"
  
  existing_systems:
    - name: "Legacy PHP monolith"
      migration_strategy: "strangler"
  
  principles:
    p4_interface_first: "strict"
    p5_occams_razor: "warning"
```

## Output Format

```yaml
architecture_plan:
  project: "Aether Platform"
  timestamp: "2026-06-02T10:00:00Z"
  
  # === Pattern Selection ===
  selected_patterns:
    - pattern: "Hexagonal"
      scope: "Core domain"
      rationale: "Long-lived business logic with evolving requirements"
    - pattern: "Event-Driven"
      scope: "Order processing"
      rationale: "High throughput, async requirements"
  
  # === Tech Stack ===
  tech_stack:
    application:
      language: "go"
      framework: "gin"
      rationale: "Team expertise, performance, type safety"
    data:
      primary: "PostgreSQL"
      cache: "Redis"
      rationale: "ACID for orders, fast reads for catalog"
    messaging:
      broker: "Kafka"
      rationale: "High throughput, event sourcing"
    infrastructure:
      cloud: "AWS"
      container: "Docker + Kubernetes"
      ci_cd: "GitHub Actions"
    dependencies:
      core: ["gin", "gorm", "redis", "kafka-go", "zap"]  # ≤ 5 (P5)
  
  # === Data Flow Analysis ===
  data_flow:
    flows:
      - name: "User signup"
        from: "API gateway"
        to: "User service"
        transformations: ["validation", "password hash"]
        bottlenecks: ["email delivery (async)"]
      - name: "Order placement"
        from: "Web client"
        to: "Order service"
        via: "API gateway → Saga"
        async_steps: ["inventory check", "payment", "fulfillment"]
  
  # === Interface Contracts ===
  interface_contracts:
    - name: "POST /api/v1/users"
      inputs:
        - {name: "email", type: "string", format: "email", required: true}
        - {name: "password", type: "string", min_length: 8, required: true}
      outputs:
        success: {status: 201, body: {user_id: "uuid"}}
        errors:
          - {status: 400, code: "validation_failed"}
          - {status: 409, code: "email_exists"}
      preconditions:
        - "Email not already registered"
      postconditions:
        - "User record created"
        - "Verification email queued"
      exceptions:
        - "EmailService unavailable: queue for retry"
  
  # === ADRs ===
  adrs:
    - id: "ADR-001"
      title: "Adopt Go + Gin for backend"
      status: "accepted"
      # ... full ADR as above
  
  # === Strangler Migration Plan (if applicable) ===
  strangler_plan:
    if_applicable: true
    phases:
      - phase: 1
        scope: "Extract user service from monolith"
        boundary: "/users/* endpoints"
        duration: "4 weeks"
        success_criteria: "All user traffic through new service"
      - phase: 2
        scope: "Extract order service"
        ...
    anti_corruption_layer: "API gateway translates old/new protocols"
  
  traceability:
    frs_covered: ["FR-001", "FR-002", "FR-005"]
    principles_satisfied: ["P3", "P4", "P5"]
```

## Implementation

### Step 1: Pattern Selection

For each functional requirement cluster:
1. Identify the dominant pattern characteristic (CRUD, async, complex domain, etc.)
2. Map to candidate patterns using the selection matrix
3. Score by: team expertise, complexity fit, future evolution
4. Document alternatives considered

### Step 2: Tech Stack Selection

Apply constraints iteratively:
1. Start with application type → language candidates
2. Filter by team expertise + ecosystem maturity
3. Apply P5 (≤5 core dependencies)
4. Validate with NFR metrics from `requirement-analyzer`
5. Document each choice with rationale in ADR

### Step 3: Data Flow Analysis

For each user journey:
1. Trace the path from user action to data persistence
2. Identify synchronous vs. asynchronous steps
3. Map data transformations at each boundary
4. Highlight bottlenecks (latency, throughput, cost)
5. Output as data flow diagram + structured YAML

### Step 4: Interface Contract Design (P4)

For each component boundary:
1. Define inputs: types, formats, constraints, boundary values
2. Define outputs: types, success/failure semantics
3. Define preconditions: state required before call
4. Define postconditions: state guaranteed after call
5. Define exceptions: error codes, recovery strategies

```yaml
contract_template:
  name: ""
  purpose: ""
  inputs:
    - {name: "", type: "", constraints: [], required: true}
  outputs:
    success: {type: "", fields: []}
    errors: [{code: "", status: 0, message: ""}]
  preconditions: []
  postconditions: []
  exceptions: []
  performance_budget: {p50: "", p95: "", p99: ""}
```

### Step 5: ADR Recording

For each significant decision:
1. Use the ADR template above
2. Trace to business goal (P1) and functional requirements
3. Document alternatives considered
4. Record consequences (positive and negative)
5. Store in `docs/adr/`

### Step 6: Strangler Pattern (if migrating legacy)

For legacy modernization:
1. Identify boundary contexts (bounded contexts in DDD)
2. Extract one context at a time
3. Build anti-corruption layer (API gateway translates protocols)
4. Route traffic incrementally (shadow → 1% → 10% → 50% → 100%)
5. Verify behavior equivalence at each step
6. Decommission old system after full migration

## Validation Rules

- ✅ Every architecture decision traces to a functional requirement (P1)
- ✅ Every component has a defined interface contract (P4)
- ✅ Core dependencies ≤ 5 (P5 Occam's Razor)
- ✅ Data flow covers all user journeys
- ✅ ADRs include alternatives considered
- ✅ Strangler migration has explicit success criteria per phase

## Integration with Aether.go Methodology

- **Input from**: `requirement-analyzer` (L1→L2 output)
- **Output to**:
  - `spec-engineer` (L3 specifications)
  - `test-planner` (L4 test strategy)
  - `code-generator` (L5 implementation)
- **Part of**: D2 Architecture Derivation Domain
- **Principle alignment**:
  - **P1 Purpose-Driven**: ADRs trace to business goals
  - **P3 Modularity-Orthogonality**: Pattern selection
  - **P4 Interface-First**: Contract design
  - **P5 Occam's Razor**: Tech stack constraint
  - **P7 Constraint-Mechanization**: ADRs executable

## Examples

### Example 1: E-commerce Greenfield

```yaml
patterns: [Hexagonal, Event-Driven]
tech_stack: [Go+Gin, PostgreSQL, Redis, Kafka]
core_dependencies: 5
adrs_generated: 7
contracts_designed: 12
```

### Example 2: PHP → Go Migration via Strangler

```yaml
strangler_phases: 4
contexts_extracted: ["users", "orders", "catalog", "checkout"]
anti_corruption_layer: "nginx + custom routing"
duration_weeks: 16
success_metrics:
  - "behavior_equivalence_rate >= 99.9%"
  - "old_system_traffic: 0%"
```

## Migration Notes

This skill consolidates the following previously separate skills:
- `architecture-decision-recorder` — Step 5
- `architecture-pattern-selector` — Step 1
- `tech-stack-selector` — Step 2
- `data-flow-analyzer` — Step 3
- `interface-contract-designer` — Step 4 (exposed via architecture-planner; deep work via dedicated skill)
- `strangler-pattern-suite` — Step 6
