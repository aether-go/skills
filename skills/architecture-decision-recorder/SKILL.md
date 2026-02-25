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

## Output Location

All ADR files are stored in the `.aether/docs/decisions/` directory:

```
.aether/docs/decisions/
├── INDEX.md                    # ADR index and log
├── ADR-001-microservices.md    # Individual ADR files
├── ADR-002-postgresql.md
└── ADR-003-react.md
```

## Implementation

### ADR File Naming Convention

ADR files follow the naming pattern: `ADR-{number}-{short-title}.md`

Examples:
- `ADR-001-microservices.md`
- `ADR-002-postgresql.md`
- `ADR-003-react.md`

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

The ADR index is maintained at `.aether/docs/decisions/INDEX.md`:

```markdown
# Architecture Decision Log

| ADR | Title | Date | Status |
|-----|-------|------|--------|
| [ADR-001](ADR-001-microservices.md) | Adopt microservices | 2026-01-15 | Accepted |
| [ADR-002](ADR-002-postgresql.md) | Use PostgreSQL | 2026-01-20 | Accepted |
| [ADR-003](ADR-003-react.md) | Adopt React | 2026-02-01 | Superseded by ADR-005 |
```

### Directory Creation

```python
from pathlib import Path

def ensure_adr_directory(base_path='.'):
    """Ensure .aether/docs/decisions/ directory exists."""
    adr_path = Path(base_path) / '.aether' / 'docs' / 'decisions'
    adr_path.mkdir(parents=True, exist_ok=True)
    return adr_path

def get_adr_path(adr_number, title, base_path='.'):
    """Generate ADR file path based on number and title."""
    adr_path = ensure_adr_directory(base_path)
    safe_title = title.lower().replace(' ', '-').replace('_', '-')[:30]
    return adr_path / f"ADR-{adr_number:03d}-{safe_title}.md"

def get_adr_index_path(base_path='.'):
    """Get path to ADR index file."""
    adr_path = ensure_adr_directory(base_path)
    return adr_path / 'INDEX.md'
```
