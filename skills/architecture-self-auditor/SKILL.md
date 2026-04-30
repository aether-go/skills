---
name: architecture-self-auditor
description: Use when auditing the overall architecture for completeness, consistency, and compliance with methodology principles. Part of D8 Meta-Capability Domain.
---

# Architecture Self-Auditor

## Overview
Audit the overall architecture for completeness, consistency, and compliance with methodology principles. Part of D8 Meta-Capability Domain, provides comprehensive assessment of system architecture against Aether methodology requirements.

## When to Use

```
Architecture review needed? ─────────────┐
                                         │
Methodology compliance check? ───────────┤
                                         ├─► Use architecture-self-auditor
System audit required? ──────────────────┤
                                         │
Periodic health check? ──────────────────┘
```

Use when:
- Architecture review is needed
- Methodology compliance check is required
- System audit is required
- Periodic health check is scheduled

Don't use when:
- Only code review is needed
- Architecture is not yet defined
- Only single component needs review

## Core Pattern

### Audit Process

```
System Architecture
    ├── Completeness Check
    ├── Consistency Check
    ├── Compliance Check
    └── Performance Check
         |
         v
    Audit Report
         |
         v
    Improvement Plan
```

### Audit Dimensions

| Dimension | Description | Checks |
|-----------|-------------|--------|
| **Completeness** | All required components present | Layer coverage, skill coverage |
| **Consistency** | Components work together consistently | Interface alignment, data flow |
| **Compliance** | Adherence to methodology principles | P1-P15 compliance |
| **Performance** | System performance characteristics | Response time, throughput |
| **Scalability** | Ability to handle growth | Load capacity, extensibility |
| **Maintainability** | Ease of maintenance | Documentation, test coverage |

## Input Format

```yaml
audit_request:
  system:
    name: "Aether Platform"
    version: "3.0"
  
  architecture:
    layers: ["L1", "L2", "L3", "L4", "L4.5", "L5"]
    domains: ["D1", "D2", "D3", "D4", "D4.5", "D5", "D6", "D7", "D8"]
    principles: ["P1", "P2", "P3", "P4", "P5", "P6", "P7", "P8", "P9", "P10", "P11", "P12", "P13", "P14", "P15"]
  
  artifacts:
    code: "src/"
    tests: "src/.../*_test.go"
    docs: "docs/"
    config: ".aether/"
```

## Output Format

```yaml
audit_report:
  system: "Aether Platform"
  version: "3.0"
  timestamp: "2026-04-30T10:00:00Z"
  
  summary:
    overall_score: 0.88
    status: passed
    issues: 3
    warnings: 5
  
  dimensions:
    completeness:
      score: 0.92
      status: passed
      details: "All layers present, L4.5 recently added"
      issues: []
    
    consistency:
      score: 0.85
      status: passed
      details: "Interfaces aligned, minor data flow issues"
      issues:
        - "Data flow between L4 and L4.5 not fully documented"
    
    compliance:
      score: 0.90
      status: passed
      details: "P1-P15 all supported"
      issues:
        - "P15 knowledge engine coverage at 78%, target 80%"
    
    performance:
      score: 0.82
      status: warning
      details: "Response times within budget"
      issues:
        - "P95 response time: 195ms (budget: 200ms)"
    
    scalability:
      score: 0.88
      status: passed
      details: "Current load at 67% capacity"
      issues: []
    
    maintainability:
      score: 0.90
      status: passed
      details: "Documentation coverage: 85%"
      issues: []
  
  improvement_plan:
    - priority: medium
      action: "Document L4 to L4.5 data flow"
      owner: "architecture-team"
    
    - priority: low
      action: "Increase repo-wiki coverage to 80%"
      owner: "documentation-team"
    
    - priority: medium
      action: "Optimize response time to < 180ms"
      owner: "performance-team"
  
  next_audit: "2026-07-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: SkillLibraryCurator, system-quality-tracker
- **Output to**: WorkflowOrchestrator, RecursiveOptimizer
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: Healthy Architecture
```yaml
system: "Aether Platform"
overall: 0.92
status: passed
issues: 1
improvements: ["Minor documentation gaps"]
```

### Example 2: Needs Improvement
```yaml
system: "Legacy Integration"
overall: 0.72
status: warning
issues: 5
improvements: ["Add L4.5 support", "Improve test coverage", "Update documentation"]
```
