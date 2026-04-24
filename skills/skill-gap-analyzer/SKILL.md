---
name: skill-gap-analyzer
description: Use when analyzing gaps between methodology requirements and skill inventory, generating skill development roadmaps
---

# Skill Gap Analyzer

## Overview
Analyze gaps between Aether methodology requirements and current skill inventory. Generates skill development roadmaps to address coverage deficiencies and ensure the skill library evolves with methodology needs.

## When to Use

```
Methodology updated? ────────────────────┐
                                         │
Need to assess skill coverage? ──────────┤
                                         ├─► Use skill-gap-analyzer
Skill inventory changed? ────────────────┤
                                         │
Development roadmap needed? ─────────────┘
```

Use when:
- Methodology has been updated and skills need assessment
- Need to identify skill coverage gaps
- Skill inventory has changed and impact needs analysis
- Development roadmap for new skills is needed
- Following P10 skill library assetization

Don't use when:
- Only single skill needs evaluation
- Methodology is stable and skills are current
- Only skill performance needs checking

## Core Pattern

### Gap Analysis Process

```
Methodology Requirements
    ├── Derivation Layers (L1-L5)
    ├── Scenario Modes (8 modes)
    ├── Constitutional Principles (P0-P10)
    ├── Agent Interactions (ARGUE/META protocols)
    └── Quality Gates
         |
         v
    Skill Gap Analyzer
         |
         v
Gap Report + Development Roadmap
```

### Gap Categories

| Category | Description | Example |
|----------|-------------|---------|
| **Missing Skill** | No skill exists for methodology element | No skill for mobile development |
| **Incomplete Skill** | Skill exists but lacks functionality | test-pyramid-deriver lacks META-005 support |
| **Outdated Skill** | Skill doesn't reflect latest methodology | workflow-orchestrator without ARGUE protocols |
| **Redundant Skill** | Multiple skills for same element | backend-code-generator and api-generator overlap |
| **Low Quality Skill** | Skill exists but has poor metrics | Skill with < 85% success rate |

### Before (Without Gap Analysis)
```yaml
methodology:
  version: "2.1"
  requirements:
    - "Dynamic principle weighting"
    - "ARGUE-005 semantic confirmation"
    - "META-005 boundary rationality"
    - "Mobile development support"
    
skills:
  - workflow-orchestrator (v1.0)
  - constitution-guardian (v1.0)
  - test-pyramid-deriver (v1.0)
  
issues:
  - "No dynamic weighting support"
  - "No semantic confirmation protocol"
  - "No boundary rationality challenge"
  - "No mobile development skills"
  
result:
  - Methodology not fully implementable
  - Workarounds reduce effectiveness
  - User frustration with limitations
```

### After (With Gap Analysis)
```yaml
methodology:
  version: "2.1"
  requirements:
    - "Dynamic principle weighting"
    - "ARGUE-005 semantic confirmation"
    - "META-005 boundary rationality"
    - "Mobile development support"
    
gap_analysis:
  missing_skills:
    - requirement: "Dynamic principle weighting"
      priority: "critical"
      proposed_skill: "principle-consistency-checker"
      
    - requirement: "ARGUE-005 semantic confirmation"
      priority: "critical"
      proposed_skill: "semantic-intent-clarifier"
      
    - requirement: "META-005 boundary rationality"
      priority: "critical"
      proposed_skill: "meta-skeptic"
      
    - requirement: "Mobile development support"
      priority: "medium"
      proposed_skill: "mobile-app-scaffolder"
      
  incomplete_skills:
    - skill: "workflow-orchestrator"
      missing_features: ["ARGUE protocols", "meta-argumentation checkpoints"]
      priority: "high"
      
    - skill: "constitution-guardian"
      missing_features: ["dynamic weighting", "conflict resolution"]
      priority: "high"
      
  outdated_skills:
    - skill: "test-pyramid-deriver"
      current_version: "1.0"
      required_version: "2.1"
      missing_features: ["META-005 support", "boundary rationale"]
      priority: "high"
      
  redundant_skills:
    - skills: ["backend-code-generator", "api-generator"]
      overlap: 0.85
      recommendation: "Merge into single skill"
      priority: "medium"
      
  development_roadmap:
    phase_1:
      duration: "2 weeks"
      skills: ["principle-consistency-checker", "semantic-intent-clarifier", "meta-skeptic"]
      priority: "critical"
      
    phase_2:
      duration: "1 week"
      skills: ["workflow-orchestrator-v2", "constitution-guardian-v2"]
      priority: "high"
      
    phase_3:
      duration: "2 weeks"
      skills: ["test-pyramid-deriver-v2", "mobile-app-scaffolder"]
      priority: "medium"
```

## Quick Reference

### Gap Detection Matrix

| Methodology Element | Required Skills | Current Skills | Gap |
|-------------------|----------------|---------------|-----|
| L1->L2 Derivation | value-decomposer | Missing | Critical |
| ARGUE-005 Protocol | semantic-intent-clarifier | Missing | Critical |
| META-005 Protocol | meta-skeptic | Missing | Critical |
| Dynamic Weighting | principle-consistency-checker | Missing | Critical |
| Test Stratification | test-pyramid-deriver | Outdated | High |
| Mobile Development | mobile-app-scaffolder | Missing | Medium |
| API Generation | api-generator | Redundant | Low |

### Roadmap Priority Rules

| Priority | Criteria | Timeline |
|----------|----------|----------|
| **Critical** | Blocks methodology implementation | 1-2 weeks |
| **High** | Significantly impacts effectiveness | 2-4 weeks |
| **Medium** | Nice to have, workarounds exist | 1-2 months |
| **Low** | Minor improvement | 3+ months |

## Implementation

### Gap Analysis Engine

```python
class SkillGapAnalyzer:
    def __init__(self, methodology_requirements, skill_inventory):
        self.requirements = methodology_requirements
        self.skills = skill_inventory
        self.gaps = []
        
    def analyze_gaps(self):
        """Analyze gaps between requirements and skills."""
        
        for requirement in self.requirements:
            self.check_requirement_coverage(requirement)
        
        for skill in self.skills:
            self.check_skill_completeness(skill)
            self.check_skill_freshness(skill)
        
        self.check_redundancy()
        
        return {
            'gaps': self.gaps,
            'roadmap': self.generate_roadmap(),
            'metrics': self.calculate_metrics()
        }
    
    def check_requirement_coverage(self, requirement):
        """Check if requirement is covered by skills."""
        
        covering_skills = [
            skill for skill in self.skills
            if requirement.id in skill.covers_requirements
        ]
        
        if not covering_skills:
            self.gaps.append({
                'type': 'missing_skill',
                'requirement': requirement.id,
                'description': requirement.description,
                'priority': requirement.priority
            })
        elif not any(skill.is_complete_for(requirement) for skill in covering_skills):
            self.gaps.append({
                'type': 'incomplete_skill',
                'requirement': requirement.id,
                'skills': [s.name for s in covering_skills],
                'priority': requirement.priority
            })
    
    def check_skill_completeness(self, skill):
        """Check if skill is complete for its requirements."""
        
        for requirement_id in skill.covers_requirements:
            requirement = self.get_requirement(requirement_id)
            if requirement and not skill.is_complete_for(requirement):
                self.gaps.append({
                    'type': 'incomplete_skill',
                    'skill': skill.name,
                    'missing_features': skill.get_missing_features(requirement),
                    'priority': requirement.priority
                })
    
    def check_skill_freshness(self, skill):
        """Check if skill is up to date with methodology."""
        
        if skill.version < self.requirements.version:
            self.gaps.append({
                'type': 'outdated_skill',
                'skill': skill.name,
                'current_version': skill.version,
                'required_version': self.requirements.version,
                'missing_features': skill.get_missing_features_for_version(self.requirements.version)
            })
    
    def check_redundancy(self):
        """Check for redundant skills."""
        
        for i, skill1 in enumerate(self.skills):
            for skill2 in self.skills[i+1:]:
                overlap = self.calculate_overlap(skill1, skill2)
                if overlap > 0.8:
                    self.gaps.append({
                        'type': 'redundant_skill',
                        'skills': [skill1.name, skill2.name],
                        'overlap': overlap,
                        'recommendation': 'merge'
                    })
    
    def generate_roadmap(self):
        """Generate skill development roadmap."""
        
        critical_gaps = [g for g in self.gaps if g.get('priority') == 'critical']
        high_gaps = [g for g in self.gaps if g.get('priority') == 'high']
        medium_gaps = [g for g in self.gaps if g.get('priority') == 'medium']
        
        roadmap = []
        
        if critical_gaps:
            roadmap.append({
                'phase': 1,
                'duration': '2 weeks',
                'gaps': critical_gaps,
                'priority': 'critical'
            })
        
        if high_gaps:
            roadmap.append({
                'phase': 2,
                'duration': '1-2 weeks',
                'gaps': high_gaps,
                'priority': 'high'
            })
        
        if medium_gaps:
            roadmap.append({
                'phase': 3,
                'duration': '2-4 weeks',
                'gaps': medium_gaps,
                'priority': 'medium'
            })
        
        return roadmap
    
    def calculate_metrics(self):
        """Calculate gap metrics."""
        
        total_requirements = len(self.requirements)
        covered_requirements = sum(
            1 for req in self.requirements
            if any(req.id in skill.covers_requirements for skill in self.skills)
        )
        
        return {
            'coverage': covered_requirements / total_requirements if total_requirements else 0,
            'gap_count': len(self.gaps),
            'critical_gaps': len([g for g in self.gaps if g.get('priority') == 'critical']),
            'high_gaps': len([g for g in self.gaps if g.get('priority') == 'high'])
        }
```

## Output Format

```yaml
skill_gap_analysis:
  analysis_id: "sga-20250424-001"
  methodology_version: "2.1"
  skill_inventory_version: "1.0"
  
  gaps:
    missing_skills:
      - requirement: "Dynamic principle weighting"
        description: "Support for dynamic principle weighting and conflict resolution"
        priority: "critical"
        proposed_skill: "principle-consistency-checker"
        
      - requirement: "ARGUE-005 semantic confirmation"
        description: "Structured reverse clarification at semantic nodes"
        priority: "critical"
        proposed_skill: "semantic-intent-clarifier"
        
    incomplete_skills:
      - skill: "workflow-orchestrator"
        missing_features:
          - "ARGUE protocols"
          - "Meta-argumentation checkpoints"
          - "Derivation matrix integration"
        priority: "high"
        
    outdated_skills:
      - skill: "test-pyramid-deriver"
        current_version: "1.0"
        required_version: "2.1"
        missing_features:
          - "META-005 support"
          - "Boundary rationale explicitization"
        priority: "high"
        
    redundant_skills:
      - skills: ["backend-code-generator", "api-generator"]
        overlap: 0.85
        recommendation: "Merge into backend-code-generator with API generation capability"
        priority: "medium"
        
  development_roadmap:
    phase_1:
      duration: "2 weeks"
      priority: "critical"
      deliverables:
        - "principle-consistency-checker"
        - "semantic-intent-clarifier"
        - "meta-skeptic"
        
    phase_2:
      duration: "1 week"
      priority: "high"
      deliverables:
        - "workflow-orchestrator-v2"
        - "constitution-guardian-v2"
        
    phase_3:
      duration: "2 weeks"
      priority: "medium"
      deliverables:
        - "test-pyramid-deriver-v2"
        - "Merge backend-code-generator and api-generator"
        
  metrics:
    coverage: 0.78
    gap_count: 8
    critical_gaps: 3
    high_gaps: 3
    medium_gaps: 2
```

## Integration with Aether.go Methodology

- **Input from**: skill-library-curator (skill inventory), architecture-self-auditor (audit findings)
- **Output to**: skill-library-curator (development tasks), adjustment-proposer (optimization recommendations)
- **Validates with**: correctness-checker (gap accuracy)
- **Part of**: D8 Meta-Capability Domain

## Validation Rules

- All methodology requirements MUST be checked
- Gap priority MUST be assigned
- Roadmap MUST include phases with timelines
- Metrics MUST include coverage percentage
- Redundant skills MUST be identified
- Outdated skills MUST be flagged
