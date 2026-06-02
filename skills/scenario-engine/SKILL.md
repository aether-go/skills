---
name: scenario-engine
description: Use when detecting the current development scenario, recommending the appropriate mode (norm-driven, emergent exploration, intent-driven), configuring principle strengths per P0, and managing scenario-specific exemptions. This skill unifies D6 Scenario Adaptation Domain and replaces scenario-detector, scenario-mode-recommender, mode-selector, poc-exemption-manager, dual-track-validator, ai-native-build-workflow, standard-mode-workflow, federal-constitution-manager, and harness-reverse-construction-workflow.
---

# Scenario Engine

## Overview

The unified skill for scenario detection, mode recommendation, and principle adaptation. This skill:
- Detects the current development scenario (10 scenarios)
- Recommends the appropriate mode (norm-driven, emergent, intent-driven)
- Configures principle strengths per P0 (Context-Adaptation)
- Manages scenario-specific exemptions
- Provides workflow for each scenario (standard, AI-native, reverse engineering, etc.)

**Replaces** (consolidated from 9 skills):
- `scenario-detector`
- `scenario-mode-recommender`
- `mode-selector`
- `poc-exemption-manager`
- `dual-track-validator`
- `ai-native-build-workflow`
- `standard-mode-workflow`
- `federal-constitution-manager`
- `harness-reverse-construction-workflow`

## 10 Development Scenarios (Method Paper §4)

| # | Scenario | Trigger | Key Workflow |
|---|----------|---------|--------------|
| 1 | **Standard** | New greenfield project, no legacy | Full 6-layer derivation, all principles strict |
| 2 | **Reverse Engineering** | Modifying legacy system | Extract spec from code, characterization tests |
| 3 | **Continuous Improvement** | Long-lived system, tech debt | 70/20/10 budget allocation |
| 4 | **Language Migration** | Tech stack replacement (e.g., PHP → Go) | Behavior equivalence, dual-track validation |
| 5 | **Architecture Refactoring** | Architecture upgrade (monolith → microservices) | Strangler pattern, incremental replacement |
| 6 | **POC** | Innovation, high uncertainty | Exempt P2/P5, fast iteration |
| 7 | **Emergency Hotfix** | Production failure | Two-phase: immediate + post-incident |
| 8 | **Federal (Multi-team)** | Large multi-team effort | Global + local constitutions, CDC |
| 9 | **AI-Native Build** | Greenfield with AI as primary generator | Intent-driven mode, hybrid generation |
| 10 | **Harness Reverse** | Legacy with no specs, progressive constraint injection | Code-graph → constraint extraction → gradual Harness |

## 3 Development Modes

| Mode | Description | Spec Timing |
|------|-------------|-------------|
| **Norm-Driven** (A) | Spec-first, TDD confirms | Spec → Tests → Code |
| **Emergent Exploration** (B) | TDD-first, spec emerges | Tests → Code → Refined spec |
| **Intent-Driven** (C) | Structured intent + hybrid generation | Intent → Dispather → AI/Traditional |

## When to Use

```
Starting a new project phase? ───────────────┐
                                             │
Need to know which scenario applies? ────────┤
                                             │
Configuring principle strength per P0? ──────┼─► Use scenario-engine
                                             │
Managing exemptions for POC/emergency? ───────┤
                                             │
Need workflow for AI-native / Harness? ──────┘
```

## Input Format

```yaml
scenario_detection_request:
  project: "Aether Platform"
  project_state:
    is_greenfield: false
    has_legacy_code: true
    has_specifications: false
    has_tests: false
    is_ai_primary_generator: false
    team_size: 5
    is_emergency: false
    is_poc: false
    is_migration: false
    is_multi_team: false
  
  # Optional: explicit scenario override
  forced_scenario: null  # "ai-native" | "standard" | etc.
```

## Output Format

```yaml
scenario_detection_result:
  project: "Aether Platform"
  timestamp: "2026-06-02T10:00:00Z"
  
  detected_scenario: "harness-reverse"
  confidence: 0.92
  
  # Detection reasoning
  indicators:
    matched:
      - "has_legacy_code=true"
      - "has_specifications=false"
      - "is_greenfield=false"
    not_matched:
      - "is_emergency=false"
      - "is_migration=false"
  
  # Recommended mode
  recommended_mode: "intent-driven"  # norm-driven | emergent-exploration | intent-driven
  mode_rationale: "Harness reverse benefits from intent layering for constraint extraction"
  
  # P0 dynamic weighting
  active_principles:
    p1_purpose_driven: 1.0
    p2_planning_driven: 0.0    # EXEMPT for legacy parts
    p3_intent_hierarchization: 1.0
    p4_modularity: 1.0
    p5_interface_first: 1.0
    p6_occams_razor: 0.5      # Relaxed for legacy
    p7_constraint_mechanization: 1.0
    p8_tool_adaptation: 1.0
    p9_test_first: 0.5        # For modified modules
    p10_context_first: 1.0
    p11_nfr_built_in: 1.0
    p12_human_ai_boundary: 1.0
    p13_recursive_optimization: 1.0
    p14_knowledge_engine: 1.0
  
  exemptions:
    - principle: "P2"
      reason: "Cannot plan for unknown legacy code"
      scope: "legacy_parts"
    - principle: "P6"
      reason: "Existing dependencies retained"
      scope: "legacy_parts"
  
  workflow:
    phases:
      - phase: 1
        name: "Knowledge Engine Setup"
        actions: ["code_graph_analysis", "repo_wiki_generation", "commit_history_extraction"]
      - phase: 2
        name: "Constraint Extraction"
        actions: ["extract_implicit_architecture", "extract_naming_conventions", "encode_as_lint_rules"]
      - phase: 3
        name: "Progressive Harness Injection"
        actions: ["new_modules_strict", "modified_modules_enhanced", "stable_modules_lightweight"]
  
  next_skill: "code-graph-analyzer"  # Or merged equivalent
```

## Scenario-Specific Workflows

### Scenario 1: Standard

```mermaid
Stage 0: (Optional) Setup
Stage 1: Business Analysis (L1→L2)
Stage 2: Specification (L2→L3)
Stage 3: Constitution Review
Stage 4: Implementation Planning (L3→L4)
Stage 5: Code Generation (L4→L5)
Stage 6: Integration Validation
Stage 7: Deployment
Stage 8: Recursive Optimization
```

**Principle strengths**: All 1.0 (strict)

### Scenario 6: POC

```yaml
exemptions:
  p2_planning_driven: 0.0  # Cannot plan what we're exploring
  p5_interface_first: 0.0  # Interfaces emerge
  p6_occams_razor: 0.7    # Allow temporary coupling
p9_test_first: 0.5  # Manual validation OK for key paths

success_criteria:
  - "Technical feasibility demonstrated"
  - "Business value confirmed"

poc_to_standard_transition:
  - "Discard POC code (tech debt too high)"
  - "Extract stable spec from POC"
  - "Re-implement with standard mode"
  - "Assetize lessons learned"
```

### Scenario 7: Emergency Hotfix

```yaml
two_phase:
  phase_1:
    name: "Immediate Response"
    duration: "minutes"
    actions: ["diagnose", "fix", "verify", "deploy"]
    decision_maker: "on-call engineer"
    documentation: "post-incident"
  
  phase_2:
    name: "Post-Incident Normalization"
    deadline: "24h"
    actions:
      - "Extract spec from fix"
      - "Add characterization tests"
      - "Root cause analysis"
      - "Update skill library"

responsibility:
  exempted: "Phase 1 process violations"
  accountable:
    - "Missed 24h normalization"
    - "Recurrence of same defect"
```

### Scenario 9: AI-Native Build

```yaml
mode: "intent-driven"
key_principles:
  p3_intent_hierarchization: 1.3  # Critical
  p5_interface_first: 1.2          # Strict
  p7_constraint_mechanization: 1.2 # Strict
  p8_tool_adaptation: 1.3          # Maximize hybrid generation
  p2_planning_driven: 0.6          # Structured intent replaces detailed planning

workflow:
  - step: 1
    name: "Layered Intent Capture"
    output: ".aether/intent/{business,functional,implementation}.md"
  - step: 2
    name: "Constraint Mechanization"
    output: "constraints/*.yml + GATE-001 enabled"
  - step: 3
    name: "Hybrid Generation"
    deterministic: "oapi-codegen, sqlc, Vue Codegen"
    ai: "business logic, complex state machines"
  - step: 4
    name: "Confidence-Based Review"
    auto_approve: ">= 0.90"
    suggest_confirm: "0.70-0.90"
    mandatory_review: "< 0.70"
  - step: 5
    name: "Iterative Refinement"
    triggers: ["test failure", "low confidence", "principle violation"]

risks:
  - "Intent drift: review daily standups"
  - "Hidden tech debt: monitor coverage + complexity"
  - "Over-reliance on AI: enforce confidence thresholds"
```

### Scenario 10: Harness Reverse

```yaml
# Legacy system with no specs, progressive constraint injection
phases:
  phase_1_knowledge_engine:
    name: "Build Code Graph + Repo Wiki"
    actions:
      - "AI scans codebase"
      - "Generate code graph (call, reference, inheritance)"
      - "Extract design intent from git history"
      - "Identify key business paths and domain models"
    output: ".aether/knowledge/{code-graph,repo-wiki}/"
  
  phase_2_constraint_extraction:
    name: "Reverse-Engineer Constraints"
    actions:
      - "Extract implicit architecture (layering, dependencies)"
      - "Extract naming conventions"
      - "Extract behavior contracts (from tests or traffic logs)"
      - "Encode as executable lint/type-check rules"
    output: "constraints/legacy-architecture.yml"
  
  phase_3_progressive_injection:
    name: "Inject Harness Progressively"
    actions:
      - "New modules: full 6-layer derivation, strict principles"
      - "Modified modules: enhanced constraints"
      - "Stable modules: lightweight Harness, validate on change"
      - "Each modification: generate characterization test"
  
  core_advantage: "Avoids 'all-or-nothing' rewrite; gradual health improvement"
```

## Implementation

### Scenario Detection Logic

```python
def detect_scenario(state: dict) -> tuple[str, float]:
    """Detect scenario from project state."""
    rules = [
        (lambda s: s["is_emergency"], "emergency", 1.0),
        (lambda s: s["is_poc"], "poc", 0.95),
        (lambda s: s["is_ai_primary_generator"] and s["is_greenfield"], "ai-native", 0.95),
        (lambda s: s["is_migration"], "language-migration", 0.90),
        (lambda s: s["has_legacy_code"] and not s["has_specifications"], "harness-reverse", 0.92),
        (lambda s: s["has_legacy_code"] and s["has_specifications"], "reverse-engineering", 0.85),
        (lambda s: s["is_multi_team"], "federal", 0.90),
        (lambda s: s["is_greenfield"], "standard", 0.95),
        # Default for long-lived systems
        (lambda s: not s["is_greenfield"], "continuous-improvement", 0.75),
    ]
    
    for predicate, scenario, confidence in rules:
        if predicate(state):
            return scenario, confidence
    return "standard", 0.5  # Default
```

### P0 Dynamic Weighting

```python
def configure_principle_strengths(scenario: str) -> dict:
    """Apply P0 dynamic weighting for scenario."""
    profiles = {
        "standard": {p: 1.0 for p in PRINCIPLES},
        "poc": {"p2": 0, "p5": 0, "p6": 0.7, "p9": 0.5, **{p: 1.0 for p in PRINCIPLES if p not in ["p2", "p5", "p6", "p9"]}},
        "emergency": {"p9": 0.4, "p2": 0.5, **{p: 1.0 for p in PRINCIPLES if p not in ["p9", "p2"]}},
        "harness-reverse": {"p2": 0, "p6": 0.5, "p9": 0.5, **{p: 1.0 for p in PRINCIPLES if p not in ["p2", "p6", "p9"]}},
        "ai-native": {"p2": 0.6, "p3": 1.3, "p5": 1.2, "p7": 1.2, "p8": 1.3, **{p: 1.0 for p in PRINCIPLES if p not in ["p2", "p3", "p5", "p7", "p8"]}},
        "language-migration": {"p2": 0.7, "p9": 0.8, **{p: 1.0 for p in PRINCIPLES if p not in ["p2", "p9"]}},  # Behavior equivalence strict
        "federal": {p: 1.0 for p in PRINCIPLES},  # All strict, distributed enforcement
    }
    return profiles.get(scenario, profiles["standard"])
```

## Validation Rules

- ✅ Scenario detected with confidence > 0.7
- ✅ P0 weighting applied per scenario
- ✅ Exemptions explicitly documented with rationale
- ✅ Workflow phases match scenario characteristics

## Integration with Aether.go Methodology

- **Input from**: Project state, environment signals
- **Output to**:
  - `methodology-fusion-orchestrator` (drives stage selection)
  - `constitution-validator` (applies dynamic weighting)
  - All scenario-specific workflows
- **Part of**: D6 Scenario Adaptation Domain
- **Principle alignment**: Implements **P0** (Context-Adaptation)

## Migration Notes

This skill consolidates 9 previously separate skills:
- `scenario-detector` → Detection
- `scenario-mode-recommender` → Mode recommendation
- `mode-selector` → Mode switching with principle weights
- `poc-exemption-manager` → POC exemptions
- `dual-track-validator` → Language migration workflow
- `ai-native-build-workflow` → AI-native workflow
- `standard-mode-workflow` → Standard workflow
- `federal-constitution-manager` → Federal workflow
- `harness-reverse-construction-workflow` → Harness reverse workflow

**Invocation parameters**:
- `action: detect` → Scenario detection only
- `action: configure` → P0 weighting
- `action: workflow` → Get scenario-specific workflow
- `action: full` (default) → All
