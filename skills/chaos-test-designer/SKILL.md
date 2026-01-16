---
name: chaos-test-designer
description: Use when designing chaos engineering experiments to test system resilience and fault tolerance
---

# Chaos Test Designer

## Overview
Design and implement chaos engineering experiments that inject realistic failures into production-like environments to validate system resilience, fault tolerance, and recovery capabilities.

## When to Use

```
Production-like environment? ───────────────┐
                                            │
Need to test resilience? ───────────────────┤
                                            ├─► Use chaos-test-designer
System has multiple dependencies? ──────────┤
                                            │
Designing fault injection tests? ───────────┘
```

Use when:
- Designing resilience testing for microservices
- Testing fault tolerance and recovery mechanisms
- Validating graceful degradation under failure
- Preparing for incident response scenarios
- Production readiness assessment
- Architecture includes circuit breakers, retries, fallbacks
- Want to prove system can handle failures

Don't use when:
- Writing unit tests (use TDD)
- Testing basic functionality (use SIT)
- Environment is not production-like
- Without monitoring/observability in place
- During critical production periods

## Core Pattern

### Chaos Engineering Maturity Model

```
Level 1: Manual Chaos (Manual failure injection)
    ↓
Level 2: Automated Experiments (Scheduled chaos)
    ↓
Level 3: Continuous Chaos (Always-on small failures)
    ↓
Level 4: Self-Healing Systems (Autonomous recovery)
```

### Before (No Chaos Testing)
```yaml
# Production incident: Database goes down
# What happens?
service_a: ❌ Crashes with unhandled exception
service_b: ❌ Hangs indefinitely waiting for DB
service_c: ❌ Floods logs with connection errors
user_experience: ❌ Complete outage for 15 minutes
```

### After (With Chaos Testing)
```yaml
# Chaos experiment: Inject database failure
# What happens?
service_a: ✅ Gracefully returns error with circuit breaker open
service_b: ✅ Retries 3x then degrades to cached data
service_c: ✅ Uses fallback service for critical operations
user_experience: ✅ Degraded but functional, no data loss

# Observability confirms:
# - Circuit breaker metrics show open state
# - Retry backoff working correctly
# - Fallback service handling load
# - User alerts triggered
# - Recovery completes when DB returns
```

## Quick Reference

| Failure Mode | Injection Method | Validation Points |
|--------------|------------------|------------------|
| **Pod Kill** | Kill container | Resilience, restart time |
| **Network Latency** | Add packet delay | Timeout handling, retries |
| **Network Loss** | Drop packets | Connection resilience |
| **CPU Stress** | High CPU load | Performance degradation |
| **Memory Leak** | Consume memory | OOM handling |
| **Disk Full** | Fill disk space | Graceful handling |
| **Dependency Down** | Block service connection | Circuit breaker, fallback |
| **DNS Failure** | Corrupt DNS resolution | Connection retry |
| **Certificate Expiry** | Use expired cert | Validation handling |

### Common Chaos Scenarios

| Scenario | Target | Severity | Validation |
|----------|--------|----------|------------|
| Database outage | Primary DB | High | Circuit breaker, retries, fallback |
| API rate limit | Downstream service | Medium | Rate limiting, queuing |
| Network partition | Service-to-service | High | Timeout, retry with exponential backoff |
| Memory pressure | Microservice | Medium | OOM killer, resource limits |
| Slow dependencies | All services | Low | Timeout handling |
| Disk full | Service with writes | Medium | Graceful degradation |

## Implementation

### Chaos Experiment Frameworks

#### LitmusChaos (Kubernetes)
```yaml
# litmus-experiment-db-failure.yaml
apiVersion: litmuschaos.io/v1alpha1
kind: ChaosEngine
metadata:
  name: db-failure-engine
  namespace: production
spec:
  engineState: 'active'
  appinfo:
    appns: 'production'
    applabel: 'app=order-service'
    appkind: 'deployment'
  chaosServiceAccount: litmus-admin
  components:
    - name: pod-kill
      chaoslib: litmus
      experiments:
        - name: pod-kill
          spec:
            components:
              env:
                - name: TOTAL_PODS_TO_KILL
                  value: '1'
                - name: PODS_AFFECTED_PERC
                  value: '50'
```

#### Chaos Mesh (Kubernetes)
```yaml
# chaos-experiment-network-delay.yaml
apiVersion: chaos-mesh.org/v1alpha1
kind: NetworkChaos
metadata:
  name: network-delay-order-service
  namespace: production
spec:
  action: delay
  mode: one
  selector:
    labelSelectors:
      app: inventory-service
  delay:
    latency: '300ms'
    jitter: '50ms'
    correlation: '25'
  direction: to
  target:
    selector:
      labelSelectors:
        app: order-service
```

#### Gremlin (Infrastructure)
```javascript
// Gremlin experiment: Latency injection
const experiment = {
  description: 'Inject 500ms latency into payment service',
  targets: [
    {
      type: 'ExactContainer',
      containerIds: ['payment-service-container-id']
    }
  ],
  attacks: [
    {
      type: 'Latency',
      parameters: {
        delay: 500,
        jitter: 100
      }
    }
  ]
};
```

#### AWS FIS (Fault Injection Simulator)
```json
{
  "description": "Inject CPU stress on EC2 instances",
  "targets": {
    "Instances": {
      "ResourceType": "aws:ec2:instance",
      "ResourceArns": ["arn:aws:ec2:us-east-1:123456789012:instance/i-12345"],
      "SelectionMode": "ALL"
    }
  },
  "actions": {
    "CPUStress": {
      "ActionId": "aws:fis:inject-cpu-stress",
      "Parameters": {
        "duration": "PT5M",
        "targetCpu": 80
      }
    }
  }
}
```

### Experiment Design Template

```markdown
## Chaos Experiment: [Name]

### Objective
[What resilience property are we testing?]

### Hypothesis
[What do we think will happen?]
Example: "Service will handle 50% pod failures with no user-facing errors"

### Baseline Metrics
[Collect metrics before experiment]
- Success rate: 99.9%
- P95 latency: 200ms
- Error rate: 0.1%
- Active requests: 1000

### Failure Injection
[What failure will we inject?]
- Type: Pod kill
- Scope: 50% of replicas
- Duration: 5 minutes

### Validation Criteria
[How do we know system behaved correctly?]
- Success rate stays > 95%
- P95 latency < 500ms
- No user-facing 5xx errors
- Circuit breaker opens and recovers

### Rollback Criteria
[When should we stop the experiment?]
- Success rate drops below 90%
- Latency > 2 seconds
- Error rate > 10%
- User complaints

### Observability
[What metrics will we monitor?]
- Request success rate
- Response time percentiles
- Circuit breaker state
- Retry attempts
- Fallback activations

### Learning
[What did we learn?]
- System recovered in 30 seconds
- Circuit breaker worked correctly
- Fallback service handled 30% of load
- Need to improve cold start time
```

### Example Experiments

#### Experiment 1: Database Outage
```yaml
# litmus-db-outage.yaml
apiVersion: litmuschaos.io/v1alpha1
kind: ChaosEngine
metadata:
  name: db-outage-engine
spec:
  engineState: 'active'
  appinfo:
    applabel: 'app=order-service'
  chaosServiceAccount: litmus-admin
  experiments:
    - name: pod-kill
      spec:
        components:
          - name: kill-db-pods
            selector:
              labelSelectors:
                app: mysql
            args:
              - name: TOTAL_PODS_TO_KILL
                value: '1'
```

**Validation:**
```bash
# Monitor circuit breaker metrics
curl http://localhost:9090/api/v1/query?query=circuit_breaker_state{service="order-service"}

# Verify fallback activation
curl http://localhost:9090/api/v1/query?query=fallback_requests_total{service="order-service"}

# Check user-facing error rate
curl http://localhost:9090/api/v1/query?query=http_requests_total{status=~"5.."}
```

#### Experiment 2: Network Latency
```javascript
// network-latency-experiment.js
const chaosExperiment = {
  experimentId: 'exp-order-service-latency',
  description: 'Inject 1 second latency to payment service',
  targetService: 'payment-service',
  injection: {
    type: 'network-latency',
    parameters: {
      latency: '1000ms',
      jitter: '200ms',
      correlation: '0.5'
    },
    scope: {
      type: 'service',
      filter: 'app=order-service -> app=payment-service'
    }
  },
  duration: '5m',
  validation: {
    metrics: [
      'http_request_duration_seconds{quantile="0.95"}',
      'http_requests_total{status=~"5.."}',
      'circuit_breaker_failures_total'
    ],
    thresholds: {
      'p95_latency': '2000ms',
      'error_rate': '5%',
      'circuit_breaker_open': 'false'
    }
  },
  rollback: {
    condition: 'error_rate > 10% || p95_latency > 5000ms',
    action: 'immediate'
  }
};
```

#### Experiment 3: Resource Exhaustion
```bash
#!/bin/bash
# stress-test.sh: Simulate memory pressure

# Target container
CONTAINER_ID="order-service-container"

# Simulate memory leak
docker exec $CONTAINER_ID stress-ng --vm 1 --vm-bytes 80% --vm-hang 0 --timeout 300s --metrics-brief

# Monitor response
while true; do
  timestamp=$(date +%s)
  p95_latency=$(curl -s "http://localhost:9090/api/v1/query?query=histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[1m]))" | jq -r '.data.result[0].value[1]')
  memory_usage=$(curl -s "http://localhost:9090/api/v1/query?query=container_memory_usage_bytes" | jq -r '.data.result[0].value[1]')

  echo "$timestamp,$p95_latency,$memory_usage" >> stress-test-results.csv
  sleep 5
done
```

### Monitoring and Validation

#### Prometheus Queries for Chaos
```promql
# Circuit breaker state
circuit_breaker_state{service="order-service"}

# Retry attempts
retry_attempts_total{service="order-service"}

# Fallback service usage
fallback_requests_total{service="order-service"}

# Error rate
rate(http_requests_total{status=~"5..",service="order-service"}[5m]) /
rate(http_requests_total{service="order-service"}[5m])

# Latency impact
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket{service="order-service"}[5m]))

# Pod restarts
kube_pod_container_status_restarts_total{pod=~"order-service-.*"}
```

#### Grafana Dashboard Alerts
```yaml
groups:
  - name: chaos_experiment_alerts
    rules:
      - alert: ChaosExperimentTooManyErrors
        expr: |
          rate(http_requests_total{status=~"5.."}[5m]) /
          rate(http_requests_total[5m]) > 0.1
        labels:
          severity: critical
        annotations:
          summary: "Chaos experiment causing high error rate"

      - alert: ChaosExperimentLatencyHigh
        expr: |
          histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 2
        labels:
          severity: warning
        annotations:
          summary: "Chaos experiment causing high latency"
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Running chaos in production without preparation | Unplanned outage | Start in staging, small blast radius |
| No monitoring/observability | Can't validate impact | Set up comprehensive metrics before chaos |
| No rollback plan | Experiment runs too long | Define clear stop criteria and rollback automation |
| Testing too aggressively | System completely fails | Start with small failures, increase gradually |
| No baseline metrics | Can't compare impact | Collect baseline before each experiment |
| Not sharing results | Team doesn't learn | Document findings, create runbooks |
| Chaos during critical periods | Business impact | Schedule off-peak times |

### Red Flags

- Running chaos without monitoring
- No rollback procedure defined
- Testing production without staging validation
- Experiments with 100% blast radius
- No hypothesis or learning objectives
- Chaos during high-traffic periods
- No incident response runbook ready

## Real-World Impact

**Before (No Chaos):**
- Production incident causes unexpected failures
- Recovery procedures untested
- Unknown resilience limits
- Incident response is reactive

**After (Chaos Engineering):**
- Failure scenarios tested regularly
- Proactive resilience improvements
- Clear system limits known
- Incident response automated
- 95% reduction in production incidents

**Result:** Teams confidently deploy knowing system resilience is tested and proven.

## Integration with Aether.go Methodology

### Chaos + BMAD Metrics
```
Business Goal → Resilience Metric → Chaos Experiment
```

Example:
- Business Goal: "99.9% uptime"
- BMAD Metric: "System recovery time < 2 minutes"
- Chaos Requirement: "Verify recovery within 2 minutes after DB outage"

### Chaos + Spec Tracing
Link chaos experiments to reliability specs:
```markdown
## Spec: REL-001 - Database Resilience

### Chaos Experiment: DB-Outage-001
- Hypothesis: System recovers within 2 minutes
- Test: Kill primary DB replica
- Validation: Success rate > 95% within 2 minutes
- Status: ✅ Passed (Recovery in 45 seconds)
```

### Chaos Maturity Checklist

```markdown
## Chaos Maturity Assessment

### Level 1: Manual Chaos (Initial)
- [ ] First chaos experiment run
- [ ] Basic monitoring in place
- [ ] Rollback procedure documented
- [ ] Results shared with team

### Level 2: Automated Experiments (Developing)
- [ ] Chaos experiments scheduled (weekly/monthly)
- [ ] Multiple failure modes tested
- [ ] Integration with CI/CD
- [ ] Automated rollback triggers

### Level 3: Continuous Chaos (Maturing)
- [ ] Always-on small failures
- [ ] Game days with team involvement
- [ ] Chaos as code in version control
- [ ] Resilience metrics tracked

### Level 4: Self-Healing (Advanced)
- [ ] Autonomous recovery verified
- [ ] Predictive failure prevention
- [ ] Chaos informs architecture decisions
- [ ] Organization-wide chaos culture
```

### Incident Response Practice

```markdown
## Chaos-Based Incident Drill

### Scenario: Database Outage
1. **Inject failure**: Kill database pod (50% replicas)
2. **Detect**: Team receives alert via monitoring
3. **Diagnose**: Use runbook to identify root cause
4. **Mitigate**: Activate fallback, scale up read replicas
5. **Recover**: Restore database service
6. **Post-mortem**: Document learning, update runbook

### Metrics Captured
- Detection time: 30 seconds
- Diagnosis time: 2 minutes
- Mitigation time: 1 minute
- Recovery time: 3 minutes
- Total impact: 6.5 minutes
- User-facing errors: 2% during recovery
```
