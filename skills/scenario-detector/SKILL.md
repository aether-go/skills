---
name: scenario-detector
description: Use when detecting the appropriate development scenario mode (standard, reverse_engineering, language_migration, refactoring, poc, emergency, federal, continuous_improvement) based on project context
---

# Scenario Detector

## Overview
Detect the appropriate development scenario mode based on project context, constraints, and goals. Supports P0: Context-Adaptation Principle by dynamically selecting the most suitable scenario mode for the current project situation.

## When to Use

```
Starting new project or phase? ──────────┐
                                         │
Uncertain which scenario mode to use? ───┤
                                         ├─► Use scenario-detector
Project context has changed? ────────────┤
                                         │
Need scenario mode recommendation? ──────┘
```

Use when:
- Starting a new project and need to determine scenario mode
- Project context has changed and mode may need adjustment
- Need scenario mode recommendation with justification
- Following P0 context-adaptation principle
- Preparing for constitution-guardian scenario mode selection

Don't use when:
- Scenario mode is already determined and validated
- Only switching between existing modes
- Project context is stable and mode is working

## Core Pattern

### Scenario Mode Detection

```
Project Context Input
    ├── Project Type (greenfield, brownfield, legacy)
    ├── Constraints (time, budget, resources)
    ├── Goals (speed, quality, innovation)
    ├── Team Structure (single, distributed, multi-team)
    └── Risk Profile (low, medium, high)
         |
         v
    Scenario Detector
         |
         v
Recommended Scenario Mode
    ├── standard
    ├── reverse_engineering
    ├── language_migration
    ├── refactoring
    ├── poc
    ├── emergency
    ├── federal
    └── continuous_improvement
```

### Scenario Mode Definitions

| Mode | Description | When to Use | Key Characteristics |
|------|-------------|-------------|---------------------|
| **standard** | Standard development | New project with clear requirements | Full principles, standard workflow |
| **reverse_engineering** | Legacy system analysis | Understanding existing system | Reduced planning, focus on documentation |
| **language_migration** | Technology stack migration | Moving to new language/framework | Parallel implementation, strangler pattern |
| **refactoring** | System restructuring | Improving existing codebase | Strangler pattern, incremental changes |
| **poc** | Proof of concept | Validating new technology/approach | Reduced principles, rapid validation |
| **emergency** | Emergency production fix | Critical bug fix | Wartime mode, minimal process |
| **federal** | Multi-team distributed | Large organization, multiple teams | Enhanced coordination, interface contracts |
| **continuous_improvement** | Ongoing optimization | Existing system enhancement | Focus on metrics, iterative improvement |

### Decision Matrix

```
Project Type:
├── Greenfield ────────────────────→ standard, poc
├── Brownfield ────────────────────→ refactoring, language_migration
├── Legacy ────────────────────────→ reverse_engineering, refactoring
└── Emergency ─────────────────────→ emergency

Constraints:
├── Tight deadline (< 2 weeks) ────→ emergency, poc
├── Limited budget ────────────────→ standard, continuous_improvement
├── Regulatory requirements ───────→ standard, federal
└── High risk ─────────────────────→ standard, poc

Goals:
├── Speed to market ───────────────→ poc, emergency
├── Quality first ─────────────────→ standard, federal
├── Innovation ────────────────────→ poc, standard
├── Cost reduction ────────────────→ refactoring, continuous_improvement
└── Risk mitigation ───────────────→ standard, federal

Team Structure:
├── Single team ───────────────────→ standard, poc
├── Distributed ───────────────────→ federal
├── Multi-team ────────────────────→ federal
└── External vendors ──────────────→ federal
```

### Before (Without Scenario Detection)
```yaml
project:
  type: "legacy_system"
  constraints: {deadline: "2 months", budget: "limited"}
  goals: ["modernize", "reduce_cost"]
  
approach:
  mode: "standard"  # Wrong mode for legacy system
  
result:
  - Excessive planning for unknown system
  - Insufficient documentation of legacy code
  - Migration plan doesn't account for dependencies
  - Team frustrated with rigid process
```

### After (With Scenario Detection)
```yaml
project:
  type: "legacy_system"
  constraints: {deadline: "2 months", budget: "limited"}
  goals: ["modernize", "reduce_cost"]
  
scenario_detection:
  detected_mode: "reverse_engineering"
  confidence: 0.92
  rationale:
    - "Legacy system requires understanding before modification"
    - "Limited budget favors documentation over immediate rewrite"
    - "2-month timeline insufficient for full migration"
    
  recommended_transition:
    phase_1: "reverse_engineering"  # Months 1-2: Document and understand
    phase_2: "refactoring"          # Month 3+: Incremental improvement
    phase_3: "standard"             # Month 6+: Full methodology
    
approach:
  mode: "reverse_engineering"
  
result:
  - Systematic documentation of legacy code
  - Clear understanding of dependencies
  - Realistic migration plan
  - Team confidence in approach
```

## Quick Reference

### Scenario Mode Selection Flowchart

```
Is this an emergency production issue?
├── YES ───────────────────────────→ emergency
└── NO
    Is this a new technology/approach validation?
    ├── YES ───────────────────────→ poc
    └── NO
        Is this a legacy system?
        ├── YES ───────────────────→ reverse_engineering
        └── NO
            Is this a technology migration?
            ├── YES ───────────────→ language_migration
            └── NO
                Is this a multi-team project?
                ├── YES ───────────→ federal
                └── NO
                    Is this system improvement?
                    ├── YES ───────→ refactoring or continuous_improvement
                    └── NO ────────→ standard
```

### Mode-Specific Principle Adjustments

| Mode | P2 (Planning) | P4 (Interface) | P5 (Dependencies) | P6 (Tests) |
|------|---------------|----------------|-------------------|------------|
| **standard** | Full | Full | <= 5 core | Full TDD |
| **reverse_engineering** | Reduced | N/A | Document existing | Existing tests |
| **language_migration** | Parallel | Critical | New stack | Migration tests |
| **refactoring** | Incremental | Maintain | Reduce | Regression tests |
| **poc** | Minimal | Minimal | Minimal | Smoke tests |
| **emergency** | Skip | Minimal | Existing | Post-fix tests |
| **federal** | Enhanced | Critical | Team-specific | Contract tests |
| **continuous_improvement** | Iterative | Maintain | Optimize | Metrics-driven |

## Implementation

### Detection Algorithm

```python
class ScenarioDetector:
    def __init__(self, project_context):
        self.context = project_context
        self.scenarios = {
            'standard': 0,
            'reverse_engineering': 0,
            'language_migration': 0,
            'refactoring': 0,
            'poc': 0,
            'emergency': 0,
            'federal': 0,
            'continuous_improvement': 0
        }
        
    def detect(self):
        """Detect appropriate scenario mode."""
        
        # Score each scenario based on context
        self.score_project_type()
        self.score_constraints()
        self.score_goals()
        self.score_team_structure()
        self.score_risk_profile()
        
        # Select highest scoring scenario
        recommended_mode = max(self.scenarios, key=self.scenarios.get)
        confidence = self.scenarios[recommended_mode] / sum(self.scenarios.values())
        
        return {
            'mode': recommended_mode,
            'confidence': confidence,
            'scores': self.scenarios,
            'rationale': self.generate_rationale(recommended_mode)
        }
    
    def score_project_type(self):
        """Score based on project type."""
        
        type_scores = {
            'greenfield': {'standard': 3, 'poc': 2},
            'brownfield': {'refactoring': 3, 'language_migration': 2},
            'legacy': {'reverse_engineering': 3, 'refactoring': 2},
            'emergency': {'emergency': 5}
        }
        
        project_type = self.context.get('project_type', 'greenfield')
        for mode, score in type_scores.get(project_type, {}).items():
            self.scenarios[mode] += score
    
    def score_constraints(self):
        """Score based on constraints."""
        
        constraints = self.context.get('constraints', {})
        
        if constraints.get('deadline') == 'tight':
            self.scenarios['emergency'] += 2
            self.scenarios['poc'] += 1
        
        if constraints.get('budget') == 'limited':
            self.scenarios['standard'] += 1
            self.scenarios['continuous_improvement'] += 1
        
        if constraints.get('regulatory'):
            self.scenarios['standard'] += 2
            self.scenarios['federal'] += 1
    
    def generate_rationale(self, mode):
        """Generate rationale for recommended mode."""
        
        rationales = {
            'standard': [
                "Clear requirements and stable context",
                "Full methodology application appropriate",
                "Standard risk profile"
            ],
            'reverse_engineering': [
                "Legacy system requires understanding first",
                "Documentation priority over immediate changes",
                "Risk of breaking unknown dependencies"
            ],
            'language_migration': [
                "Technology change requires parallel approach",
                "Strangler pattern recommended",
                "Interface contracts critical"
            ],
            'refactoring': [
                "Existing system needs structural improvement",
                "Incremental approach reduces risk",
                "Maintain existing functionality"
            ],
            'poc': [
                "New approach needs validation",
                "Reduced process overhead",
                "Focus on core hypothesis"
            ],
            'emergency': [
                "Critical issue requires immediate action",
                "Standard process too slow",
                "Post-fix validation required"
            ],
            'federal': [
                "Multi-team coordination required",
                "Interface contracts critical",
                "Enhanced governance needed"
            ],
            'continuous_improvement': [
                "Existing system optimization",
                "Metrics-driven approach",
                "Iterative enhancements"
            ]
        }
        
        return rationales.get(mode, ["Context-specific recommendation"])
```

## Output Format

```yaml
scenario_detection:
  detection_id: "sd-20250424-001"
  project: "legacy-system-modernization"
  
  recommended_mode:
    mode: "reverse_engineering"
    confidence: 0.92
    
  scores:
    standard: 2
    reverse_engineering: 8
    language_migration: 3
    refactoring: 5
    poc: 1
    emergency: 0
    federal: 2
    continuous_improvement: 4
    
  rationale:
    - "Legacy system requires understanding before modification"
    - "Limited budget favors documentation over immediate rewrite"
    - "2-month timeline insufficient for full migration"
    
  recommended_transition:
    - phase: 1
      mode: "reverse_engineering"
      duration: "2 months"
      focus: "Documentation and understanding"
      
    - phase: 2
      mode: "refactoring"
      duration: "3 months"
      focus: "Incremental improvement"
      
    - phase: 3
      mode: "standard"
      duration: "ongoing"
      focus: "Full methodology application"
      
  principle_adjustments:
    P2: "reduced"
    P4: "n_a"
    P5: "document_existing"
    P6: "existing_tests"
```

## Integration with Aether.go Methodology

- **Input from**: business-requirements-collector (project context), context-manager (project state)
- **Output to**: constitution-guardian (scenario mode selection), workflow-orchestrator (workflow adjustment)
- **Validates with**: correctness-checker (recommendation accuracy)
- **Part of**: D6 Scenario Adaptation Domain

## Validation Rules

- Recommended mode MUST have confidence >= 0.70
- Rationale MUST be provided for recommendation
- Principle adjustments MUST be documented
- Transition plan SHOULD be provided for non-standard modes
- Detection MUST consider all context dimensions
