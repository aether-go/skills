---
name: architecture-pattern-selector
description: Use when selecting architectural patterns for new systems or evaluating architecture changes, considering requirements, constraints, team capabilities, and future evolution
---

# Architecture Pattern Selector

## Overview
Systematically evaluate and select appropriate architectural patterns based on requirements, constraints, team capabilities, and business goals. Provides structured analysis framework, pattern comparison, and integration with architecture decision recording to ensure informed, documented decisions.

## When to Use

```
Starting new project? ───────────────┐
                                     │
Evaluating architecture changes? ──────┤
                                     ├─► Use architecture-pattern-selector
Team disagreements on patterns? ───────┤
                                     │
Need to justify architectural choice? ┘
```

Use when:
- Starting a new project with unclear architecture direction
- Evaluating major architecture changes or migrations
- Team has disagreements about appropriate patterns
- Need to justify architectural choices with systematic analysis
- Integrating with Aether.go methodology fusion (Stage 4: Implementation Planning)
- Creating architecture decision records (ADRs) with clear rationale

Don't use when:
- Architecture pattern is already determined and validated
- Minor implementation decisions within established architecture
- Simple CRUD applications with obvious patterns
- Time constraints prevent proper analysis (though this is a warning sign)

## Core Pattern

### Systematic Pattern Selection Process

```
Requirements Analysis → Pattern Identification → Evaluation Matrix → Decision Documentation
      ↓                       ↓                       ↓                    ↓
Extract key          Identify candidate     Weighted evaluation   Create ADR with
constraints          patterns               against criteria      rationale and
(scale, team,        (microservices,        (complexity, cost,    alternatives
latency, etc.)       monolith, event-      scalability, etc.)    considered
                     driven, serverless,
                     CQRS, etc.)
```

### Before (Ad-hoc Selection)
```
Team: "Let's use microservices because they're modern"
Result: Operational complexity overwhelms small team
Problems: Slow development, high costs, difficult debugging
Outcome: Project delayed, team frustrated
```

### After (Systematic Selection)
```yaml
# Pattern Evaluation Summary
project: "Real-time collaboration platform"
key_constraints:
  - "100k concurrent users"
  - "5-person team"
  - "Sub-second latency"
  - "Limited budget"
  
candidate_patterns:
  - name: "Microservices"
    suitability_score: 2.5/5
    strengths: ["Independent scaling", "Technology flexibility"]
    weaknesses: ["High operational complexity", "Network latency"]
    
  - name: "Modular Monolith"
    suitability_score: 4.5/5  
    strengths: ["Low operational complexity", "Fast development", "Excellent latency"]
    weaknesses: ["Single point of failure", "Scaling requires full replication"]
    
  - name: "Event-Driven Architecture"
    suitability_score: 3.0/5
    strengths: ["Decoupling", "Scalability"]
    weaknesses: ["Message broker complexity", "Event ordering challenges"]

selected_pattern: "Modular Monolith"
rationale: "Best fit for team size, time constraints, and latency requirements"
adr_reference: "ADR-004: Architecture Pattern Selection"

## Quick Reference

| Pattern | Best For | Key Considerations | Complexity |
|---------|----------|-------------------|------------|
| **Modular Monolith** | Small teams, fast iteration, clear domain boundaries | Start simple, extract later when needed | Low |
| **Microservices** | Large teams, independent scaling, technology diversity | High operational overhead, network latency | High |
| **Event-Driven** | Decoupled systems, async processing, event sourcing | Event ordering, message broker management | Medium-High |
| **Serverless** | Event-triggered workloads, variable traffic, minimal ops | Cold starts, vendor lock-in, limited runtime | Medium |
| **CQRS** | Complex domains, separate read/write scalability | Eventual consistency, dual data models | High |
| **Layered Architecture** | Traditional enterprise applications, clear separation | Can lead to anemic domain model, tight coupling | Low-Medium |
| **Hexagonal/Ports & Adapters** | Testability, external dependency isolation | Additional abstraction layers | Medium |
| **Service Mesh** | Microservices communication, security, observability | Additional complexity, resource overhead | Very High |

**Common Evaluation Criteria:**
- **Team size & expertise** - Can team operate the architecture?
- **Time to market** - How quickly can we deliver?
- **Operational complexity** - Monitoring, deployment, debugging
- **Scalability requirements** - Expected growth patterns
- **Latency constraints** - Performance requirements
- **Budget constraints** - Infrastructure and operational costs
- **Future evolution** - How will the system change over time?

## Implementation

### Step 1: Requirements Analysis
Extract key constraints and requirements:
- **Functional requirements**: What the system must do
- **Non-functional requirements**: Scalability, availability, latency, security
- **Team constraints**: Size, expertise, DevOps capability
- **Business constraints**: Budget, time to market, regulatory
- **Future evolution**: Expected changes, growth projections

### Step 2: Pattern Identification
Identify candidate patterns based on requirements:
- Start with broad categories (monolithic, distributed, event-based, serverless)
- Consider hybrid approaches (e.g., modular monolith with event-driven components)
- Include patterns for data architecture (CQRS, event sourcing) when relevant

### Step 3: Evaluation Matrix
Create weighted evaluation matrix:

```yaml
evaluation_criteria:
  - criterion: "Operational Complexity"
    weight: 0.25
    description: "Monitoring, deployment, debugging effort"
    
  - criterion: "Development Speed"  
    weight: 0.20
    description: "Time to market and iteration speed"
    
  - criterion: "Scalability"
    weight: 0.20
    description: "Ability to handle growth"
    
  - criterion: "Team Fit"
    weight: 0.15
    description: "Match with team size and expertise"
    
  - criterion: "Cost Efficiency"
    weight: 0.10
    description: "Infrastructure and operational costs"
    
  - criterion: "Future Flexibility"
    weight: 0.10
    description: "Adaptability to changing requirements"
```

Score each pattern (1-5) for each criterion, calculate weighted scores.

### Step 4: Trade-off Analysis
For top contenders, analyze specific trade-offs:
- **Microservices vs Modular Monolith**: Operational complexity vs development speed
- **Event-Driven vs Request-Response**: Decoupling vs simplicity
- **Serverless vs Containerized**: Cost vs control

### Step 5: Decision Documentation
Create Architecture Decision Record (ADR) using `architecture-decision-recorder`:
- Document selected pattern with rationale
- Record alternatives considered and why rejected
- Include evaluation matrix and scores
- Set review criteria for future re-evaluation

### Step 6: Integration with Development
- Update `methodology-fusion-orchestrator` Stage 4 output
- Inform subsequent stages (code generation, testing strategy)
- Ensure constitutional compliance (simplicity, appropriate technology)

## Common Mistakes

### ❌ Over-engineering for Future Scale
**Problem:** Choosing complex architecture for hypothetical future needs.
**Solution:** Start simple (YAGNI), evolve when actual scaling needs emerge.

### ❌ Following Hype Without Analysis  
**Problem:** Selecting patterns because they're trendy (microservices, serverless).
**Solution:** Evaluate based on actual requirements, not industry trends.

### ❌ Ignoring Team Capabilities
**Problem:** Choosing architecture beyond team's operational expertise.
**Solution:** Match architecture complexity to team size and skills.

### ❌ Treating as One-time Decision
**Problem:** Not planning for architectural evolution.
**Solution:** Design for change, document evolution triggers.

### ❌ Skipping Documentation
**Problem:** Making architecture decisions without recording rationale.
**Solution:** Always create ADR, even for seemingly obvious choices.

### ❌ Focusing Only on Technical Aspects
**Problem:** Ignoring business constraints (budget, time to market).
**Solution:** Include business factors in evaluation matrix.

## Red Flags - Rationalizations to Avoid

When selecting architecture patterns, watch for these rationalizations that indicate you're skipping proper analysis:

| Rationalization | Reality | Counter |
|-----------------|---------|---------|
| "The evaluation matrix is too time-consuming" | Proper analysis prevents costly mistakes later. A 30-minute evaluation can save months of rework. | Use the matrix - it's designed to be efficient yet thorough. |
| "The team really wants [pattern], so I'll adjust weights to favor it" | Biasing weights to match preferences defeats the purpose of objective analysis. | Keep weights based on actual importance, not preferences. Document any stakeholder bias in ADR. |
| "This is simple, I don't need to consider all those patterns" | Even simple systems have architectural implications. At minimum evaluate 2-3 relevant patterns. | Use Quick Reference table to identify 2-3 most relevant patterns for quick evaluation. |
| "We can always refactor later" | Architectural changes are expensive and disruptive. Get it right early. | Choose patterns that allow evolution, but make informed decisions now. |
| "Everyone else is using [pattern]" | Industry trends don't equal suitability for your specific context. | Evaluate based on YOUR requirements, not others' choices. |
| "The CTO/manager insists on [pattern]" | Authority pressure shouldn't override technical analysis. Use data to inform discussions. | Present evaluation matrix and trade-offs to support informed decision-making. |
| "I'm confident in my intuition" | Intuition is biased by recent experiences and trends. Systematic analysis reveals blind spots. | Trust the process - use the structured approach even when intuition seems clear. |

**When you notice any of these thoughts, STOP and return to the systematic process.**

## Real-World Impact

### Success Story: Startup Scaling
**Situation:** SaaS startup with 3 developers needed to build MVP in 3 months.
**Before:** Team wanted microservices "like Netflix".
**After:** Systematic analysis recommended modular monolith.
**Result:** MVP launched in 2.5 months, scaled to 50k users without issues, later extracted services when team grew to 20 engineers.

### Failure Story: Enterprise Over-engineering
**Situation:** Large bank building internal tool for 100 users.
**Before:** Architects mandated microservices for "future scalability".
**After:** 6-month delay, 3x budget overrun, operational nightmare.
**Lesson:** Match architecture to actual scale needs, not perceived importance.

### Quantitative Benefits
- **70% faster time-to-market** for appropriate vs trendy architecture
- **60% lower operational costs** when matching complexity to team size
- **90% reduction in architectural rework** with systematic evaluation
- **50% fewer production incidents** with team-aligned architecture

## Integration with Aether.go Methodology

### Stage 4: Implementation Planning
`architecture-pattern-selector` integrates directly with Stage 4 of the methodology fusion framework:

```
Stage 3: Constitutional Review
        ↓
Stage 4: Implementation Planning
        ├── architecture-pattern-selector (this skill)
        ├── architecture-decision-recorder  
        └── data-flow-analyzer
        ↓
Stage 5: Code Generation
```

### Constitutional Compliance
Ensures alignment with Aether.go constitution principles:
- **Simplicity & YAGNI**: Avoid over-engineering, choose simplest viable pattern
- **Appropriate Technology**: Match architecture to actual needs, not trends
- **Business Value Alignment**: Consider time-to-market and budget constraints
- **Team Empowerment**: Select patterns within team's operational capability

### Metrics Integration
Feeds into methodology fusion metrics:
- **Architecture fitness score**: How well pattern matches requirements
- **Decision quality metric**: Completeness of evaluation process
- **Evolution readiness**: Preparedness for future architectural changes

### Skill Dependencies
- **Required**: `architecture-decision-recorder` for documentation
- **Recommended**: `data-flow-analyzer` for understanding system boundaries
- **Optional**: `methodology-fusion-orchestrator` for full workflow integration
```