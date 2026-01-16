---
name: architecture-decision-recorder
description: Use when recording architecture decisions with business justification and alternatives analysis
---

# Architecture Decision Recorder

## Overview
Create Architecture Decision Records (ADRs) that document significant architectural decisions, their business rationale, alternatives considered, and trade-offs. Ensures decision traceability and knowledge sharing.

## When to Use

```
Significant architecture decision? ────────┐
                                            │
Major technical change proposed? ────────────┤
                                            ├─► Use architecture-decision-recorder
Need to justify technical choice? ───────────┤
                                            │
Documenting architecture history? ──────────┘
```

Use when:
- Choosing technology stack or frameworks
- Designing major system components
- Changing deployment architecture
- Adopting new patterns or practices
- Integrating third-party services
- Making decisions affecting multiple teams

Don't use when:
- Daily coding decisions (use code reviews)
- Minor refactoring
- Temporary workarounds
- Already-documented decisions

## Core Pattern

### ADR Format

```markdown
# ADR-001: Adopt Microservices Architecture

## Status
Accepted

## Context
Current monolith is becoming unmanageable, deployment takes hours, and scaling is difficult.

## Decision
Migrate to microservices architecture with containerized services orchestrated by Kubernetes.

## Consequences
**Positive:**
- Independent deployments
- Better scalability
- Technology diversity

**Negative:**
- Increased operational complexity
- Distributed system challenges
- Network latency

## Alternatives Considered
1. **Modular monolith** - Easier, but doesn't solve deployment/scaling
2. **Serverless** - Good for scale, but vendor lock-in and cold starts

## Related Decisions
- ADR-005: Adopt Kubernetes
- ADR-010: Service mesh adoption
```

## Implementation

### ADR Template

```markdown
# ADR-<number>: <Title>

## Date
<YYYY-MM-DD>

## Status
<Proposed|Accepted|Rejected|Superseded|Deprecated>

## Context
<Current situation and problem to solve>

## Decision
<What was decided and why>

## Consequences
**Positive:**
- <Benefit 1>
- <Benefit 2>

**Negative:**
- <Drawback 1>
- <Drawback 2>

## Alternatives Considered
1. <Alternative 1>
   - <Pros>
   - <Cons>

2. <Alternative 2>
   - <Pros>
   - <Cons>

## Related Decisions
- [ADR-<number>](link)
- [ADR-<number>](link)

## References
- <Documentation, blog posts, RFCs>
```

### ADR Index

```markdown
# Architecture Decision Log

| ADR | Title | Date | Status |
|-----|-------|------|--------|
| [ADR-001](adr-001.md) | Adopt microservices | 2024-01-15 | Accepted |
| [ADR-002](adr-002.md) | Use PostgreSQL | 2024-01-20 | Accepted |
| [ADR-003](adr-003.md) | Adopt React | 2024-02-01 | Superseded by ADR-005 |
```
