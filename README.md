# Aether.go Skills (V3.0 Consolidated)

A set of intelligent AI skills for the Aether.go project, based on spec-driven, value-oriented, and test-first development methodology, implementing the five-layer derivation model and constitutional principles.

---

**Language**: [English](README.md) | [中文](README_CN.md)

---

## Overview

Based on [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) and [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md), this repository contains **25 skills** organized into **A-G functional groups** covering the complete five-layer derivation model and the 15 constitutional principles (P0-P14).

> **V3.0 Consolidation**: Reduced from 99 to 25 skills (75% reduction) while maintaining complete coverage of the methodology. See [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) for details.

### Five-Layer Derivation Model

```
L1: Business Value Layer
    └── A1: requirement-analyzer (L1)

L2: System Behavior Layer
    └── A2: architecture-planner (L2)

L3: Acceptance Standard Layer
    └── A3: spec-engineer (L3)

L4: Component Contract Layer
    └── A4: test-planner (L4)

L4.5: Generation Dispatch Layer (NEW)
    └── A5: generation-dispatcher (L4.5)

L5: Unit Implementation Layer
    └── A6: code-generator (L5)
```

### Core Groups: A-G (25 Skills)

| Group | Name | Skills | Description |
|-------|------|--------|-------------|
| **A** | Derivation Chain | 6 | L1→L2→L3→L4→L4.5→L5 linear pipeline |
| **B** | Project Support | 3 | Cross-cutting concerns (scaffolding, constitution, context) |
| **C** | Scenario Adaptation | 3 | Scenario detection and specialized workflows |
| **D** | Operations | 2 | Deployment, incident, release management |
| **E** | Evolution | 3 | Recursive optimization, skill management, metrics |
| **F** | Meta | 2 | Architecture audit, universal skeptic layer |
| **G** | Standalone | 6 | Independent core capabilities (intent, TDD, refactor, etc.) |

### Constitutional Principles Coverage (P0-P14)

The skill library implements all 15 constitutional principles from method-paper.md V3.0:
- **P0** Context-Adaptation · **P1** Constitutional Primacy · **P2** Architecture-Decision-Traceability
- **P3** Specification-Explicitness · **P4** Interface-First · **P5** Test-First
- **P6** Occam's Razor · **P7** Context-First · **P8** Progressive-Validation
- **P9** Recursive-Optimization · **P10** Knowledge-Engine · **P11** Quality-Gate
- **P12** Human-AI-Boundary · **P13** Scenario-Adaptive · **P14** Skill-Assetization

## Skill Catalog

### Group A: Derivation Chain (6 skills)

| # | Skill | Layer | Merges (Count) | Purpose |
|---|-------|-------|----------------|---------|
| 1 | **requirement-analyzer** | L1 | 6→1 | Business requirements collection, classification (13 categories), value decomposition, metrics definition |
| 2 | **architecture-planner** | L2 | 6→1 | Architecture pattern + tech stack selection, data flow analysis, interface contracts (P4) |
| 3 | **spec-engineer** | L3 | 8→1 | Spec parsing, use case design, BDD/ATDD scenario writing, NFR analysis, version management |
| 4 | **test-planner** | L4 | 9→1 | Test pyramid derivation (unit/integration/contract/system/e2e/non-functional) |
| 5 | **generation-dispatcher** | L4.5 | 4→1 | Deterministic evaluation, dispatch decision, contract consistency gate |
| 6 | **code-generator** | L5 | 4→1 | Code generation from interface contracts (frontend + backend + language-agnostic) |

### Group B: Project Support (3 skills)

| # | Skill | Purpose |
|---|-------|---------|
| 7 | **go-fullstack-scaffolder** | Generate Go + Vue + Quasar fullstack project (scaffolding, Makefile, README, LICENSE) |
| 8 | **constitution-validator** | Validate against P0-P14 principles; resolve principle conflicts |
| 9 | **context-manager** | Project context, conversation history, derivation matrix (P7) |

### Group C: Scenario Adaptation (3 skills)

| # | Skill | Purpose |
|---|-------|---------|
| 10 | **scenario-engine** | Detect scenario (10 modes), recommend mode, support federal/dual-track workflows |
| 11 | **reverse-engineering-suite** | Extract specs from legacy systems (static + dynamic analysis) |
| 12 | **wartime-hotfix-workflow** | Two-phase emergency response (immediate + 24h normalization) |

### Group D: Operations (2 skills)

| # | Skill | Purpose |
|---|-------|---------|
| 13 | **deployment-orchestrator** | Blue-green/canary/rolling deployment + rollback + release + change management |
| 14 | **incident-manager** | Full ITIL incident + problem management lifecycle |

### Group E: Evolution (3 skills)

| # | Skill | Purpose |
|---|-------|---------|
| 15 | **recursive-optimizer** | Recursive self-optimization of skills, prompts, workflows |
| 16 | **skill-manager** | Skill library lifecycle (create/validate/optimize/retire) |
| 17 | **metrics-tracker** | AI effectiveness + system quality metrics |

### Group F: Meta (2 skills)

| # | Skill | Purpose |
|---|-------|---------|
| 18 | **architecture-auditor** | Audit overall architecture + derivation chain integrity (L1-L5) |
| 19 | **universal-skeptic** | Cross-domain validation: correctness, completeness, consistency, boundedness |

### Group G: Standalone (6 skills)

| # | Skill | Purpose |
|---|-------|---------|
| 20 | **intent-hierarchizer** | Hierarchize user intent into Goal → Sub-Goal → Task → Sub-Task |
| 21 | **methodology-fusion-orchestrator** | Orchestrate end-to-end Aether methodology fusion across 8 stages |
| 22 | **tdd-cycle-runner** | Atomic red-green-refactor TDD cycle, bridging L4 tests to L5 implementation |
| 23 | **code-refactor-engine** | Refactor code while maintaining test coverage (supports P9) |
| 24 | **meta-skeptic** | Challenge boundary rationality of test-pyramid-deriver outputs (META-005) |
| 25 | **semantic-intent-clarifier** | Reverse clarification questions at critical requirement semantic nodes |

## Standard Derivation Pipeline

```
Intent → Scenario → L1 → L2 → L3 → L4 → L4.5 → L5 → Validation → Deployment → Operations → Evolution
```

| Step | Stage | Skills |
|------|-------|--------|
| 0 | Pre-derivation | intent-hierarchizer, semantic-intent-clarifier, context-manager |
| 1 | Scenario detection | scenario-engine |
| 2 | L1 Requirements | requirement-analyzer |
| 3 | L2 Architecture | architecture-planner, go-fullstack-scaffolder |
| 4 | L3 Specifications | spec-engineer |
| 5 | L4 Tests | test-planner |
| 6 | L4.5 Dispatch | generation-dispatcher |
| 7 | L5 Code | code-generator, tdd-cycle-runner, code-refactor-engine |
| 8 | Validation | constitution-validator, architecture-auditor, universal-skeptic, meta-skeptic |
| 9 | Deployment | deployment-orchestrator |
| 10 | Operations | incident-manager, wartime-hotfix-workflow |
| 11 | Evolution | metrics-tracker, recursive-optimizer, skill-manager |

## Directory Structure

```
skills/
├── README.md (this file)
├── SKILLS_SUMMARY.md
├── skill-dependencies.yaml
├── LICENSE
│
├── A. Derivation Chain (6)
│   ├── requirement-analyzer/
│   ├── architecture-planner/
│   ├── spec-engineer/
│   ├── test-planner/
│   ├── generation-dispatcher/
│   └── code-generator/
│
├── B. Project Support (3)
│   ├── go-fullstack-scaffolder/
│   ├── constitution-validator/
│   └── context-manager/
│
├── C. Scenario Adaptation (3)
│   ├── scenario-engine/
│   ├── reverse-engineering-suite/
│   └── wartime-hotfix-workflow/
│
├── D. Operations (2)
│   ├── deployment-orchestrator/
│   └── incident-manager/
│
├── E. Evolution (3)
│   ├── recursive-optimizer/
│   ├── skill-manager/
│   └── metrics-tracker/
│
├── F. Meta (2)
│   ├── architecture-auditor/
│   └── universal-skeptic/
│
└── G. Standalone (6)
    ├── intent-hierarchizer/
    ├── methodology-fusion-orchestrator/
    ├── tdd-cycle-runner/
    ├── code-refactor-engine/
    ├── meta-skeptic/
    └── semantic-intent-clarifier/
```

## Migration from V2.x (99 skills)

V3.0 consolidated 99 skills into 25. See [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) for the full mapping table.

**Backup tag**: `pre-v3-consolidation`

**Key consolidation principles**:
1. **Merger rule**: Skills with >50% conceptual overlap and same layer/scenario merge
2. **No orphan capability**: All source capabilities are exposed in target skill
3. **KISS**: Minimize skill count without losing functionality
4. **Production-grade**: Each merged skill is 250+ lines with complete I/O contracts

## License

MIT License - see [LICENSE](LICENSE)
