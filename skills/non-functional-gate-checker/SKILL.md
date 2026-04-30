---
name: non-functional-gate-checker
description: Use when verifying non-functional requirements including performance budgets, security scans, and compliance checks. Implements P14 Non-Functional-Attributes-Built-in Principle. Part of D8 Meta-Capability Domain.
---

# Non-Functional Gate Checker

## Overview
Verify non-functional requirements including performance budgets, security scans, and compliance checks. Implements P14 Non-Functional-Attributes-Built-in Principle, ensuring NFRs are defined and verified before code enters production.

## When to Use

```
NFRs defined? ───────────────────────────┐
                                         │
Need to verify performance? ─────────────┤
                                         ├─► Use non-functional-gate-checker
Security scan required? ─────────────────┤
                                         │
Compliance check needed? ────────────────┘
```

Use when:
- Non-functional requirements are defined
- Need to verify performance budgets
- Security scan is required
- Compliance check is needed
- P14 compliance verification is needed

Don't use when:
- No NFRs are defined
- Only functional testing is needed
- System is not yet implemented

## Core Pattern

### Gate Check Process

```
System + NFR Definitions
    ├── Performance Budget Check
    ├── Security Scan
    ├── Compliance Verification
    └── Availability Assessment
         |
         v
    NFR Gate Result
         |
         ├── ALL PASS → Proceed
         ├── WARNING → Proceed with notes
         └── FAIL → Block
```

### NFR Dimensions

| Dimension | Check | Target | Tool |
|-----------|-------|--------|------|
| **Performance** | Response time, throughput | Within budget | Benchmarking |
| **Security** | Vulnerabilities, secrets | 0 critical | SAST/DAST |
| **Compliance** | GDPR, SOC2, etc. | Compliant | Compliance checks |
| **Availability** | Uptime, failover | > 99.9% | Monitoring |
| **Scalability** | Load handling | Within capacity | Load testing |
| **Maintainability** | Code complexity, documentation | Within limits | Static analysis |

## Input Format

```yaml
nfr_request:
  system:
    name: "Order Service"
    version: "1.2.0"
  
  nfr_definitions:
    performance:
      response_time_p95_ms: 200
      throughput_rps: 1000
    
    security:
      critical_vulnerabilities: 0
      high_vulnerabilities: 0
    
    compliance:
      gdpr: true
      soc2: true
  
  artifacts:
    code: "src/"
    tests: "src/.../*_test.go"
    deployment: "k8s/"
```

## Output Format

```yaml
nfr_report:
  system: "Order Service"
  version: "1.2.0"
  timestamp: "2026-04-30T10:00:00Z"
  
  checks:
    performance:
      status: passed
      metrics:
        response_time_p95_ms: 180
        throughput_rps: 1200
      details: "Within budget"
    
    security:
      status: passed
      metrics:
        critical_vulnerabilities: 0
        high_vulnerabilities: 0
        medium_vulnerabilities: 2
      details: "2 medium vulnerabilities, non-critical"
    
    compliance:
      status: passed
      metrics:
        gdpr_compliant: true
        soc2_compliant: true
      details: "All checks passed"
    
    availability:
      status: warning
      metrics:
        uptime_30d: 0.995
        failover_tested: false
      details: "Failover not yet tested"
    
    scalability:
      status: passed
      metrics:
        max_load_rps: 1500
        capacity_utilization: 0.67
      details: "Within capacity limits"
    
    maintainability:
      status: passed
      metrics:
        average_complexity: 5.2
        documentation_coverage: 0.85
      details: "Within acceptable limits"
  
  overall_status: warning
  action: proceed_with_notes
  
  warnings:
    - "Failover testing not completed"
    - "2 medium security vulnerabilities to address"
```

## Integration with Aether.go Methodology

- **Input from**: ConstitutionGuardian, P14 checks
- **Output to**: ConstitutionGuardian, WorkflowOrchestrator
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: All Passed
```yaml
system: "User Service"
checks: {performance: passed, security: passed, compliance: passed}
overall: passed
action: proceed
```

### Example 2: With Warnings
```yaml
system: "Payment Service"
checks: {performance: passed, security: warning, compliance: passed}
overall: warning
warnings: ["High vulnerability in dependency", "Failover untested"]
action: proceed_with_notes
```
