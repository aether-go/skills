---
name: skill-gap-analyzer
description: Use when analyzing gaps between methodology requirements and skill inventory. Part of D8 Meta-Capability Domain for skill library optimization.
---

# Skill Gap Analyzer

## Overview
Analyze gaps between methodology requirements and skill inventory. Identifies missing skills, coverage deficiencies, and provides recommendations for skill development. Part of D8 Meta-Capability Domain for skill library optimization.

## When to Use

```
Methodology updated? ────────────────────┐
                                         │
Need skill gap analysis? ────────────────┤
                                         ├─► Use skill-gap-analyzer
Skill library audit? ────────────────────┤
                                         │
SkillLibraryCurator needs input? ────────┘
```

Use when:
- Methodology has been updated and skill gaps need assessment
- Skill library audit is needed
- SkillLibraryCurator needs gap analysis input
- Planning skill development roadmap

Don't use when:
- Skill library is complete and up-to-date
- Only single skill evaluation is needed
- No methodology changes have occurred

## Core Pattern

### Analysis Process

```
Methodology Requirements
    ├── Domain Requirements
    ├── Principle Requirements
    ├── Protocol Requirements
    └── Workflow Requirements
         |
         v
    Skill Inventory
         |
         v
    Gap Analysis
         |
         v
    Development Roadmap
```

### Gap Dimensions

| Dimension | Description | Metric |
|-----------|-------------|--------|
| **Coverage** | Are all methodology elements supported? | Coverage % |
| **Redundancy** | Are there overlapping skills? | Overlap score |
| **Bottleneck** | Are there frequently failing skills? | Failure rate |
| **Balance** | Is skill count balanced across domains? | Standard deviation |
| **Evolution** | Is skill library continuously updated? | Update frequency |

## Input Format

```yaml
gap_request:
  methodology:
    version: "3.0"
    domains:
      - "D1 Business Intent"
      - "D2 Architecture"
      - "D3 Specification"
      - "D4 Implementation"
      - "D4.5 Generation Dispatch"
      - "D5 Implementation"
      - "D6 Scenario Adaptation"
      - "D7 Knowledge Engine"
      - "D8 Meta-Capability"
    
    principles:
      - "P1 Purpose-Driven"
      - "P2 Planning-First"
      - "P3 Semantic-First"
      - "P4 Interface-First"
      - "P5 Contract-First"
      - "P6 Test-First"
      - "P7 Context-First"
      - "P8 Memory-First"
      - "P9 Review-First"
      - "P10 Skill-Library-Assetization"
      - "P11 Intent-Hierarchization"
      - "P12 Tool-System-Adaptation"
      - "P13 Constraint-Mechanization"
      - "P14 Non-Functional-Attributes-Built-in"
      - "P15 Knowledge-Engine-Skill-Assetization"
    
    protocols:
      - "ARGUE-001"
      - "ARGUE-002"
      - "ARGUE-003"
      - "ARGUE-004"
      - "ARGUE-005"
      - "ARGUE-006"
      - "META-001"
      - "META-002"
      - "META-003"
      - "META-004"
      - "META-005"
      - "DISPATCH-001"
      - "GATE-001"
  
  skill_inventory:
    path: ".aether/skills/installed/"
    custom_path: ".aether/skills/custom/"
```

## Output Format

```yaml
gap_report:
  methodology_version: "3.0"
  timestamp: "2026-04-30T10:00:00Z"
  
  summary:
    total_required: 45
    total_available: 38
    gaps: 7
    coverage: 0.844
  
  domain_coverage:
    - domain: "D1 Business Intent"
      required: 5
      available: 5
      coverage: 1.0
    
    - domain: "D4.5 Generation Dispatch"
      required: 4
      available: 2
      coverage: 0.5
      gaps:
        - "deterministic-evaluator"
        - "confidence-based-reviewer"
    
    - domain: "D7 Knowledge Engine"
      required: 3
      available: 2
      coverage: 0.667
      gaps:
        - "repo-wiki-generator"
  
  principle_support:
    - principle: "P11 Intent-Hierarchization"
      supported: false
      missing_skill: "intent-hierarchizer"
    
    - principle: "P13 Constraint-Mechanization"
      supported: true
      skill: "constraint-check-runner"
  
  protocol_support:
    - protocol: "DISPATCH-001"
      supported: false
      missing_skills: ["deterministic-evaluator", "code-generator-dispatcher"]
    
    - protocol: "GATE-001"
      supported: true
      skill: "contract-consistency-gate"
  
  recommendations:
    - priority: high
      action: "Create deterministic-evaluator skill"
      domain: "D4.5 Generation Dispatch"
    
    - priority: high
      action: "Create confidence-based-reviewer skill"
      domain: "D4.5 Generation Dispatch"
    
    - priority: medium
      action: "Create repo-wiki-generator skill"
      domain: "D7 Knowledge Engine"
  
  development_roadmap:
    phase_1:
      skills: ["deterministic-evaluator", "code-generator-dispatcher"]
      timeline: "2 weeks"
    
    phase_2:
      skills: ["confidence-based-reviewer", "contract-consistency-gate"]
      timeline: "2 weeks"
    
    phase_3:
      skills: ["repo-wiki-generator", "code-graph-analyzer"]
      timeline: "1 week"
```

## Integration with Aether.go Methodology

- **Input from**: SkillLibraryCurator, methodology updates
- **Output to**: SkillLibraryCurator, skill-optimizer
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: Full Analysis
```yaml
methodology: "3.0"
coverage: 0.844
gaps: 7
recommendations: ["Create missing D4.5 skills", "Enhance D7 coverage"]
roadmap: {phase_1: "2 weeks", phase_2: "2 weeks", phase_3: "1 week"}
```

### Example 2: Targeted Analysis
```yaml
domain: "D4.5 Generation Dispatch"
coverage: 0.5
gaps: ["deterministic-evaluator", "confidence-based-reviewer"]
recommendations: ["Create missing dispatch skills"]
```
