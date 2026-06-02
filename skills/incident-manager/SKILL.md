---
name: incident-manager
description: Use when managing production incidents with ITIL-aligned processes: detection, response, resolution, root cause analysis, and knowledge base updates. This skill unifies incident and problem management.
---

# Incident Manager

## Overview

The unified skill for managing production incidents and problems. This skill:
- Handles incident detection, classification, and response
- Conducts root cause analysis (RCA) via 5 Whys / Fishbone
- Manages known error database
- Captures lessons learned for skill library

**Replaces** (consolidated from 2 skills):
- `incident-management`
- `problem-management`

## When to Use

```
Production incident detected? ───────────────┐
                                              │
Need incident response playbook? ─────────────┤
                                              │
Conducting root cause analysis? ──────────────┼─► Use incident-manager
                                              │
Building known error database? ───────────────┘
```

## Incident Lifecycle

```
Detection
    │
    ▼
Logging & Classification
    │  - Severity (SEV-1, SEV-2, SEV-3, SEV-4)
    │  - Category (Performance, Security, Data, etc.)
    │  - Affected services
    ▼
Response (On-call Engineer)
    │  - Acknowledge within SLA
    │  - Investigate
    │  - Apply immediate fix or workaround
    ▼
Resolution
    │  - Service restored
    │  - Customer impact minimized
    ▼
Post-Incident Review
    │  - Root cause analysis (5 Whys / Fishbone)
    │  - Timeline reconstruction
    │  - Action items
    │  - Skill library update
    ▼
Closure
    │  - Document in known error database
    │  - Update runbooks
    │  - Implement permanent fix
    ▼
```

## Severity Levels

| Severity | Impact | Response Time | Escalation |
|----------|--------|---------------|------------|
| **SEV-1** | Service down, major customer impact | 15 min | Incident commander, execs |
| **SEV-2** | Degraded service, significant impact | 30 min | Tech lead, product |
| **SEV-3** | Minor degradation, limited impact | 2 hours | Team lead |
| **SEV-4** | Cosmetic / non-urgent | 1 business day | Standard backlog |

## Input Format

```yaml
incident_response:
  incident:
    id: "INC-2026-001"
    title: "Auth service returning 500 for all login attempts"
    detected_at: "2026-06-02T10:00:00Z"
    detected_by: "monitoring"
    severity: "SEV-1"
    category: "availability"
    affected_services: ["auth-service", "api-gateway"]
    customer_impact: "All login attempts fail; ~50K users affected"
  
  # Response
  responders:
    incident_commander: "alice@example.com"
    tech_lead: "bob@example.com"
    on_call: ["carol@example.com", "dave@example.com"]
  
  # Communication
  communication:
    channels: ["slack:#incidents", "statuspage"]
    update_frequency: "every 15 min during SEV-1"
    external_comms: "status page update"
  
  # War room
  war_room: "https://meet.example.com/incident-2026-001"
```

## Output Format

```yaml
incident_resolution:
  incident_id: "INC-2026-001"
  
  # Timeline
  timeline:
    - time: "10:00:00Z"
      event: "Detected: error rate spike in auth-service"
      actor: "monitoring"
    - time: "10:02:00Z"
      event: "On-call paged, acknowledged"
      actor: "carol"
    - time: "10:05:00Z"
      event: "War room opened"
      actor: "alice"
    - time: "10:15:00Z"
      event: "Root cause identified: DB connection pool exhausted"
      actor: "bob"
    - time: "10:18:00Z"
      event: "Workaround applied: restart auth-service"
      actor: "carol"
    - time: "10:20:00Z"
      event: "Service restored, monitoring"
      actor: "alice"
    - time: "10:45:00Z"
      event: "Resolved"
      actor: "alice"
    - time: "11:00:00Z"
      event: "Post-incident review scheduled"
      actor: "alice"
  
  # Root cause
  root_cause:
    description: "Database connection pool size was too small for recent traffic increase; pool exhaustion caused all auth requests to fail"
    
    five_whys:
      - why: "Auth service returned 500 errors"
        answer: "Database queries failed"
      - why: "Database queries failed"
        answer: "Connection pool exhausted"
      - why: "Connection pool exhausted"
        answer: "Pool size (10) insufficient for current load (45 concurrent)"
      - why: "Pool size too small"
        answer: "Not updated when traffic grew 3x last month"
      - why: "Not updated"
        answer: "No automated scaling or capacity review"
    
    contributing_factors:
      - "Recent traffic growth (3x) not reflected in capacity planning"
      - "No automated connection pool scaling"
      - "Alert threshold too lenient (error rate > 50% before alerting)"
  
  # Resolution
  resolution:
    immediate: "Restarted auth-service to clear stuck connections"
    permanent: "Increased pool size to 50, added auto-scaling"
    code_change: "PR #234 - Increase DB connection pool size"
  
  # Impact
  impact:
    duration_minutes: 20
    affected_users: 50000
    affected_requests: 200000
    revenue_impact_usd: 5000  # Estimated
  
  # Action items
  action_items:
    - owner: "bob"
      action: "Implement auto-scaling for DB connection pools"
      deadline: "2026-06-09"
      priority: "high"
    - owner: "carol"
      action: "Tighten alert thresholds (error rate > 5%)"
      deadline: "2026-06-04"
      priority: "medium"
    - owner: "alice"
      action: "Add capacity review to monthly checklist"
      deadline: "2026-06-16"
      priority: "medium"
  
  # Lessons learned
  lessons_learned:
    - "Capacity planning must be proactive, not reactive"
    - "Alert thresholds should be tighter for SEV-1 services"
    - "Connection pool size is a critical config, should be in code review"
  
  # Known error database
  known_error:
    id: "KE-001"
    title: "Auth service DB connection pool exhaustion"
    symptoms: "Auth service returns 500, error logs show 'connection pool timeout'"
    workaround: "Restart service to clear connections"
    permanent_fix: "PR #234 (deployed 2026-06-02)"
    reference_runbook: "https://wiki.example.com/runbooks/auth-pool-exhaustion"
  
  # Skill library updates
  skill_updates:
    - "Add pattern: 'Database connection pool sizing' to skill library"
    - "Update runbook: 'Auth service high error rate'"
```

## Root Cause Analysis Methods

### 5 Whys

```
Problem: Auth service down
Why? → DB queries failed
Why? → Connection pool exhausted
Why? → Pool too small (10 connections for 45 concurrent)
Why? → Not updated when traffic grew
Why? → No capacity review process
Root: Process gap, not technical
```

### Fishbone (Ishikawa) Diagram

```
                                Auth Service Down
                                       │
        ┌──────────────┬───────────────┼───────────────┬──────────────┐
        │              │               │               │              │
    People         Process          Tech            Environment    Data
        │              │               │               │              │
  No capacity    No review       Pool too        Traffic 3x      N/A
  planning       process         small           growth
  expertise
```

## Integration with Aether.go Methodology

- **Input from**: Monitoring alerts, user reports
- **Output to**:
  - `metrics-tracker` (MTTR, MTTD trends)
  - `skill-manager` (lessons learned as skills)
  - `deployment-orchestrator` (rollback if needed)
- **Part of**: Operations Layer
- **Principle alignment**:
  - **P14 Knowledge-Engine**: Known error database
  - **P13 Recursive-Optimization**: Lessons drive improvement
  - **P9 Test-First**: Characterization tests for fixes

## Migration Notes

This skill consolidates 2 previously separate skills:
- `incident-management` → Detection, response, resolution
- `problem-management` → RCA, known error database
