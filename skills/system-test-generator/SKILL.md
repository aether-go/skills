---
name: system-test-generator
description: Use when generating non-functional system tests for performance, security, reliability, and scalability validation at L2 system level
---

# System Test Generator

## Overview
Generate non-functional system tests that validate performance, security, reliability, and scalability attributes. Part of D4 Contract Derivation Domain, these tests operate at L2 to verify architecture-level quality attributes defined in NFR specifications.

## When to Use

```
NFR specifications defined? ───────────────────┐
                                              │
Need non-functional test coverage? ───────────┤
                                              ├─► Use system-test-generator
L3 -> L4 derivation (system attributes)? ─────┤
                                              │
Validating architecture decisions? ───────────┘
```

Use when:
- Validating non-functional requirements (NFRs)
- Testing System-Level attributes (L2)
- Verifying performance benchmarks
- Checking security controls
- Validating scalability limits

Don't use when:
- Only testing functional behavior (use unit/integration/e2e tests)
- NFRs are not yet defined (use nfr-analyzer first)
- Only validating component-level behavior (use other L4/L5 tests)

## Core Pattern

### System Test Coverage (1% of Test Pyramid)

```
Test Pyramid
    ├── L2 System Tests (1%) ← THIS SKILL
    ├── L3 E2E Tests (4%) - User journeys
    ├── L4 Integration Tests (15%) - Component协作
    ├── L4 Contract Tests (10%) - API契约
    └── L5 Unit Tests (70%) - Business logic
```

### System Test Categories

```
Non-Functional Requirements
    │
    ├── Performance
    │     ├── Response time (P50, P95, P99)
    │     ├── Throughput (req/sec)
    │     ├── Resource utilization
    │     └── Load handling
    │
    ├── Security
    │     ├── Authentication enforcement
    │     ├── Authorization boundaries
    │     ├── Data encryption
    │     └── Vulnerability scanning
    │
    ├── Reliability
    │     ├── MTTR (Mean Time To Recovery)
    │     ├── Availability targets
    │     ├── Fault tolerance
    │     └── Disaster recovery
    │
    └── Scalability
          ├── Horizontal scaling
          ├── Vertical scaling
          ├── Data partitioning
          └── Geographic distribution
```

### NFR Test Mapping

| NFR Category | Test Type | Metrics |
|--------------|-----------|---------|
| **Performance** | Load test, Stress test | Response time, TPS |
| **Security** | Penetration test, Scan | Vulnerabilities, CVEs |
| **Reliability** | Chaos test, Failover test | Uptime, MTTR |
| **Scalability** | Scaling test | Linear scaling ratio |

## Quick Reference

### When to Write System Tests

- NFR validation gates in CI/CD
- Pre-deployment verification
- Post-incident verification
- Architecture compliance check

### System Test Characteristics

| Aspect | Characteristics |
|--------|-----------------|
| **Execution** | Periodic (not per-commit) |
| **Duration** | Hours to days |
| **Environment** | Production-like |
| **Infrastructure** | Dedicated test environment |

## Implementation

### System Test Generator

```python
class SystemTestGenerator:
    def __init__(self, nfr_specifications):
        self.nfrs = nfr_specifications
        self.tests = []
        
    def generate_tests(self):
        """Generate system tests from NFR specifications."""
        
        for nfr in self.nfrs:
            if nfr.category == 'performance':
                self.tests.extend(self.generate_performance_tests(nfr))
            elif nfr.category == 'security':
                self.tests.extend(self.generate_security_tests(nfr))
            elif nfr.category == 'reliability':
                self.tests.extend(self.generate_reliability_tests(nfr))
            elif nfr.category == 'scalability':
                self.tests.extend(self.generate_scalability_tests(nfr))
                
        return self.tests
    
    def generate_performance_tests(self, nfr):
        """Generate performance test scenarios."""
        return [{
            'id': f"sys-perf-{nfr.id}",
            'category': 'performance',
            'test_type': nfr.test_type,  # load, stress, soak
            'target': nfr.threshold,
            'metrics': nfr.metrics
        }]
```

## Output Format

```yaml
system_test_suite:
  suite_id: "sys-20250424-001"
  framework: "k6"
  target_percentage: 1
  
  test_catalog:
    - id: "sys-perf-001"
      category: "performance"
      name: "API response time under load"
      nfr_source: "NFR-001"
      gwt:
        given: "System is under normal load"
        when: "1000 concurrent users access API"
        then: "P99 response time is under 200ms"
      test_config:
        type: "load"
        vus: 1000
        duration: "10m"
        thresholds:
          http_req_duration: "p99<=200"
          http_req_failed: "<1%"
          
    - id: "sys-sec-001"
      category: "security"
      name: "Authentication bypass prevention"
      nfr_source: "NFR-003"
      gwt:
        given: "Attacker attempts unauthorized access"
        when: "Invalid JWT token presented"
        then: "System returns 401 and logs incident"
      test_config:
        type: "security_scan"
        tools: ["owasp-zap", "nuclei"]
        
    - id: "sys-rel-001"
      category: "reliability"
      name: "Service failover validation"
      nfr_source: "NFR-004"
      gwt:
        given: "Primary service instance fails"
        when: "Health check detects failure"
        then: "Backup instance takes over within 30 seconds"
      test_config:
        type: "chaos"
        fault_injection: "kill_primary_instance"
        expected_recovery: "<30s"
```

## Integration with Aether.go Methodology

- **Input from**: nfr-analyzer (NFR specifications), architecture-decision-recorder (ADR)
- **Output to**: test-pyramid-validator (coverage validation)
- **Validates with**: chaos-test-designer (fault injection)
- **Part of**: D4 Contract Derivation Domain (L2 system attributes)
