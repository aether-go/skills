---
name: system-quality-tracker
description: Use when tracking system quality metrics including completeness, coverage, correctness, and satisfaction. Part of D8 Meta-Capability Domain for dual-track optimization.
---

# System Quality Tracker

## Overview
Track system quality metrics including completeness, coverage, correctness, and satisfaction. Part of dual-track optimization (system quality + AI collaboration effectiveness), provides data for RecursiveOptimizer's system quality track.

## When to Use

```
Need to track system quality? ───────────┐
                                         │
Dual-track optimization active? ─────────┤
                                         ├─► Use system-quality-tracker
Quality metrics reporting? ──────────────┤
                                         │
RecursiveOptimizer needs data? ──────────┘
```

Use when:
- Need to track system quality metrics
- Dual-track optimization is active
- Quality metrics reporting is needed
- RecursiveOptimizer needs system quality data

Don't use when:
- Only AI effectiveness metrics are needed
- Quality tracking is not a priority
- System is not yet implemented

## Core Pattern

### Tracking Process

```
System Artifacts
    ├── Completeness Check
    ├── Coverage Analysis
    ├── Correctness Verification
    └── Satisfaction Survey
         |
         v
    Quality Metrics
         |
         v
    Optimization Input
```

### Quality Dimensions

| Dimension | Metric | Target | Measurement |
|-----------|--------|--------|-------------|
| **Completeness** | Requirements coverage | > 95% | Traceability matrix |
| **Coverage** | Test coverage | > 80% | Code coverage tools |
| **Correctness** | Defect density | < 0.1/KLOC | Bug tracking |
| **Satisfaction** | User satisfaction | > 4.0/5.0 | Surveys |
| **Performance** | Response time | < budget | Monitoring |
| **Security** | Vulnerability count | 0 critical | Scanning tools |

## Input Format

```yaml
tracking_request:
  system:
    name: "Order Service"
    version: "1.2.0"
  
  artifacts:
    requirements: "docs/requirements.md"
    tests: "src/.../*_test.go"
    code: "src/"
    
  metrics:
    - completeness
    - coverage
    - correctness
    - satisfaction
    - performance
    - security
```

## Output Format

```yaml
quality_report:
  system: "Order Service"
  version: "1.2.0"
  timestamp: "2026-04-30T10:00:00Z"
  
  metrics:
    completeness:
      score: 0.96
      target: 0.95
      status: passed
      details: "48/50 requirements traced"
    
    coverage:
      score: 0.82
      target: 0.80
      status: passed
      details: "Line coverage: 82%, Branch coverage: 78%"
    
    correctness:
      score: 0.95
      target: 0.95
      status: passed
      details: "3 defects found, 0 critical"
    
    satisfaction:
      score: 4.2
      target: 4.0
      status: passed
      details: "NPS: 42"
    
    performance:
      score: 0.88
      target: 0.90
      status: warning
      details: "P95: 180ms (budget: 150ms)"
    
    security:
      score: 1.0
      target: 1.0
      status: passed
      details: "0 critical, 0 high vulnerabilities"
  
  overall_score: 0.92
  trend: improving
  
  recommendations:
    - "Optimize database query in OrderRepository.GetByID"
    - "Add integration tests for payment flow"
```

## Integration with Aether.go Methodology

- **Input from**: RecursiveOptimizer, test suites, monitoring
- **Output to**: RecursiveOptimizer, WorkflowOrchestrator
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: Microservice Quality
```yaml
system: "User Service"
metrics: {completeness: 0.96, coverage: 0.82, correctness: 0.95}
overall: 0.92
recommendations: ["Add edge case tests", "Optimize query performance"]
```

### Example 2: Legacy System
```yaml
system: "Billing Engine"
metrics: {completeness: 0.75, coverage: 0.45, correctness: 0.80}
overall: 0.72
recommendations: ["Increase test coverage", "Document requirements"]
```
