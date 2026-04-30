---
name: code-graph-analyzer
description: Use when analyzing codebase structure, dependencies, and relationships to build or update the code-graph knowledge engine component. Part of D7 Knowledge Engine Domain.
---

# Code-Graph Analyzer

## Overview
Analyze codebase structure, dependencies, and relationships to build or update the code-graph knowledge engine component. Provides dependency chains, module boundaries, interface mappings, and complexity metrics for context enrichment.

## When to Use

```
Need to analyze codebase structure? ─────┐
                                         │
Building code-graph? ────────────────────┤
                                         ├─► Use code-graph-analyzer
Updating dependency mappings? ───────────┤
                                         │
Context enrichment needed? ──────────────┘
```

Use when:
- Need to analyze codebase structure and dependencies
- Building or updating code-graph knowledge engine
- Updating dependency mappings after changes
- Context enrichment for code generation or review

Don't use when:
- Codebase is trivial (< 100 lines)
- Only single file analysis is needed
- No dependency information is required

## Core Pattern

### Analysis Process

```
Codebase
    ├── Module Structure
    ├── Import/Dependency Analysis
    ├── Interface Identification
    ├── Data Flow Mapping
    └── Complexity Calculation
         |
         v
    Code-Graph Update
         |
         v
    Context Enrichment
```

### Analysis Dimensions

| Dimension | Description | Output |
|-----------|-------------|--------|
| **Module Structure** | Directory structure, package organization | Module hierarchy |
| **Dependencies** | Import relationships, external libraries | Dependency graph |
| **Interfaces** | Public APIs, service boundaries | Interface catalog |
| **Data Flows** | Request/response paths, state transitions | Data flow diagrams |
| **Complexity** | Cyclomatic complexity, cognitive complexity | Complexity scores |

## Input Format

```yaml
analysis_request:
  codebase:
    path: "/project/src"
    language: "go"
    exclude_patterns: ["vendor/", "*_test.go"]
  
  scope:
    modules: ["api", "service", "repository"]
    depth: "full"  # full | shallow | module_only
  
  output:
    format: "yaml"
    path: ".aether/code-graph/"
```

## Output Format

```yaml
code_graph:
  version: "1.0"
  last_updated: "2026-04-30T10:00:00Z"
  
  modules:
    - name: "api"
      path: "src/api"
      files: 12
      interfaces:
        - "UserHandler"
        - "OrderHandler"
      dependencies:
        - "service"
      
    - name: "service"
      path: "src/service"
      files: 8
      interfaces:
        - "UserService"
        - "OrderService"
      dependencies:
        - "repository"
        - "external/stripe"
      
    - name: "repository"
      path: "src/repository"
      files: 6
      interfaces:
        - "UserRepository"
      dependencies: []
  
  dependencies:
    - from: "api"
      to: "service"
      type: "internal"
    - from: "service"
      to: "repository"
      type: "internal"
    - from: "service"
      to: "external/stripe"
      type: "external"
  
  interfaces:
    - name: "UserService"
      module: "service"
      methods:
        - "CreateUser"
        - "GetUser"
        - "UpdateUser"
      consumers: ["api"]
  
  complexity:
    average: 5.2
    max: 12
    hotspots:
      - file: "src/service/order.go"
        score: 12
        recommendation: "Consider decomposition"
  
  coverage: 0.85
```

## Integration with Aether.go Methodology

- **Input from**: ContextManager, harness-reverse-construction-workflow
- **Output to**: ContextManager, repo-wiki-generator
- **Part of**: D7 Knowledge Engine Domain

## Examples

### Example 1: Go Microservices
```yaml
codebase: "go-microservices"
modules: 8
dependencies: 24
interfaces: 15
complexity: {average: 4.5, max: 9}
output: ".aether/code-graph/"
```

### Example 2: Legacy Monolith
```yaml
codebase: "legacy-monolith"
modules: 25
dependencies: 142
interfaces: 68
complexity: {average: 8.2, max: 25}
hotspots: ["src/billing/calculation.go", "src/reporting/generator.go"]
output: ".aether/code-graph/"
```
