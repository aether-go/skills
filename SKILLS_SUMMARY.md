# Aether.go Skill Library Summary (V2.1)

## Overview

The Aether.go methodology V2.1 organizes 49 domain skills into 8 derivation domains (D1-D8), following the five-layer derivation model (L1-L5) and supporting 8 core agents through ARGUE and META protocols.

## Skill Organization

### D1: Value Derivation Domain (L1→L2)
**Purpose**: Transform business goals into measurable functional requirements

| Skill | Description | Derivation Layer |
|-------|-------------|-----------------|
| **business-requirements-collector** | Gather stakeholder requirements | L1 |
| **value-decomposer** | Decompose business goals into functional requirements | L1→L2 |
| **metrics-definer** | Define success metrics and KPIs | L1→L2 |
| **business-value-mapper** | Map business value to technical decisions | L1→L2 |
| **usecase-designer** | Design use cases from functional requirements | L2 |
| **spec-parser** | Parse specifications into structured format | L2 |
| **spec-evolution-tracker** | Track specification changes | L2 |
| **requirement-implementation-tracer** | Trace requirements to implementation | L2→L5 |

### D2: Architecture Derivation Domain (L2→L3)
**Purpose**: Derive architecture decisions from functional requirements

| Skill | Description | Derivation Layer |
|-------|-------------|-----------------|
| **architecture-pattern-selector** | Select appropriate architecture patterns | L2→L3 |
| **tech-stack-selector** | Select technology stack | L2→L3 |
| **data-flow-analyzer** | Analyze data flow and value chain | L2→L3 |
| **interface-contract-designer** | Design interface contracts | L3 |
| **spec-to-scenario** | Convert specifications to scenarios | L2→L3 |
| **scenario-detector** | Detect appropriate development scenario mode | L2→L3 |
| **bdd-scenario-writer** | Write BDD scenarios | L3 |

### D3: Acceptance Standard Derivation Domain (L3)
**Purpose**: Derive acceptance criteria and quality standards

| Skill | Description | Derivation Layer |
|-------|-------------|-----------------|
| **spec-to-code-tracer** | Trace specifications to code | L3→L5 |
| **requirements-to-code-docs** | Generate documentation from requirements | L3→L5 |
| **correctness-checker** | Check technical accuracy | L3 |
| **completeness-checker** | Check coverage completeness | L3 |
| **consistency-checker** | Check cross-layer consistency | L3 |
| **boundedness-checker** | Check optimization boundaries | L3 |

### D4: Contract Derivation Domain (L3→L4) - MOST CRITICAL
**Purpose**: Derive test stratification and interface contracts

| Skill | Description | Derivation Layer |
|-------|-------------|-----------------|
| **test-pyramid-deriver** | Derive test stratification from GWT criteria | L3→L4 |
| **test-pyramid-analyzer** | Analyze test quality and distribution | L4 |
| **chaos-test-designer** | Design resilience and fault tolerance tests | L4 |
| **e2e-test-generator** | Generate end-to-end tests | L3→L4 |
| **contract-test-generator** | Generate contract tests | L4 |
| **integration-test-generator** | Generate integration tests | L4 |
| **system-test-generator** | Generate system tests | L4 |
| **unit-test-generator** | Generate unit tests | L4→L5 |

### D5: Implementation Derivation Domain (L4→L5)
**Purpose**: Derive implementation code from contracts and tests

| Skill | Description | Derivation Layer |
|-------|-------------|-----------------|
| **tdd-cycle-runner** | Execute TDD red-green-refactor cycle | L4→L5 |
| **contract-driven-code-generator** | Generate code from interface contracts | L4→L5 |
| **code-refactor-engine** | Refactor code while maintaining tests | L5 |
| **backend-code-generator** | Generate backend code | L5 |
| **api-generator** | Generate API code | L5 |
| **frontend-code-generator** | Generate frontend code | L5 |
| **database-schema-generator** | Generate database schemas | L5 |
| **security-code-generator** | Generate security-related code | L5 |

### D6: Scenario Adaptation Domain
**Purpose**: Adapt methodology to different development scenarios

| Skill | Description | Scenario Modes |
|-------|-------------|----------------|
| **scenario-detector** | Detect appropriate scenario mode | All |
| **reverse-engineering-guide** | Guide legacy system analysis | reverse_engineering |
| **migration-planner** | Plan technology migration | language_migration |
| **refactoring-guide** | Guide system refactoring | refactoring |
| **poc-validator** | Validate proof of concept | poc |
| **emergency-response-guide** | Guide emergency fixes | emergency |
| **federal-coordination-guide** | Guide multi-team coordination | federal |
| **continuous-improvement-guide** | Guide ongoing optimization | continuous_improvement |

### D7: Asset Generation Domain
**Purpose**: Generate reusable assets and documentation

| Skill | Description | Output |
|-------|-------------|--------|
| **go-backend-scaffolder** | Scaffold Go backend projects | Project template |
| **go-cli-builder** | Build Go CLI applications | CLI tool |
| **go-vue-fullstack-workflow** | Fullstack Go + Vue workflow | Fullstack app |
| **rust-cli-builder** | Build Rust CLI applications | CLI tool |
| **vue-quasar-scaffolder** | Scaffold Vue + Quasar projects | Frontend app |
| **makefile-backend-generator** | Generate backend Makefiles | Build config |
| **fullstack-project-setup** | Setup fullstack projects | Project structure |
| **skill-packaging-tool** | Package skills as reusable assets | Skill package |

### D8: Meta-Capability Domain (V2.1 NEW)
**Purpose**: Provide meta-level capabilities for architecture validation and optimization

| Skill | Description | Protocol |
|-------|-------------|----------|
| **semantic-intent-clarifier** | Generate structured clarification questions | ARGUE-005 |
| **derivation-chain-validator** | Validate derivation chain integrity | META-001 |
| **principle-consistency-checker** | Check principle consistency | META-003 |
| **meta-skeptic** | Challenge boundary rationality | META-005 |
| **architecture-self-auditor** | Audit architecture dimensions | META-004 |
| **skill-gap-analyzer** | Analyze skill coverage gaps | META-002 |
| **adjustment-proposer** | Propose architecture adjustments | META-002 |
| **adjustment-validator** | Validate adjustment proposals | META-002 |
| **skill-optimizer** | Optimize skill parameters | P9 |
| **skill-recommender** | Recommend skills for tasks | P10 |

## Skill Count by Domain

| Domain | Count | Percentage |
|--------|-------|------------|
| D1: Value Derivation | 8 | 16.3% |
| D2: Architecture Derivation | 7 | 14.3% |
| D3: Acceptance Standard | 6 | 12.2% |
| D4: Contract Derivation | 8 | 16.3% |
| D5: Implementation Derivation | 7 | 14.3% |
| D6: Scenario Adaptation | 8 | 16.3% |
| D7: Asset Generation | 8 | 16.3% |
| D8: Meta-Capability | 10 | 20.4% |
| **Total** | **62** | **100%** |

*Note: Total includes both existing and V2.1 new skills. Core methodology skills: 49*

## New Skills in V2.1

### Critical New Skills (Must Implement)

1. **value-decomposer** (D1) - L1→L2 derivation bridge
2. **test-pyramid-deriver** (D4) - L3→L4 derivation with boundary identification
3. **tdd-cycle-runner** (D5) - Atomic TDD red-green-refactor cycle
4. **contract-driven-code-generator** (D5) - Code generation from interface contracts
5. **code-refactor-engine** (D5) - Refactoring with test coverage maintenance
6. **scenario-detector** (D6) - Scenario mode detection

### Meta-Capability Skills (D8)

7. **semantic-intent-clarifier** - ARGUE-005 protocol execution
8. **derivation-chain-validator** - META-001 derivation validation
9. **principle-consistency-checker** - META-003 principle conflict detection
10. **meta-skeptic** - META-005 boundary rationality challenge
11. **architecture-self-auditor** - META-004 architecture audit
12. **skill-gap-analyzer** - Skill coverage gap analysis
13. **adjustment-proposer** - Architecture adjustment proposals
14. **adjustment-validator** - Adjustment proposal validation

## Skill Dependencies

### Derivation Chain Dependencies

```
L1: business-requirements-collector
    └── value-decomposer
        └── usecase-designer
            └── spec-parser
                ├── L2: architecture-pattern-selector
                │   └── interface-contract-designer
                │       └── L3: bdd-scenario-writer
                │           └── test-pyramid-deriver
                │               ├── L4: e2e-test-generator
                │               ├── L4: contract-test-generator
                │               ├── L4: integration-test-generator
                │               ├── L4: system-test-generator
                │               └── L4: unit-test-generator
                │                   └── L5: tdd-cycle-runner
                │                       └── contract-driven-code-generator
                │                           └── code-refactor-engine
                └── L3: spec-to-scenario
```

### Meta-Capability Dependencies

```
architecture-self-auditor
    ├── skill-gap-analyzer
    │   └── adjustment-proposer
    │       └── adjustment-validator
    └── derivation-chain-validator
        ├── principle-consistency-checker
        └── meta-skeptic
            └── semantic-intent-clarifier
```

## Quality Metrics

| Metric | Target | Measurement |
|--------|--------|-------------|
| Success Rate | > 85% | Successful executions / Total executions |
| User Satisfaction | > 4.0/5.0 | User feedback scores |
| Usage Frequency | > 10/month | Monthly invocations |
| Documentation Quality | > 90% | Completeness score |
| Derivation Coverage | > 95% | L1-L5 traceability |
| Semantic Confirmation Rate | > 90% | ARGUE-005 pass rate |
| Boundary Rationality | > 95% | META-005 pass rate |

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-01 | Initial skill library |
| 2.0 | 2025-03 | Added D8 meta-capability domain |
| 2.1 | 2025-04 | Enhanced with ARGUE/META protocols, dynamic weighting, semantic confirmation |
