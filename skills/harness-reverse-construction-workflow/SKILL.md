---
name: harness-reverse-construction-workflow
description: Use when reverse-engineering constraints and architecture from existing codebase through knowledge engine establishment and progressive constraint injection. Supports the Harness reverse construction scenario. Part of D6 Scenario Adaptation Domain.
---

# Harness Reverse Construction Workflow

## Overview
Reverse-engineer constraints and architecture from existing codebase through knowledge engine establishment (code-graph, repo-wiki) and progressive constraint injection. Supports understanding and refactoring legacy systems by extracting implicit constraints and making them explicit.

## When to Use

```
Legacy codebase to refactor? ────────────┐
                                         │
Need to extract implicit constraints? ───┤
                                         ├─► Use harness-reverse-construction-workflow
Knowledge engine from existing code? ────┤
                                         │
Progressive constraint injection? ───────┘
```

Use when:
- Reverse-engineering legacy codebase
- Need to extract implicit constraints and make them explicit
- Building knowledge engine (code-graph, repo-wiki) from existing code
- Progressive constraint injection into existing system

Don't use when:
- Greenfield development
- Codebase is already well-documented
- No refactoring is planned

## Core Pattern

### Reverse Construction Process

```
Existing Codebase
    |
    v
Code-Graph Analysis
    ├── Module dependencies
    ├── Interface mappings
    └── Data flows
    |
    v
Repo-Wiki Generation
    ├── Architecture overview
    ├── Design decisions
    └── Onboarding guides
    |
    v
Constraint Extraction
    ├── Implicit patterns
    ├── Coding standards
    └── Architectural rules
    |
    v
Progressive Constraint Injection
    ├── Load extracted constraints
    ├── Enable GATE-001
    └── Validate conformance
    |
    v
Refactored System
```

### Workflow Stages

1. **Code-Graph Establishment**: Analyze codebase structure and dependencies
2. **Repo-Wiki Generation**: Document architecture and design decisions
3. **Constraint Extraction**: Identify implicit constraints from code patterns
4. **Constraint Formalization**: Convert implicit constraints to executable rules
5. **Progressive Injection**: Gradually enforce constraints on new code
6. **Validation**: Verify constraint conformance

## Input Format

```yaml
harness_request:
  codebase:
    path: "/legacy-system"
    language: "java"
    lines_of_code: 150000
    modules: 25
  
  goals:
    - "Extract architecture constraints"
    - "Build code-graph for dependencies"
    - "Generate repo-wiki documentation"
    - "Enable progressive refactoring"
  
  constraints:
    extract_patterns: true
    extract_standards: true
    extract_dependencies: true
  
  output:
    code_graph_path: ".aether/code-graph/"
    repo_wiki_path: ".aether/repo-wiki/"
    constraints_path: ".aether/constraints/"
```

## Output Format

```yaml
harness_result:
  codebase: "/legacy-system"
  
  code_graph:
    status: established
    modules_analyzed: 25
    dependencies_mapped: 142
    interfaces_identified: 68
    output: ".aether/code-graph/"
  
  repo_wiki:
    status: generated
    pages_created: 15
    coverage: 0.82
    output: ".aether/repo-wiki/"
  
  constraints_extracted:
    - type: "dependency_rule"
      rule: "service-layer must not depend on controller-layer"
      source: "code-pattern-analysis"
    - type: "naming_convention"
      rule: "repository classes must end with Repository"
      source: "code-pattern-analysis"
    - type: "transaction_boundary"
      rule: "database operations must be within @Transactional"
      source: "code-pattern-analysis"
  
  constraints_formalized:
    path: ".aether/constraints/extracted.yml"
    rules_count: 23
  
  progressive_injection:
    phase: 1
    new_code_constraints: enabled
    legacy_code_grace_period: "30 days"
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: scenario-detector, reverse-engineering-suite
- **Output to**: ConstitutionGuardian, WorkflowOrchestrator
- **Part of**: D6 Scenario Adaptation Domain

## Examples

### Example 1: Legacy Java System
```yaml
codebase: "legacy-java-monolith"
result:
  code_graph: {modules: 25, dependencies: 142}
  repo_wiki: {pages: 15, coverage: 0.82}
  constraints: {extracted: 23, formalized: 23}
action: "progressive_injection_enabled"
```

### Example 2: PHP to Go Migration
```yaml
codebase: "legacy-php-application"
result:
  code_graph: {modules: 12, dependencies: 45}
  repo_wiki: {pages: 8, coverage: 0.75}
  constraints: {extracted: 15, formalized: 15}
action: "migration_constraints_established"
```
