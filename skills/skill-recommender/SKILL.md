---
name: skill-recommender
description: Use when recommending relevant AI skills based on current task, project context, and development phase
---

# Skill Recommender

## Overview
Analyze current task, project context, and development phase to recommend the most relevant AI skills for the work at hand. Improves efficiency by suggesting the right tool for the job.

## When to Use

```
Starting new task? ──────────────────────┐
                                        │
Unsure which skill to use? ──────────────┤
                                        ├─► Use skill-recommender
Transitioning dev phase? ───────────────┤
                                        │
Onboarding to project? ─────────────────┘
```

Use when:
- Starting new work
- Unsure which skill is appropriate
- Transitioning between project phases
- Onboarding team members
- Creating workflows
- Optimizing AI assistance

Don't use when:
- Task is clearly defined
- Already using appropriate skill
- One-off simple task

## Core Pattern

### Recommendation Logic

```python
def recommend_skills(task, project_context, available_skills):
    """Recommend skills based on task and context."""

    recommendations = []

    for skill in available_skills:
        score = calculate_relevance_score(skill, task, project_context)

        if score > 0.5:  # Threshold
            recommendations.append({
                'skill': skill.name,
                'description': skill.description,
                'score': score,
                'reason': explain_relevance(skill, task)
            })

    # Sort by relevance
    recommendations.sort(key=lambda x: x['score'], reverse=True)

    return recommendations[:5]  # Top 5
```

### Recommendation Examples

```yaml
recommendation_engine:
  task: "Implementing user authentication"

  analysis:
    keywords: ["authentication", "security", "user"]
    phase: "implementation"
    complexity: "medium"

  recommendations:
    - skill: "tdd-red-green-refactor"
      score: 0.95
      reason: "Implementation phase requires TDD methodology"

    - skill: "constitution-validator"
      score: 0.85
      reason: "Security feature requires constitutional compliance check"

    - skill: "spec-parser"
      score: 0.60
      reason: "May need to parse authentication requirements"

    - skill: "sit-scenario-generator"
      score: 0.55
      reason: "Integration testing for auth flow"

    - skill: "metrics-definer"
      score: 0.45
      reason: "May need auth-related metrics"
```

## Implementation

### Scoring Algorithm

```python
def calculate_relevance_score(skill, task, context):
    """Calculate relevance score for skill."""

    score = 0.0

    # Keyword matching
    task_keywords = extract_keywords(task)
    skill_keywords = extract_keywords(skill.description)
    keyword_match = len(set(task_keywords) & set(skill_keywords))
    score += keyword_match * 0.3

    # Phase alignment
    if skill.phase == context.phase:
        score += 0.4

    # Historical usage
    if skill.name in context.previously_used:
        score += 0.2

    # Dependencies
    if skill.name in context.required_skills:
        score += 0.5

    # Business criticality
    if task.priority == 'high':
        score += 0.3

    return min(score, 1.0)
```

### Skill Categories

```yaml
skill_categories:
  planning:
    skills:
      - "brainstorming"
      - "writing-plans"
      - "business-value-mapper"

  implementation:
    skills:
      - "tdd-red-green-refactor"
      - "bdd-scenario-writer"
      - "spec-parser"

  testing:
    skills:
      - "test-pyramid-analyzer"
      - "sit-scenario-generator"
      - "chaos-test-designer"

  quality:
    skills:
      - "constitution-validator"
      - "systematic-debugging"
      - "requesting-code-review"

  infrastructure:
    skills:
      - "metrics-definer"
      - "data-flow-analyzer"
      - "architecture-decision-recorder"
```

### Context-Aware Recommendations

```python
def get_context_aware_recommendations(context):
    """Get recommendations based on project context."""

    recommendations = []

    # Project phase
    if context.phase == 'planning':
        recommendations.extend(get_skills_for_phase('planning'))

    elif context.phase == 'implementation':
        recommendations.extend(get_skills_for_phase('implementation'))

    # Recent history
    recent_skills = get_recently_used_skills(context)
    recommendations.extend(recent_skills)

    # Dependencies
    if context.current_task.requires_testing:
        recommendations.append('test-pyramid-analyzer')

    if context.current_task.involves_integration:
        recommendations.append('sit-scenario-generator')

    # Deduplicate and score
    return score_and_deduplicate(recommendations)
```
