---
name: scenario-mode-selector
description: Use when selecting appropriate development mode based on project context, constraints, and uncertainty levels
---

# Scenario Mode Selector

## Overview
Select the appropriate development scenario mode based on project context, uncertainty levels, and constraints. The Aether.go methodology defines 8 scenario adaptation patterns to handle different development situations.

## When to Use

```
Starting new project? ────────────────────┐
                                         │
Working with legacy system? ──────────────┤
                                         ├─► Use scenario-mode-selector
Facing emergency production issue? ────────┤
                                         │
Need to migrate technology stack? ────────┘
```

Use when:
- Starting a new project and need to determine development approach
- Working with legacy systems requiring reverse engineering
- Facing emergency production issues requiring rapid fixes
- Migrating technology stack or languages
- Conducting proof-of-concept or spike work
- Refactoring existing codebase
- Working in federal/distributed team environment
- Planning continuous improvement initiatives

Don't use when:
- Standard development with clear requirements (use standard-mode implicitly)
- Simple bug fixes in well-understood codebase
- Routine maintenance tasks

## Core Pattern

### Eight Scenario Adaptation Patterns

Aether.go methodology defines 8 scenario modes based on project context:

```
┌─────────────────────────────────────────────────────────────────┐
│                    Scenario Selection Matrix                     │
├─────────────────┬──────────────┬──────────────┬─────────────────┤
│ Scenario Mode   │ Requirements │ Domain       │ Uncertainty     │
│                 │ Clarity      │ Knowledge    │ Level           │
├─────────────────┼──────────────┼──────────────┼─────────────────┤
│ Standard Mode   │ Clear        │ Mature       │ Low             │
│ Reverse Eng.    │ N/A          │ Legacy       │ High            │
│ Lang Migration  │ Partial      │ Partial      │ Medium          │
│ Refactoring     │ Clear        │ Mature       │ Low-Medium      │
│ POC Mode        │ Exploratory  │ Unknown      │ Very High       │
│ Emergency Mode  │ Critical     │ Any          │ Time-critical   │
│ Federal Mode    │ Distributed  │ Varies       │ Coordination    │
│ Continuous Imp. │ Incremental  │ Evolving     │ Managed         │
└─────────────────┴──────────────┴──────────────┴─────────────────┘
```

### Mode Selection Decision Tree

```
Project Context Assessment
    │
    ├── New Project?
    │   ├── Clear requirements + Mature domain? ──► Standard Mode
    │   ├── Technology unknown? ───────────────────► POC Mode
    │   └── Distributed teams? ────────────────────► Federal Mode
    │
    ├── Existing System?
    │   ├── Legacy code, no docs? ─────────────────► Reverse Engineering Mode
    │   ├── Technology migration needed? ──────────► Language Migration Mode
    │   ├── Code quality issues? ──────────────────► Refactoring Mode
    │   └── Production emergency? ─────────────────► Emergency Mode
    │
    └── Improvement Focus?
        └── Incremental optimization? ─────────────► Continuous Improvement Mode
```

## The Eight Scenario Modes

### 1. Standard Mode (标准模式)
**Chinese:** 标准模式

**When to Use:**
- New project with clear requirements
- Mature domain knowledge available
- Low uncertainty
- Complete specifications available

**Characteristics:**
```yaml
standard_mode:
  applicability:
    requirements_clarity: "clear"
    domain_knowledge: "mature"
    uncertainty_level: "low"
  
  workflow:
    - stage_1_business_analysis
    - stage_2_specification
    - stage_3_constitutional_review
    - stage_4_implementation_planning
    - stage_5_code_generation
    - stage_6_integration_validation
    - stage_7_deployment
    - stage_8_recursive_optimization
  
  principles:
    all_applicable: true
    exemptions: []
  
  test_distribution:
    L5_unit: 70%
    L4_contract: 10%
    L4_integration: 15%
    L3_acceptance: 4%
    L2_system: 1%
```

**Key Activities:**
- Full 8-stage methodology execution
- Complete specification before implementation
- All constitutional principles apply
- Standard test pyramid distribution

---

### 2. Reverse Engineering Mode (逆向工程模式)
**Chinese:** 逆向工程模式

**When to Use:**
- Legacy system with no documentation
- Need to understand existing behavior
- Requirements must be extracted from code
- Maintenance of undocumented systems

**Characteristics:**
```yaml
reverse_engineering_mode:
  applicability:
    requirements_clarity: "unknown"
    domain_knowledge: "legacy"
    uncertainty_level: "high"
  
  workflow:
    - stage_0_code_analysis          # NEW: Analyze existing code
    - stage_1_behavior_extraction    # MODIFIED: Extract from code
    - stage_2_specification_recovery # MODIFIED: Recover specs
    - stage_3_constitutional_review
    - stage_4_reimplementation_plan
    - stage_5_code_generation
    - stage_6_integration_validation
    - stage_7_deployment
    - stage_8_recursive_optimization
  
  principles:
    exemptions:
      - P2_planning_driven  # Planning based on extracted behavior
      - P4_interface_first  # Interfaces extracted from code
  
  techniques:
    - static_analysis
    - dynamic_analysis
    - behavior_extraction
    - pattern_recognition
    - specification_recovery
```

**Key Activities:**
- Analyze existing codebase structure
- Extract behavioral specifications from code
- Document implicit business rules
- Create test cases from observed behavior
- Gradual refactoring with test protection

**Exemptions:**
- P2 (Planning-Driven): Planning based on extracted behavior
- P4 (Interface-First): Interfaces discovered from existing code

---

### 3. Language Migration Mode (语言迁移模式)
**Chinese:** 语言迁移模式

**When to Use:**
- Migrating from one programming language to another
- Technology stack modernization
- Partial domain knowledge in target language
- Preserving behavior while changing implementation

**Characteristics:**
```yaml
language_migration_mode:
  applicability:
    requirements_clarity: "partial"
    domain_knowledge: "partial"
    uncertainty_level: "medium"
  
  workflow:
    - stage_0_source_analysis        # NEW: Analyze source language
    - stage_1_requirement_mapping    # MODIFIED: Map to target
    - stage_2_specification_adapt    # MODIFIED: Language-specific
    - stage_3_constitutional_review
    - stage_4_migration_planning
    - stage_5_code_generation
    - stage_6_integration_validation
    - stage_7_deployment
    - stage_8_recursive_optimization
  
  principles:
    exemptions: []
    adaptations:
      - language_specific_patterns
      - paradigm_differences
  
  validation:
    - behavioral_equivalence_testing
    - side_by_side_comparison
    - gradual_cutover
```

**Key Activities:**
- Map source language patterns to target
- Adapt specifications for language paradigms
- Maintain behavioral equivalence
- Handle language-specific constraints
- Validate functional parity

---

### 4. Refactoring Mode (重构模式)
**Chinese:** 重构模式

**When to Use:**
- Improving code quality without changing behavior
- Addressing technical debt
- Enhancing maintainability
- Preparing for feature additions

**Characteristics:**
```yaml
refactoring_mode:
  applicability:
    requirements_clarity: "clear"
    domain_knowledge: "mature"
    uncertainty_level: "low_to_medium"
  
  workflow:
    - stage_0_code_assessment        # NEW: Assess refactoring targets
    - stage_1_behavior_preservation  # MODIFIED: Lock behavior
    - stage_2_specification_confirm  # MODIFIED: Confirm specs
    - stage_3_constitutional_review
    - stage_4_refactoring_plan
    - stage_5_refactoring_execution  # MODIFIED: Refactoring-specific
    - stage_6_integration_validation
    - stage_7_deployment
    - stage_8_recursive_optimization
  
  principles:
    emphasis:
      - P6_test_first: "critical"     # Tests MUST protect behavior
      - P5_occams_razor: "high"       # Simplify during refactoring
  
  safety_measures:
    - comprehensive_test_coverage
    - incremental_changes
    - continuous_validation
    - rollback_capability
```

**Key Activities:**
- Establish comprehensive test coverage first
- Preserve all existing behavior
- Apply refactoring patterns systematically
- Validate after each change
- Document improvements

---

### 5. POC Mode / Spike Mode (POC模式)
**Chinese:** POC模式 / 技术验证模式

**When to Use:**
- Exploring unknown technologies
- Validating technical feasibility
- Prototyping new approaches
- Time-boxed exploration (typically 1-4 weeks)

**Characteristics:**
```yaml
poc_mode:
  applicability:
    requirements_clarity: "exploratory"
    domain_knowledge: "unknown"
    uncertainty_level: "very_high"
  
  workflow:
    - stage_1_hypothesis_definition  # MODIFIED: Hypothesis-driven
    - stage_2_experiment_design      # MODIFIED: Experiment format
    - stage_3_quick_validation
    - stage_4_poc_implementation     # MODIFIED: Simplified planning
    - stage_5_code_generation        # MODIFIED: Rapid prototyping
    - stage_6_validation
    - stage_7_knowledge_capture      # MODIFIED: Document learnings
  
  principles:
    exemptions:
      - P2_planning_driven: "relaxed"    # Hypothesis-validation framework
      - P4_interface_first: "relaxed"    # Interfaces may emerge
      - P6_test_first: "relaxed"         # Manual validation acceptable
    
    time_constraints:
      max_duration: "4 weeks"
      checkpoints: ["1 week", "2 weeks", "4 weeks"]
  
  outcomes:
    - go_decision: "Proceed to Standard Mode"
    - no_go_decision: "Abandon or pivot"
    - knowledge_capture: "Document all learnings"
```

**Key Activities:**
- Define clear hypothesis to validate
- Time-box the exploration
- Focus on learning, not production quality
- Document all findings
- Make go/no-go decision at end

**Exemptions:**
- P2 (Planning-Driven): Relaxed to hypothesis-validation
- P4 (Interface-First): Interfaces may emerge during exploration
- P6 (Test-First): Manual validation acceptable

---

### 6. Emergency Mode (紧急模式)
**Chinese:** 紧急模式

**When to Use:**
- Critical production issues
- Security vulnerabilities requiring immediate fix
- Service outages
- Data corruption incidents

**Characteristics:**
```yaml
emergency_mode:
  applicability:
    requirements_clarity: "critical"
    domain_knowledge: "any"
    uncertainty_level: "time_critical"
  
  workflow:
    - stage_0_incident_assessment    # NEW: Triage
    - stage_1_hotfix_implementation  # MODIFIED: Immediate fix
    - stage_2_validation
    - stage_3_deployment             # MODIFIED: Emergency deploy
    - stage_4_post_incident          # NEW: Follow-up
  
  principles:
    exemptions:
      - P2_planning_driven: "waived"     # Immediate action required
      - P6_test_first: "waived"          # Fix first, test after
    
    time_constraints:
      target_resolution: "4 hours"
      max_resolution: "24 hours"
  
  post_emergency:
    - root_cause_analysis
    - proper_test_addition
    - process_improvement
    - knowledge_documentation
```

**Key Activities:**
- Triage and assess impact
- Implement minimal fix to restore service
- Deploy immediately
- Post-incident: add proper tests and documentation
- Complete resolution within 24 hours

**Exemptions:**
- P2 (Planning-Driven): Waived for immediate response
- P6 (Test-First): Waived, but must add tests within 24 hours

---

### 7. Federal Mode (联邦模式)
**Chinese:** 联邦模式

**When to Use:**
- Distributed teams across locations/timezones
- Multiple organizations collaborating
- Different skill levels across teams
- Need for autonomous but coordinated work

**Characteristics:**
```yaml
federal_mode:
  applicability:
    requirements_clarity: "distributed"
    domain_knowledge: "varies"
    uncertainty_level: "coordination"
  
  workflow:
    - stage_1_federal_requirements   # MODIFIED: Distributed gathering
    - stage_2_federal_specification  # MODIFIED: Modular specs
    - stage_3_constitutional_review
    - stage_4_federal_planning       # MODIFIED: Team-specific plans
    - stage_5_federal_execution      # MODIFIED: Parallel execution
    - stage_6_federal_integration    # MODIFIED: Integration focus
    - stage_7_federal_deployment
    - stage_8_federal_optimization
  
  coordination:
    - interface_contracts: "strict"     # Critical for integration
    - communication_protocols: "defined"
    - synchronization_points: "scheduled"
  
  principles:
    emphasis:
      - P4_interface_first: "critical"    # Essential for coordination
      - P8_human_ai_boundary: "high"      # Clear responsibility
```

**Key Activities:**
- Define strict interface contracts between teams
- Establish clear communication protocols
- Schedule synchronization points
- Maintain modular specifications
- Focus on integration testing

---

### 8. Continuous Improvement Mode (持续改进模式)
**Chinese:** 持续改进模式

**When to Use:**
- Incremental optimization of existing system
- Addressing performance bottlenecks
- Improving user experience gradually
- Technical debt reduction over time

**Characteristics:**
```yaml
continuous_improvement_mode:
  applicability:
    requirements_clarity: "incremental"
    domain_knowledge: "evolving"
    uncertainty_level: "managed"
  
  workflow:
    - stage_1_metric_analysis        # MODIFIED: Data-driven
    - stage_2_opportunity_identify   # MODIFIED: Prioritize
    - stage_3_constitutional_review
    - stage_4_improvement_plan
    - stage_5_implementation
    - stage_6_validation
    - stage_7_deployment
    - stage_8_recursive_optimization # MODIFIED: Continuous
  
  principles:
    emphasis:
      - P9_recursive_self_optimization: "critical"
      - P1_purpose_driven: "high"         # Measure business impact
  
  metrics:
    - baseline_measurement
    - improvement_tracking
    - roi_calculation
    - feedback_loops
```

**Key Activities:**
- Establish baseline metrics
- Identify improvement opportunities
- Prioritize based on business value
- Implement incrementally
- Measure and validate improvements
- Feed learnings back into process

## Mode Selection Guidelines

### Selection Criteria Matrix

| Criteria | Standard | Reverse Eng. | Lang Migration | Refactoring | POC | Emergency | Federal | Continuous Imp. |
|----------|----------|--------------|----------------|-------------|-----|-----------|---------|-----------------|
| **Requirements** | Clear | Unknown | Partial | Clear | Exploratory | Critical | Distributed | Incremental |
| **Domain** | Mature | Legacy | Partial | Mature | Unknown | Any | Varies | Evolving |
| **Time Pressure** | Normal | Normal | Normal | Normal | Time-boxed | Critical | Normal | Normal |
| **Risk Tolerance** | Low | Medium | Medium | Low | High | Very High | Low | Low |
| **Team Structure** | Co-located | Any | Any | Any | Small | Small | Distributed | Any |

### Decision Flowchart

```
START: Assess Project Context
    │
    ├─ Is this a production emergency?
    │   └─ YES ──► Emergency Mode
    │
    ├─ Is this exploration of unknown technology?
    │   └─ YES ──► POC Mode
    │
    ├─ Is this a legacy system with no documentation?
    │   └─ YES ──► Reverse Engineering Mode
    │
    ├─ Is this a language/technology migration?
    │   └─ YES ──► Language Migration Mode
    │
    ├─ Is this code quality improvement without behavior change?
    │   └─ YES ──► Refactoring Mode
    │
    ├─ Are teams distributed across organizations?
    │   └─ YES ──► Federal Mode
    │
    ├─ Is this incremental optimization?
    │   └─ YES ──► Continuous Improvement Mode
    │
    └─ Default ──► Standard Mode
```

## Implementation

### Mode Configuration Template

```yaml
# .aether/scenario-mode.yaml
scenario_mode:
  current_mode: "standard"  # or reverse-engineering, migration, etc.
  
  mode_config:
    standard:
      enabled_principles: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10]
      workflow: full_8_stage
      
    reverse_engineering:
      enabled_principles: [P0, P1, P3, P5, P6, P7, P8, P9, P10]
      exempt_principles: [P2, P4]
      workflow: reverse_engineering_workflow
      
    language_migration:
      enabled_principles: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10]
      workflow: migration_workflow
      
    refactoring:
      enabled_principles: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10]
      emphasis: [P6, P5]
      workflow: refactoring_workflow
      
    poc:
      enabled_principles: [P0, P1, P3, P5, P7, P8, P9, P10]
      exempt_principles: [P2, P4, P6]
      max_duration: "4 weeks"
      workflow: poc_workflow
      
    emergency:
      enabled_principles: [P0, P1, P3, P5, P7, P8, P9, P10]
      exempt_principles: [P2, P6]
      max_duration: "24 hours"
      workflow: emergency_workflow
      
    federal:
      enabled_principles: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10]
      emphasis: [P4, P8]
      workflow: federal_workflow
      
    continuous_improvement:
      enabled_principles: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10]
      emphasis: [P9, P1]
      workflow: continuous_improvement_workflow
```

### Mode Transition Rules

```yaml
mode_transitions:
  allowed:
    - from: "poc"
      to: "standard"
      condition: "go_decision"
      
    - from: "emergency"
      to: "standard"
      condition: "post_incident_complete"
      
    - from: "reverse_engineering"
      to: "standard"
      condition: "specifications_recovered"
      
    - from: "language_migration"
      to: "standard"
      condition: "migration_complete"
      
    - from: "refactoring"
      to: "standard"
      condition: "refactoring_complete"
      
    - from: "continuous_improvement"
      to: "standard"
      condition: "improvement_target_met"
  
  not_allowed:
    - from: "standard"
      to: "emergency"
      reason: "Emergency mode only for critical incidents"
      
    - from: "poc"
      to: "production"
      reason: "POC code must go through Standard Mode"
```

## Integration with Aether.go Methodology

### Stage Adaptations by Mode

Each mode may modify the standard 8-stage workflow:

| Mode | Stage Modifications |
|------|---------------------|
| **Standard** | Full 8 stages as defined |
| **Reverse Engineering** | Add Stage 0 (Code Analysis), modify Stages 1-2 |
| **Language Migration** | Add Stage 0 (Source Analysis), modify Stages 1-2 |
| **Refactoring** | Add Stage 0 (Assessment), emphasize Stage 5 |
| **POC** | Simplified stages, time-boxed, knowledge capture |
| **Emergency** | Compressed workflow, post-incident follow-up |
| **Federal** | Distributed specifications, parallel execution |
| **Continuous Improvement** | Metric-driven, recursive optimization focus |

### Constitutional Principle Application

| Mode | Exempt Principles | Emphasized Principles |
|------|-------------------|----------------------|
| **Standard** | None | All equal |
| **Reverse Engineering** | P2, P4 | P7, P9 |
| **Language Migration** | None | P4, P7 |
| **Refactoring** | None | P6, P5 |
| **POC** | P2, P4, P6 | P1, P5 |
| **Emergency** | P2, P6 | P8, P1 |
| **Federal** | None | P4, P8 |
| **Continuous Improvement** | None | P9, P1 |

## Quick Reference

### Mode Selection Checklist

- [ ] Is this a production emergency? → **Emergency Mode**
- [ ] Is this technology exploration? → **POC Mode**
- [ ] Is this legacy system maintenance? → **Reverse Engineering Mode**
- [ ] Is this language migration? → **Language Migration Mode**
- [ ] Is this pure refactoring? → **Refactoring Mode**
- [ ] Are teams distributed? → **Federal Mode**
- [ ] Is this incremental optimization? → **Continuous Improvement Mode**
- [ ] Default → **Standard Mode**

### Mode Characteristics Summary

| Mode | Duration | Risk | Quality Focus |
|------|----------|------|---------------|
| Standard | Normal | Low | Full compliance |
| Reverse Engineering | Extended | Medium | Understanding |
| Language Migration | Extended | Medium | Equivalence |
| Refactoring | Normal | Low | Maintainability |
| POC | 1-4 weeks | High | Learning |
| Emergency | < 24 hours | Very High | Restoration |
| Federal | Normal | Medium | Coordination |
| Continuous Improvement | Ongoing | Low | Incremental |
