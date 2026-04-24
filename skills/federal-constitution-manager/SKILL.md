---
name: federal-constitution-manager
description: Use when managing distributed multi-team development with global constitution and team-specific local constitutions enforced by CDC contracts
---

# Federal Constitution Manager

## Overview
Manage federal-style constitution for distributed multi-team development. Global constitution applies to all teams; teams maintain local constitutions for sub-domain specifics. Consumer-Driven Contracts (CDC) enforce interface consistency across team boundaries.

## When to Use

```
Scenario detected: federal? ──────────────────┐
                                              │
Multi-team distributed development? ───────────┤
                                              ├─► Use federal-constitution-manager
Interface consistency required? ───────────────┤
                                              │
Distributed architecture? ──────────────────────┘
```

Use when:
- scenario-detector identifies "federal" mode
- Large feature requiring multiple teams
- Team boundaries define service boundaries
- Interface contracts critical

## Core Pattern

### Federal Constitution Structure

```
Global Constitution (All Teams)
    ├── Core principles (P0-P10)
    ├── Cross-team integration rules
    ├── Shared quality standards
    └── Interoperability requirements

Team A Constitution (Sub-domain)
    ├── Local implementation choices
    ├── Team-specific practices
    └── Internal architecture

Team B Constitution (Sub-domain)
    └── ...

Team C Constitution (Sub-domain)
    └── ...
```

### Consumer-Driven Contract (CDC)

```
Team A (Provider)
    └── Implements API contract
        │
        ▼
Team B (Consumer) defines expectations
    └── "I expect X when I call Y"
        │
        ▼
CDC validates compatibility
    └── Pact or similar framework
```

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: federal)
- **Output to**: contract-test-generator (CDC tests)
- **Part of**: D6 Scenario Adaptation Domain
