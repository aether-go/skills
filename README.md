# Aether.go AI Agent Architecture V2.1

## Overview

Aether.go is an AI-native software engineering methodology that structures AI-assisted development through constitutional principles, multi-agent collaboration, and a five-layer derivation model. Version 2.1 introduces significant enhancements including meta-argumentation loops, dynamic principle weighting, semantic confirmation protocols, and comprehensive meta-capability skills.

## Core Concepts

### Constitutional Principles (P0-P10)

| Principle | Description | Key Aspect |
|-----------|-------------|------------|
| **P0: Context-Adaptation** | Dynamically adjust principles based on project context | Scenario mode selection |
| **P1: Purpose-Driven** | Business objectives drive technical decisions | Value decomposition |
| **P2: Planning-First** | Architecture decisions precede implementation | L2 before L5 |
| **P3: Modularity & Orthogonality** | High cohesion, low coupling | Interface contracts |
| **P4: Interface-First** | Contracts before implementation | Contract-driven generation |
| **P5: Occam's Razor** | Minimal dependencies (core <=5) | Dependency limits |
| **P6: Test-First** | Red-Green-Refactor cycle | TDD cycle runner |
| **P7: Context-First** | Input quality determines output quality | Context quality protocol |
| **P8: Human-AI Boundary** | Clear responsibility demarcation | Decision routing |
| **P9: Recursive Self-Optimization** | Continuous improvement loop | Optimization convergence |
| **P10: Skill Library Assetization** | Skills as reusable assets | Skill lifecycle management |

### Five-Layer Derivation Model

```
L1: Business Goals (Business Layer)
    ↓ value-decomposer
L2: Functional Requirements (System Behavior Layer)
    ↓ usecase-designer, spec-parser
L3: GWT Acceptance Criteria (Acceptance Standard Layer)
    ↓ test-pyramid-deriver
L4: Test Stratification + Interface Contracts (Component Contract Layer)
    ↓ tdd-cycle-runner, contract-driven-code-generator
L5: Implementation Code (Unit Implementation Layer)
```

### Meta-Argumentation Loop (V2.1 NEW)

```
Derivation Chain Self-Verification
    ├── META-001: derivation-chain-validator
    ├── META-002: skill-gap-analyzer + adjustment-proposer + adjustment-validator
    ├── META-003: principle-consistency-checker
    ├── META-004: architecture-self-auditor
    └── META-005: meta-skeptic (boundary rationality challenge)
```

## Agent Architecture

### 8 Core Agents

| Agent | Role | Key Responsibility |
|-------|------|-------------------|
| **WorkflowOrchestrator** | Workflow orchestration | 8-stage workflow with meta-argumentation checkpoints |
| **ChangeAndTaskAgent** | Change and task orchestration | Full lifecycle of requirement changes, /opsx-ff and /opsx-apply |
| **RecursiveOptimizer** | Recursive optimization | Multi-objective optimization with convergence control |
| **ConstitutionGuardian** | Constitutional guardian | P0-P10 enforcement with dynamic principle weighting |
| **UniversalSkeptic** | Universal skeptic | Cross-domain consistency with META-005 orchestration |
| **HumanAIBoundaryGuard** | Human-AI boundary guard | Decision routing with ARGUE-005 semantic confirmation |
| **ContextManager** | Context management | P7 implementation with derivation matrix |
| **SkillLibraryCurator** | Skill library curation | P10 implementation with D8 linkage |

### Agent Interaction Protocols

#### ARGUE Protocols
- **ARGUE-001**: UniversalSkeptic quality gate for stage transitions
- **ARGUE-002**: ConstitutionGuardian constitutional validation
- **ARGUE-003**: RecursiveOptimizer optimization proposal
- **ARGUE-004**: ContextManager context quality assessment
- **ARGUE-005**: HumanAIBoundaryGuard semantic confirmation (V2.1 NEW)

#### META Protocols
- **META-001**: Derivation chain validation
- **META-002**: Skill gap analysis and adjustment
- **META-003**: Principle consistency check with dynamic weighting
- **META-004**: Architecture self-audit
- **META-005**: Meta-skeptic boundary rationality challenge (V2.1 NEW)

## Skill Organization

### 8 Derivation Domains

| Domain | Skills | Purpose |
|--------|--------|---------|
| **D1: Value Derivation** | 8 skills | L1→L2: Business goals to functional requirements |
| **D2: Architecture Derivation** | 7 skills | L2→L3: Requirements to architecture decisions |
| **D3: Acceptance Standard** | 6 skills | L3: Acceptance criteria and quality standards |
| **D4: Contract Derivation** | 8 skills | L3→L4: Test stratification and interface contracts |
| **D5: Implementation Derivation** | 7 skills | L4→L5: Code implementation from contracts |
| **D6: Scenario Adaptation** | 8 skills | 8 scenario modes adaptation |
| **D7: Asset Generation** | 8 skills | Reusable asset generation |
| **D8: Meta-Capability** | 10 skills | Architecture validation and optimization |

### Critical New Skills (V2.1)

1. **value-decomposer** (D1) - L1→L2 derivation bridge
2. **test-pyramid-deriver** (D4) - L3→L4 with boundary identification
3. **tdd-cycle-runner** (D5) - Atomic TDD cycle
4. **contract-driven-code-generator** (D5) - Contract-first code generation
5. **code-refactor-engine** (D5) - Refactoring with test coverage
6. **scenario-detector** (D6) - Scenario mode detection
7. **semantic-intent-clarifier** (D8) - ARGUE-005 execution
8. **derivation-chain-validator** (D8) - META-001 validation
9. **principle-consistency-checker** (D8) - META-003 conflict detection
10. **meta-skeptic** (D8) - META-005 boundary challenge
11. **architecture-self-auditor** (D8) - META-004 audit
12. **skill-gap-analyzer** (D8) - Gap analysis
13. **adjustment-proposer** (D8) - Adjustment proposals
14. **adjustment-validator** (D8) - Proposal validation

## Key Features (V2.1)

### Dynamic Principle Weighting
- Real-time weight calculation based on context
- Conflict resolution through minimum damage path
- Constitutional amendment generation with time-boxing

### Semantic Confirmation Protocol (ARGUE-005)
- Structured reverse clarification at semantic nodes
- Prevents "perfect derivation, wrong software"
- Suspends workflow until user confirmation

### Derivation Chain Self-Verification
- Automatic gap detection between L1-L5
- Cross-layer traceability validation
- Block progression when gaps exist

### Test Pyramid Derivation with Redundancy Validation
- Boundary identification (user-system, system-external, system-internal)
- META-005 boundary rationality challenge
- Explicitized boundary rationale requirement

## Directory Structure

```
aether-go/
├── agents/                    # 8 core agents
│   ├── workflow-orchestrator.md
│   ├── change-and-task-agent.md
│   ├── recursive-optimizer.md
│   ├── constitution-guardian.md
│   ├── universal-skeptic.md
│   ├── human-ai-boundary-guard.md
│   ├── context-manager.md
│   └── skill-library-curator.md
├── skills/                    # 49 domain skills (8 domains)
│   ├── d1-value-derivation/
│   ├── d2-architecture-derivation/
│   ├── d3-acceptance-standard/
│   ├── d4-contract-derivation/
│   ├── d5-implementation-derivation/
│   ├── d6-scenario-adaptation/
│   ├── d7-asset-generation/
│   └── d8-meta-capability/
├── docs/                      # Documentation
│   ├── ai-agent-architecture-proposal.md
│   ├── SKILLS_SUMMARY.md
│   └── README.md
└── .aether/                   # Runtime state
    ├── context/
    ├── memory/
    ├── state/
    ├── derivation/
    └── principles/
```

## Getting Started

### Prerequisites
- Understanding of Aether methodology principles
- Familiarity with five-layer derivation model
- Knowledge of ARGUE and META protocols

### Quick Start
1. Review constitutional principles (P0-P10)
2. Understand five-layer derivation model (L1-L5)
3. Identify appropriate scenario mode (D6)
4. Execute workflow through WorkflowOrchestrator
5. Monitor derivation chain with D8 meta-capability skills

### Scenario Modes
- **standard**: Full methodology application
- **reverse_engineering**: Legacy system analysis
- **language_migration**: Technology stack migration
- **refactoring**: System restructuring
- **poc**: Proof of concept validation
- **emergency**: Emergency production fix
- **federal**: Multi-team distributed development
- **continuous_improvement**: Ongoing optimization

## Quality Gates

### Per-Stage Quality Criteria
- **L1→L2**: Business goals quantified, FRs traceable
- **L2→L3**: Architecture decisions documented, interfaces defined
- **L3→L4**: GWT scenarios complete, test stratification defined
- **L4→L5**: Contracts implemented, tests passing

### Meta-Argumentation Checkpoints
- **Checkpoint 1**: L1 decomposition complete (ARGUE-005)
- **Checkpoint 2**: L2 architecture established
- **Checkpoint 3**: L3 acceptance criteria defined
- **Checkpoint 4**: L4 test stratification validated (META-005)
- **Checkpoint 5**: L5 implementation complete

## Contributing

### Skill Development
1. Identify gap or improvement opportunity
2. Design skill following SKILL.md template
3. Validate with correctness-checker and completeness-checker
4. Submit for architecture-self-auditor review
5. Integrate into appropriate domain

### Agent Enhancement
1. Review agent interaction protocols
2. Identify enhancement opportunity
3. Update agent documentation
4. Validate with principle-consistency-checker
5. Test with workflow-orchestrator

## Version History

| Version | Date | Key Changes |
|---------|------|-------------|
| 1.0 | 2025-01 | Initial architecture with 7 agents, 42 skills |
| 2.0 | 2025-03 | Added D8 meta-capability domain, ChangeAndTaskAgent |
| 2.1 | 2025-04 | Meta-argumentation loops, dynamic weighting, ARGUE-005, META-005 |

## License

MIT License - See LICENSE file for details

## References

- Aether Methodology Specification
- Five-Layer Derivation Model
- Constitutional Principles Document
- ARGUE and META Protocol Specifications
