---
name: strangler-pattern-suite
description: Use when incrementally replacing system components using the strangler fig pattern with anti-corruption layer for gradual architecture migration
---

# Strangler Pattern Suite

## Overview
Execute strangler fig pattern for incremental system replacement. Wraps legacy system with anti-corruption layer, gradually redirects functionality to new implementation while maintaining interface compatibility. Used for architecture upgrades (e.g., monolith→microservices) without big-bang rewrites.

## When to Use

```
Scenario detected: refactoring? ────────────────┐
                                              │
Architecture upgrade needed? ──────────────────┤
                                              ├─► Use strangler-pattern-suite
Incremental replacement preferred? ────────────┤
                                              │
Same technology stack? ───────────────────────┘
```

Use when:
- scenario-detector identifies "refactoring" mode
- Architecture upgrade (monolith→microservices, etc.)
- Incremental replacement reduces risk
- Same technology stack maintained

## Core Pattern

### Strangler Fig Process

```
Existing System (Strangled)
    │
    ├── Step 1: Identify bounded context
    │     └── Map domain boundaries
    │
    ├── Step 2: Create anti-corruption layer
    │     └── New service with old interface
    │
    ├── Step 3: Incremental traffic switch
    │     ├── 1% → validate
    │     ├── 10% → monitor
    │     ├── 50% → stabilize
    │     └── 100% → complete
    │
    ├── Step 4: Remove legacy implementation
    │
    └── Repeat for next context
```

### Key Artifacts

| Artifact | Purpose |
|----------|---------|
| Anti-Corruption Layer | Translates old→new interfaces |
| Traffic Splitter | Routes requests to old/new |
| Composite View | Combines old+new responses |
| Decommision Queue | Tracks legacy removal |

## Integration with Aether.go Methodology

- **Input from**: scenario-detector (mode: refactoring)
- **Output to**: Deployment orchestration
- **Part of**: D6 Scenario Adaptation Domain
