---
name: mode-selector
description: Use when managing three-mode switching (norm-driven, emergent exploration, intent-driven) and adapting constitutional principle strength accordingly. Part of D6 Scenario Adaptation Domain and D8 Meta-Capability Domain.
---

# Mode Selector

## Overview
Manage three-mode switching (norm-driven, emergent exploration, intent-driven) and adapt constitutional principle strength accordingly. Supports WorkflowOrchestrator's ModeManager by providing mode recommendations and principle strength configurations.

## When to Use

```
Need to switch development mode? ────────┐
                                         │
Scenario mode recommendation? ───────────┤
                                         ├─► Use mode-selector
Constitutional strength adjustment? ─────┤
                                         │
WorkflowOrchestrator mode change? ───────┘
```

Use when:
- Need to switch between norm-driven, emergent exploration, or intent-driven modes
- Scenario mode recommendation is needed
- Constitutional principle strength needs adjustment
- WorkflowOrchestrator requests mode change

Don't use when:
- Mode is already determined and stable
- Only single principle needs adjustment
- No mode switching is required

## Core Pattern

### Mode Selection Process

```
Project Context
    ├── Current Mode
    ├── Scenario Detection
    ├── Team Maturity
    ├── Delivery Pressure
    └── Intent Clarity
         |
         v
    Mode Recommendation
         |
         ├── Norm-Driven
         ├── Emergent Exploration
         └── Intent-Driven
```

### Mode Definitions

| Mode | Description | Use Case | Principle Strength |
|------|-------------|----------|-------------------|
| **Norm-Driven** | Full constitutional principles, standard workflow | Production systems, regulated industries | P1-P15 at full strength |
| **Emergent Exploration** | Reduced planning, rapid validation | POC, innovation, research | P2, P4 reduced; P1 maintained |
| **Intent-Driven** | Reduced inference detail, enhanced intent layering | AI-native build, rapid prototyping | P2, P6 reduced; P11 enhanced |

### Principle Strength Configuration

```yaml
principle_strength:
  norm_driven:
    P1: 1.0  # Purpose-Driven
    P2: 1.0  # Planning-First
    P4: 1.0  # Interface-First
    P6: 1.0  # Test-First
    P11: 1.0 # Intent-Hierarchization
    P13: 1.0 # Constraint-Mechanization
  
  emergent_exploration:
    P1: 0.8
    P2: 0.3  # Reduced planning
    P4: 0.3  # Reduced interface requirements
    P6: 0.5  # Reduced test requirements
    P11: 0.7
    P13: 0.5
  
  intent_driven:
    P1: 1.0
    P2: 0.6  # Reduced planning
    P4: 0.8
    P6: 0.7  # Reduced test requirements
    P11: 1.2 # Enhanced intent layering
    P13: 1.1 # Enhanced constraint mechanization
```

## Input Format

```yaml
mode_request:
  current_mode: "norm_driven"
  project_context:
    type: "greenfield"
    phase: "development"
    team_maturity: "high"
    delivery_pressure: "medium"
    intent_clarity: "high"
  
  scenario:
    detected: "ai_native_build"
    confidence: 0.85
  
  trigger:
    type: "user_command"  # user_command | scenario_change | constitution_override
    command: "switch to intent-driven mode"
```

## Output Format

```yaml
mode_result:
  previous_mode: "norm_driven"
  recommended_mode: "intent_driven"
  
  reasoning:
    - factor: "ai_native_build scenario"
      weight: 0.4
      evidence: "Project is AI-native build with clear intent"
    - factor: "high intent clarity"
      weight: 0.3
      evidence: "Business intent well-defined and layered"
    - factor: "medium delivery pressure"
      weight: 0.2
      evidence: "Some time constraints but not critical"
    - factor: "high team maturity"
      weight: 0.1
      evidence: "Team experienced with intent-driven development"
  
  principle_adjustments:
    P2: {from: 1.0, to: 0.6, reason: "Reduced planning for rapid iteration"}
    P6: {from: 1.0, to: 0.7, reason: "Reduced test threshold for speed"}
    P11: {from: 1.0, to: 1.2, reason: "Enhanced intent layering"}
    P13: {from: 1.0, to: 1.1, reason: "Enhanced constraint mechanization"}
  
  gate_strategy: "adaptive"
  generation_preference: "intent_aligned"
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: scenario-detector, WorkflowOrchestrator, ConstitutionGuardian
- **Output to**: WorkflowOrchestrator, ConstitutionGuardian
- **Part of**: D6 Scenario Adaptation Domain, D8 Meta-Capability Domain

## Examples

### Example 1: Norm-Driven Mode
```yaml
scenario: "Banking system production"
mode: norm_driven
principle_strength: {all at 1.0}
gate_strategy: strict
reason: "Regulated industry, high compliance requirements"
```

### Example 2: Intent-Driven Mode
```yaml
scenario: "AI-native MVP build"
mode: intent_driven
principle_strength: {P2: 0.6, P6: 0.7, P11: 1.2}
gate_strategy: adaptive
reason: "Rapid prototyping with clear business intent"
```
