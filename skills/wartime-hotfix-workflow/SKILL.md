---
name: wartime-hotfix-workflow
description: Use when managing production emergencies with two-phase process: immediate response (minutes) followed by post-incident normalization (24h). Implements incident command, on-call escalation, and battle rhythm.
---

# Wartime Hotfix Workflow

## Overview

The unified skill for managing production emergencies. This skill:
- Implements a two-phase process: immediate response + post-incident normalization
- Coordinates incident command structure
- Manages on-call escalation
- Ensures 24h normalization for permanent fix
- Updates skill library to prevent recurrence

**Used in scenarios**: Emergency Hotfix (Wartime Mode)

## When to Use

```
Production service down? ─────────────────────┐
                                              │
SEV-1 / SEV-2 incident? ──────────────────────┤
                                              │
Need war-room coordination? ─────────────────┼─► Use wartime-hotfix-workflow
                                              │
Post-incident normalization needed? ─────────┤
                                              │
Need battle rhythm playbook? ─────────────────┘
```

## Two-Phase Process

### Phase 1: Immediate Response (Minutes)

```
Detection (alert, user report, monitoring)
    │
    ▼
Triage (< 5 min)
    │  - Severity classification (SEV-1, SEV-2, etc.)
    │  - Acknowledge page
    │  - Initial assessment
    ▼
War Room (if SEV-1/SEV-2)
    │  - Incident commander
    │  - Tech lead
    │  - Communications lead
    │  - Scribe (timeline)
    ▼
Mitigation
    │  - Quick fix or workaround
    │  - Rollback if needed
    │  - Restore service
    ▼
Verification
    │  - Health checks pass
    │  - User impact resolved
    │  - Monitoring confirms stable
    ▼
Initial Notification
    │  - Status page update
    │  - Internal stakeholders
    │  - Customer communication (if needed)
```

### Phase 2: Post-Incident Normalization (Within 24h)

```
Service Restored (Phase 1 complete)
    │
    ▼
Retroactive Specification (within 24h)
    │  - Extract spec from fix
    │  - Document what was changed and why
    ▼
Characterization Tests
    │  - Lock fix behavior
    │  - Prevent regression
    │  - Add to test suite
    ▼
Root Cause Analysis
    │  - 5 Whys / Fishbone
    │  - Identify contributing factors
    ▼
Permanent Fix Plan
    │  - If quick fix was applied, plan permanent solution
    │  - Timeline for permanent fix
    │  - Resource allocation
    ▼
Skill Library Update
    │  - Add pattern to skill library
    │  - Update runbooks
    │  - Prevent recurrence
    ▼
Post-Incident Review
    │  - Blameless retro
    │  - Action items with owners
    │  - Process improvements
    ▼
Closure
    │  - Document in known error database
    │  - Share lessons learned
    │  - Update team documentation
```

## When to Use Each Phase

| Phase | Trigger | Deadline |
|-------|---------|----------|
| Phase 1 (Response) | Detection of SEV-1/SEV-2 | Within minutes |
| Phase 2 (Normalization) | After service restored | Within 24h |

## Core Pattern: Battle Rhythm

```
Time 0: Incident detected
    ├─ Page on-call (auto)
    ├─ Status page updated (auto)
    └─ Alert stakeholders

Time 5min: Acknowledge
    ├─ On-call acknowledges page
    └─ Initial severity assessment

Time 10min: War room (if SEV-1/2)
    ├─ Open dedicated channel (Slack/Zoom)
    ├─ Assign roles
    └─ Begin investigation

Time 15min: Status update #1
    └─ Internal stakeholders: "Investigating"

Time 30min: Status update #2
    └─ Internal + external (if customer-facing)

Time 60min: Status update #3
    └─ Update every 15-30 min during SEV-1

Time Until Mitigation: Continuous updates
    └─ Every 15 min during active incident

Mitigation: Service restored
    ├─ Verify with monitoring
    ├─ Status: "Monitoring"
    └─ Begin 24h clock for Phase 2

24h: Phase 2 complete
    ├─ Spec extracted
    ├─ Tests added
    ├─ RCA documented
    └─ Skill library updated
```

## Input Format

```yaml
wartime_response:
  incident:
    id: "INC-2026-001"
    title: "Auth service returning 500 for all login attempts"
    severity: "SEV-1"  # SEV-1 | SEV-2 | SEV-3 | SEV-4
    detected_at: "2026-06-02T10:00:00Z"
    detected_by: "monitoring"  # monitoring | user_report | internal_testing
    
  # Impact
  impact:
    services_affected: ["auth-service", "api-gateway"]
    users_affected_estimate: 50000
    revenue_impact_usd_per_hour: 5000
    customer_facing: true
  
  # Response
  response:
    incident_commander: "alice@example.com"
    tech_lead: "bob@example.com"
    on_call: ["carol@example.com", "dave@example.com"]
    war_room: "https://meet.example.com/incident-2026-001"
    communication_channel: "slack:#incidents"
  
  # Phase 2 configuration
  phase_2:
    deadline: "2026-06-03T10:00:00Z"  # 24h from detection
    required_actions:
      - "Extract specification from fix"
      - "Add characterization tests"
      - "Conduct RCA"
      - "Update skill library"
      - "Schedule post-incident review"
```

## Output Format

```yaml
wartime_response_result:
  incident_id: "INC-2026-001"
  
  # === Phase 1: Response ===
  phase_1:
    started_at: "2026-06-02T10:00:00Z"
    mitigation_at: "2026-06-02T10:20:00Z"
    duration_minutes: 20
    
    timeline:
      - {time: "10:00:00", event: "Detected", actor: "monitoring"}
      - {time: "10:02:00", event: "Acknowledged", actor: "carol"}
      - {time: "10:05:00", event: "War room opened", actor: "alice"}
      - {time: "10:15:00", event: "Root cause identified: DB pool exhausted", actor: "bob"}
      - {time: "10:18:00", event: "Workaround applied: restart service", actor: "carol"}
      - {time: "10:20:00", event: "Service restored, monitoring", actor: "alice"}
    
    mitigation: "Restarted auth-service to clear stuck DB connections"
    decision_maker: "alice (incident commander)"
    customer_communication: "Status page updated every 15 min"
  
  # === Phase 2: Normalization ===
  phase_2:
    deadline: "2026-06-03T10:00:00Z"
    started: true
    status: "in_progress"
    
    actions:
      - action: "Extract specification from fix"
        owner: "bob"
        status: "completed"
        output: "docs/specs/INC-2026-001-fix.md"
      
      - action: "Add characterization tests"
        owner: "carol"
        status: "completed"
        output: "tests/characterization/db_pool_test.go"
      
      - action: "Conduct RCA"
        owner: "alice"
        status: "in_progress"
        output: "docs/postmortem/INC-2026-001.md"
      
      - action: "Update skill library"
        owner: "alice"
        status: "pending"
        output: "skills/patterns/db-pool-sizing.md"
      
      - action: "Schedule post-incident review"
        owner: "alice"
        status: "pending"
        output: "calendar invite for 2026-06-04"
    
    root_cause_analysis:
      description: "DB connection pool size (10) too small for current load (45 concurrent)"
      five_whys: ["DB queries failed", "Pool exhausted", "Pool too small", "Not updated for traffic growth", "No capacity review process"]
      contributing_factors: ["No automated scaling", "Alert threshold too lenient"]
    
    permanent_fix:
      description: "Increase pool size to 50, add auto-scaling"
      code_change: "PR #234 (deployed)"
      follow_up_actions:
        - "Implement auto-scaling (PR #235, due 2026-06-09)"
        - "Tighten alert thresholds (due 2026-06-04)"
        - "Add capacity review to monthly checklist (due 2026-06-16)"
    
    skill_library_updates:
      - pattern: "Database connection pool sizing"
        added_to: "skill-manager"
        key_insight: "Pool size should auto-scale with traffic; alert on >80% utilization"
      
      - runbook: "Auth service high error rate"
        updated: "Added 'check pool utilization' as step 2"
    
    known_error_database:
      - id: "KE-001"
        title: "Auth service DB connection pool exhaustion"
        symptoms: "Auth service returns 500, 'connection pool timeout' in logs"
        workaround: "Restart service to clear connections"
        permanent_fix: "PR #234 (deployed 2026-06-02)"
        reference: "https://wiki.example.com/runbooks/auth-pool-exhaustion"
  
  # === Responsibility Matrix ===
  responsibility:
    exempted: ["Phase 1 process violations (no test-first, no detailed planning)"]
    accountable:
      - "Missed 24h normalization deadline"
      - "Recurrence of same defect"
      - "Failure to update skill library"
  
  # === Post-Incident Review ===
  post_incident_review:
    scheduled: "2026-06-04T10:00:00Z"
    attendees: ["alice", "bob", "carol", "dave", "tech-lead", "product-manager"]
    agenda:
      - "Timeline review"
      - "What went well"
      - "What could improve"
      - "Action items"
```

## Implementation Notes

### On-Call Escalation

```yaml
escalation_policy:
  primary: {responder: "primary-on-call", timeout: 5min}
  secondary: {responder: "secondary-on-call", timeout: 10min}
  tertiary: {responder: "team-lead", timeout: 15min}
  executive: {responder: "engineering-manager", timeout: 30min, condition: "SEV-1 only"}
```

### Battle Rhythm Cadence

| Severity | Update Frequency | Audience |
|----------|------------------|----------|
| SEV-1 | Every 15 min | Internal + external |
| SEV-2 | Every 30 min | Internal |
| SEV-3 | Every 2 hours | Internal |
| SEV-4 | Once | Internal |

### Phase 2 Enforcement

24h deadline enforced via:
- Automatic reminder at 18h
- Escalation to manager at 23h
- Incident report blocked from closure until complete

## Validation Rules

- ✅ Phase 1 complete within SLA (response + mitigation)
- ✅ Phase 2 complete within 24h
- ✅ Specification extracted from fix
- ✅ Characterization tests added
- ✅ RCA conducted
- ✅ Skill library updated
- ✅ Known error database updated

## Integration with Aether.go Methodology

- **Input from**: Incident detection (monitoring, user report)
- **Output to**:
  - `incident-manager` (full incident management)
  - `requirement-analyzer` (extracted specs)
  - `test-planner` (characterization tests)
  - `skill-manager` (lessons learned)
  - `constitution-validator` (P9 exemption during Phase 1)
- **Part of**: D6 Scenario Adaptation Domain (specialized workflow)
- **Principle alignment**:
  - **P0 Context-Adaptation**: Adjusts P9 (Test-First) to 0.4 during Phase 1
  - **P12 Human-AI-Boundary**: Human decision authority during emergency
  - **P14 Knowledge-Engine**: Updates skill library post-incident

## Migration Notes

- This skill is standalone and does not merge with another
- Used in wartime scenario detected by `scenario-engine`
- Constitutes the "Emergency" branch of the 10 scenarios

## Key Distinctions

- **`incident-manager`**: Full ITIL incident + problem management lifecycle (used for all incidents)
- **`wartime-hotfix-workflow`**: Specialized two-phase process for production emergencies with battle rhythm
- Use `incident-manager` for normal incident management; use `wartime-hotfix-workflow` when rapid response is critical
