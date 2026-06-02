---
name: skill-manager
description: Use when managing the skill library lifecycle (creation, validation, assetization, application, feedback, optimization, retirement), identifying skill gaps, recommending skills for tasks, and packaging skills for distribution. This skill unifies P14 Knowledge-Engine-Skill-Assetization and replaces skill-lifecycle-manager, skill-optimizer, skill-recommender, skill-gap-analyzer, skill-packaging-tool, and prompt-template-manager.
---

# Skill Manager

## Overview

The unified skill for managing the entire skill library lifecycle. This skill:
- Tracks skills through 6 phases: creation → validation → assetization → application → feedback → optimization → retirement
- Identifies gaps in skill coverage
- Recommends skills for specific tasks
- Packages skills for distribution
- Manages prompt templates as skill assets

**Replaces** (consolidated from 6 skills):
- `skill-lifecycle-manager`
- `skill-optimizer`
- `skill-recommender`
- `skill-gap-analyzer`
- `skill-packaging-tool`
- `prompt-template-manager`

## Skill Lifecycle

```
Phase 1: Creation
    Identify pattern → Write skill → Review
    │
    ▼
Phase 2: Validation
    Pilot application → Success rate ≥ 85%? → Quality assessment
    │
    ├── No → Back to Creation
    └── Yes ↓
    ▼
Phase 3: Assetization
    Documentation → Version tag → Library inclusion
    │
    ▼
Phase 4: Application
    Task matching → Execution → Capture context
    │
    ▼
Phase 5: Feedback
    Effectiveness collected → Success rate updated
    │
    ▼
Phase 6: Optimization (driven by recursive-optimizer)
    Parameter tuning → Template refinement → Documentation update
    │
    ▼
Phase 7: Retirement (optional)
    Trigger conditions met → Archive → Notify dependents
```

## Skill Retirement Conditions

| Condition | Trigger |
|-----------|---------|
| Technology obsolete | Tech stack no longer used |
| Success rate sustained < 50% | 3+ months poor performance |
| Superseded | Better skill replaces it |
| Maintenance burden | No longer worth maintaining |

## When to Use

```
Need to find a skill for a task? ───────────┐
                                            │
Identifying skill library gaps? ─────────── ┤
                                            │
Optimizing skill parameters? ───────────────┼─► Use skill-manager
                                            │
Packaging a skill for distribution? ─────── ─┤
                                            │
Retiring a deprecated skill? ───────────────┘
```

## Input Format

```yaml
skill_management_request:
  action: "recommend"  # create | validate | assetize | apply | feedback | optimize | retire | recommend | gap-analysis | package
  
  # For recommendation
  task_description: "Generate unit tests for Go service"
  context:
    language: "go"
    framework: "gin"
    project_type: "backend"
  
  # For feedback
  skill_used: "test-planner"
  success: true
  execution_time_seconds: 45
  feedback: "Generated tests worked first time"
  
  # For packaging
  skills_to_package:
    - "requirement-analyzer"
    - "test-planner"
  target_format: "tarball"  # tarball | npm | oci
  
  # For gap analysis
  current_skills: ["requirement-analyzer", "test-planner", ...]
  methodology_requirements:
    principles: ["P0", "P1", ..., "P14"]
    scenarios: ["standard", "ai-native", "harness-reverse", ...]
    stages: ["L1", "L2", "L3", "L4", "L4.5", "L5"]
  
  # For retirement
  skill_to_retire: "old-test-generator"
  reason: "Replaced by test-planner"
  archive_path: "skills/.archive/old-test-generator/"
```

## Output Format

### Skill Recommendation

```yaml
recommendation_result:
  task: "Generate unit tests for Go service"
  context: {language: "go", framework: "gin"}
  
  ranked_skills:
    - skill: "test-planner"
      confidence: 0.95
      rationale: "Handles unit test generation as part of full pyramid"
      usage: "Set test_layer: unit parameter"
    
    - skill: "code-generator"
      confidence: 0.60
      rationale: "Could generate test scaffolds in TDD green mode"
      usage: "Set tdd_mode: true"
  
  selected_skill: "test-planner"
  invocation: 'test-planner --test-layer unit --language go'
```

### Gap Analysis

```yaml
gap_analysis_result:
  coverage:
    principles:
      covered: 14  # P0-P13
      missing: 1    # P14
      coverage_percent: 0.93
    scenarios:
      covered: ["standard", "ai-native", "harness-reverse", "poc", "emergency"]
      missing: ["federal", "language-migration"]
      coverage_percent: 0.70
    stages:
      covered: ["L1", "L2", "L3", "L4", "L4.5", "L5"]
      missing: []
      coverage_percent: 1.0
  
  gaps:
    - id: "GAP-001"
      type: "principle"
      principle: "P14"
      description: "No skill dedicated to knowledge engine management"
      recommendation: "Create or extend knowledge-engine skill"
      priority: "medium"
    
    - id: "GAP-002"
      type: "scenario"
      scenario: "federal"
      description: "Multi-team scenario not fully covered"
      recommendation: "Extend scenario-engine with federal workflow details"
      priority: "low"
  
  recommendations:
    - "Create knowledge-engine skill (or add to context-manager)"
    - "Add federal workflow to scenario-engine"
```

### Package Result

```yaml
packaging_result:
  package_name: "aether-skills-v3.0.0"
  format: "tarball"
  path: "dist/aether-skills-v3.0.0.tar.gz"
  size_bytes: 2456789
  
  included_skills: 25
  total_size_lines: 125000
  
  dependencies:
    - name: "constitution-validator"
      version: "^3.0.0"
    - name: "requirement-analyzer"
      version: "^3.0.0"
  
  manifest: "package.yml"
  checksums: "SHA256SUMS"
```

## Implementation

### Skill Recommendation Algorithm

```python
def recommend_skill(task: str, context: dict) -> list:
    """Score and rank skills for a task."""
    candidates = []
    for skill in load_all_skills():
        # Keyword match
        keyword_score = keyword_match(task, skill.keywords)
        # Context match (language, framework, etc.)
        context_score = context_match(context, skill.metadata)
        # Historical success rate for similar tasks
        history_score = skill.success_rate
        # Combined score
        total = 0.5 * keyword_score + 0.3 * context_score + 0.2 * history_score
        candidates.append({
            "skill": skill.name,
            "confidence": total,
            "rationale": explain_match(task, skill),
        })
    return sorted(candidates, key=lambda c: c["confidence"], reverse=True)
```

### Gap Analysis

```python
def gap_analysis(current_skills: list, requirements: dict) -> dict:
    """Identify missing skill coverage."""
    gaps = []
    # Check principle coverage
    for principle in requirements["principles"]:
        if not has_skill_for_principle(principle, current_skills):
            gaps.append({
                "type": "principle",
                "principle": principle,
                "recommendation": f"Create or extend skill for {principle}",
            })
    # Check scenario coverage
    for scenario in requirements["scenarios"]:
        if not has_skill_for_scenario(scenario, current_skills):
            gaps.append({...})
    return gaps
```

### Skill Validation

```python
def validate_skill(skill: dict, pilot_tasks: list) -> dict:
    """Validate skill effectiveness on pilot tasks."""
    successes = 0
    for task in pilot_tasks:
        result = execute_skill(skill, task)
        if result["success"]:
            successes += 1
    success_rate = successes / len(pilot_tasks)
    return {
        "success_rate": success_rate,
        "passes_threshold": success_rate >= 0.85,
        "recommendation": "assetize" if success_rate >= 0.85 else "iterate",
    }
```

## Validation Rules

- ✅ Skills validated with success rate ≥ 85% before assetization
- ✅ Skill library coverage tracked per principle, scenario, stage
- ✅ Retired skills archived with metadata
- ✅ Skill versions semantically tagged
- ✅ Recommendations include confidence + rationale

## Integration with Aether.go Methodology

- **Input from**:
  - `recursive-optimizer` (skill optimization requests)
  - `metrics-tracker` (skill usage metrics)
  - `architecture-auditor` (gap findings)
- **Output to**:
  - All skills (lifecycle management)
  - `methodology-fusion-orchestrator` (skill availability)
- **Part of**: Evolution Layer
- **Principle alignment**:
  - **P14 Knowledge-Engine-Skill-Assetization**: Core implementation
  - **P13 Recursive-Self-Optimization**: Skill improvement

## Migration Notes

This skill consolidates 6 previously separate skills:
- `skill-lifecycle-manager` → All 7 phases
- `skill-optimizer` → Phase 6
- `skill-recommender` → `action: recommend`
- `skill-gap-analyzer` → `action: gap-analysis`
- `skill-packaging-tool` → `action: package`
- `prompt-template-manager` → Prompt template asset management
