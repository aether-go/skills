---
name: deployment-orchestrator
description: Use when orchestrating complex deployments (canary, blue-green, rolling), managing releases, handling rollbacks, and enforcing change management. This skill unifies deployment operations and replaces deployment-orchestrator, rollback-manager, release-manager, and change-management.
---

# Deployment Orchestrator

## Overview

The unified skill for deployment orchestration, release management, and rollback handling. This skill:
- Orchestrates deployments with multiple strategies (canary, blue-green, rolling)
- Manages release planning and coordination
- Handles automated rollback on failure
- Enforces change management (CAB approval for production)

**Replaces** (consolidated from 4 skills):
- `deployment-orchestrator`
- `rollback-manager`
- `release-manager`
- `change-management`

## When to Use

```
Deploying to production? ────────────────────┐
                                            │
Need canary / blue-green / rolling? ────────┤
                                            ├─► Use deployment-orchestrator
Managing release coordination? ─────────────┤
                                            │
Need automated rollback strategy? ───────────┘
```

## Deployment Strategies

| Strategy | Use Case | Risk Level | Rollback Speed |
|----------|----------|------------|----------------|
| **Rolling** | Standard updates, low risk | Low | Medium (5-15 min) |
| **Blue-Green** | Major releases, instant switchover | Medium | Instant (switch LB) |
| **Canary** | High-risk changes, gradual rollout | Low initially | Easy (reduce % to 0) |
| **Recreate** | Dev/staging only | High (downtime) | N/A (redeploy old) |

## Core Pattern

```
Release Plan
    │
    ├──► [1] Pre-Deployment
    │         ├── Run all tests in staging
    │         ├── Verify health checks
    │         ├── Snapshot state (DB, config)
    │         └── Notify stakeholders
    │
    ├──► [2] Strategy Selection
    │         ├── Risk-based: canary for high-risk
    │         ├── Speed-based: blue-green for instant
    │         └── Cost-based: rolling for resource-constrained
    │
    ├──► [3] Execute Deployment
    │         ├── Phase 1: Shadow (no traffic) — for canary
    │         ├── Phase 2: 1% traffic
    │         ├── Phase 3: 10% traffic
    │         ├── Phase 4: 50% traffic
    │         └── Phase 5: 100% traffic
    │
    ├──► [4] Health Verification
    │         ├── Error rate threshold (< 0.1%)
    │         ├── Latency threshold (p95 < budget)
    │         ├── Business metrics stable
    │         └── No new critical alerts
    │
    ├──► [5] Rollback (if needed)
    │         ├── Detect failure
    │         ├── Automatic rollback trigger
    │         ├── Restore previous version
    │         └── Notify team
    │
    └──► [6] Post-Deployment
              ├── Monitor for 24-48h
              ├── Capture metrics
              ├── Update release notes
              └── Document lessons learned
```

## Input Format

```yaml
deployment_request:
  service: "auth-service"
  version: "v1.2.3"
  environment: "production"  # staging | production
  
  # Deployment strategy
  strategy: "canary"  # canary | blue-green | rolling | recreate
  
  # Canary phases
  canary_phases:
    - {traffic_percent: 1, duration: "5m", success_criteria: {error_rate: 0.001, p95_ms: 200}}
    - {traffic_percent: 10, duration: "10m", success_criteria: {error_rate: 0.001, p95_ms: 200}}
    - {traffic_percent: 50, duration: "15m", success_criteria: {error_rate: 0.001, p95_ms: 200}}
    - {traffic_percent: 100, duration: "0", success_criteria: {error_rate: 0.001, p95_ms: 200}}
  
  # Rollback configuration
  rollback:
    automatic: true
    triggers:
      - "error_rate > 0.01"
      - "p95_latency > 500ms"
      - "critical_alert"
    strategy: "blue-green"  # Fastest rollback
  
  # Change management
  change:
    cab_approval_required: true
    change_id: "CHG-12345"
    risk_level: "medium"  # low | medium | high
    rollback_plan_documented: true
  
  # Release coordination
  release:
    release_manager: "alice@example.com"
    stakeholders: ["tech-lead@example.com", "product@example.com"]
    communication_channels: ["slack:#deploys", "email"]
    
  # Pre/post hooks
  pre_hooks:
    - "run-migrations"
    - "warm-cache"
  post_hooks:
    - "purge-cdn"
    - "smoke-test"
  
  # Monitoring
  monitoring:
    metrics_to_watch: ["error_rate", "p95_latency", "rps", "cpu", "memory"]
    alert_channels: ["pagerduty", "slack"]
    monitoring_duration_hours: 48
```

## Output Format

```yaml
deployment_result:
  service: "auth-service"
  version: "v1.2.3"
  environment: "production"
  strategy: "canary"
  status: "completed"  # in_progress | completed | failed | rolled_back
  timestamp: "2026-06-02T10:00:00Z"
  
  # Phases executed
  phases:
    - phase: 1
      name: "Shadow deployment"
      traffic: 0
      duration: "2m"
      result: "success"
    - phase: 2
      name: "1% canary"
      traffic: 1
      duration: "5m"
      result: "success"
      metrics: {error_rate: 0.0005, p95_ms: 145}
    - phase: 3
      name: "10% canary"
      traffic: 10
      duration: "10m"
      result: "success"
      metrics: {error_rate: 0.0007, p95_ms: 155}
    - phase: 4
      name: "50% canary"
      traffic: 50
      duration: "15m"
      result: "success"
      metrics: {error_rate: 0.0006, p95_ms: 148}
    - phase: 5
      name: "100% rollout"
      traffic: 100
      duration: "0"
      result: "success"
  
  # Verification
  health_checks:
    error_rate: {current: 0.0006, threshold: 0.001, status: "OK"}
    p95_latency: {current: 148, threshold: 200, status: "OK"}
    business_metrics: {status: "stable"}
    alerts: {critical: 0, warning: 1}
  
  # Rollback
  rollback: 
    triggered: false
    plan: "Available: blue-green switchover (~30s)"
  
  # Release artifacts
  artifacts:
    release_notes: "https://wiki.example.com/releases/v1.2.3"
    deployment_log: "https://logs.example.com/deploys/v1.2.3"
    rollback_runbook: "https://wiki.example.com/runbooks/rollback-auth"
  
  # Post-deployment
  monitoring:
    duration_hours: 48
    metrics_url: "https://grafana.example.com/d/auth-service"
  
  next_action: "Monitor for 48h; collect metrics for retrospective"
```

## Implementation Notes

### Canary Strategy Implementation

```python
def execute_canary(deployment: dict) -> dict:
    """Execute canary deployment with progressive traffic shift."""
    for phase in deployment["canary_phases"]:
        # Shift traffic
        traffic_shifter.set_traffic(deployment["service"], phase["traffic_percent"])
        
        # Wait for observation period
        time.sleep(parse_duration(phase["duration"]))
        
        # Verify health
        metrics = collect_metrics(deployment["service"], phase["duration"])
        if not meets_criteria(metrics, phase["success_criteria"]):
            # Trigger automatic rollback
            return trigger_rollback(deployment, reason=metrics)
    
    return {"status": "completed", "phases": deployment["canary_phases"]}
```

### Automatic Rollback

```python
def should_rollback(metrics: dict, triggers: list) -> bool:
    """Check if any rollback trigger is met."""
    for trigger in triggers:
        if trigger == "error_rate > 0.01" and metrics["error_rate"] > 0.01:
            return True
        if trigger == "p95_latency > 500ms" and metrics["p95_ms"] > 500:
            return True
        if trigger == "critical_alert" and has_critical_alert(metrics):
            return True
    return False

def execute_rollback(deployment: dict) -> dict:
    """Execute rollback to previous version."""
    if deployment["rollback"]["strategy"] == "blue-green":
        return switch_load_balancer_to_previous(deployment)
    elif deployment["rollback"]["strategy"] == "rolling":
        return roll_back_pods_progressively(deployment)
    # ...
```

## Validation Rules

- ✅ All tests pass in staging before production
- ✅ Rollback plan documented and tested
- ✅ Health checks pass at each canary phase
- ✅ Monitoring configured for post-deployment
- ✅ Stakeholders notified

## Integration with Aether.go Methodology

- **Input from**:
  - `code-generator` (built artifacts)
  - `test-planner` (test results)
- **Output to**:
  - `metrics-tracker` (deployment metrics)
  - `incident-manager` (if rollback occurs)
- **Part of**: Operations Layer
- **Principle alignment**:
  - **P11 NFR-Built-in**: Performance budget enforced as gate
  - **P12 Human-AI-Boundary**: CAB approval for production
  - **P13 Recursive-Optimization**: Metrics feedback for improvement

## Migration Notes

This skill consolidates 4 previously separate skills:
- `deployment-orchestrator` → Core orchestration
- `rollback-manager` → Rollback handling
- `release-manager` → Release planning
- `change-management` → CAB approval workflow
