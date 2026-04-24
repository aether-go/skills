---
name: adjustment-proposer
description: Use when proposing adjustments to architecture, skills, or workflows based on audit findings, gap analysis, or meta-skeptic challenges
---

# Adjustment Proposer

## Overview
Propose adjustments to architecture, skills, or workflows based on audit findings, gap analysis results, or meta-skeptic challenges. Generates actionable recommendations with impact analysis and implementation plans.

## When to Use

```
Audit findings available? ───────────────┐
                                         │
Gap analysis completed? ─────────────────┤
                                         ├─► Use adjustment-proposer
Meta-skeptic challenge received? ────────┤
                                         │
Optimization needed? ────────────────────┘
```

Use when:
- Architecture self-audit has findings
- Skill gap analysis has identified gaps
- Meta-skeptic has issued BOUNDARY_IRRATIONAL verdict
- Optimization recommendations are needed
- Following P9 recursive self-optimization

Don't use when:
- No findings or gaps exist
- Only single minor issue needs fixing
- Issue can be resolved without architectural change

## Core Pattern

### Adjustment Proposal Process

```
Findings / Gaps / Challenges
    ├── Audit Findings
    ├── Gap Analysis Results
    └── Meta-Skeptic Challenges
         |
         v
    Adjustment Proposer
         |
         v
Adjustment Proposals
    ├── Impact Analysis
    ├── Implementation Plan
    └── Validation Criteria
```

### Adjustment Types

| Type | Trigger | Example |
|------|---------|---------|
| **Skill Creation** | Missing skill identified | Create semantic-intent-clarifier |
| **Skill Update** | Outdated or incomplete skill | Update workflow-orchestrator to v2.1 |
| **Skill Merge** | Redundant skills identified | Merge backend-code-generator and api-generator |
| **Skill Retirement** | Skill obsolete or replaced | Retire old test generator |
| **Workflow Change** | Process inefficiency identified | Add meta-argumentation checkpoints |
| **Architecture Change** | Structural issue found | Reorganize skill domains |
| **Parameter Tuning** | Performance issue detected | Optimize skill temperature settings |

### Before (Without Adjustment Proposals)
```yaml
findings:
  - "backend-code-generator fails 8% of the time"
  - "workflow-orchestrator lacks ARGUE protocols"
  - "No semantic confirmation skill exists"
  
approach:
  - "Fix backend-code-generator bugs"
  - "Add ARGUE protocols to workflow-orchestrator"
  - "Create semantic-intent-clarifier"
  
issues:
  - "Fixes are ad-hoc, not systematic"
  - "No impact analysis"
  - "No validation plan"
  - "Changes may introduce new issues"
```

### After (With Adjustment Proposals)
```yaml
findings:
  - "backend-code-generator fails 8% of the time"
  - "workflow-orchestrator lacks ARGUE protocols"
  - "No semantic confirmation skill exists"
  
adjustment_proposals:
  proposal_1:
    type: "parameter_tuning"
    target: "backend-code-generator"
    issue: "8% failure rate exceeds 5% threshold"
    
    impact_analysis:
      affected_skills: ["backend-code-generator"]
      affected_workflows: ["implementation"]
      risk_level: "low"
      
    implementation:
      action: "Reduce temperature from 0.3 to 0.2"
      estimated_effort: "1 hour"
      rollback_plan: "Revert temperature change"
      
    validation:
      criteria: "Failure rate < 5%"
      measurement: "Run 100 test generations"
      success_threshold: "< 5 failures"
      
  proposal_2:
    type: "skill_update"
    target: "workflow-orchestrator"
    issue: "Lacks ARGUE protocols and meta-argumentation checkpoints"
    
    impact_analysis:
      affected_skills: ["workflow-orchestrator", "all-dependent-skills"]
      affected_workflows: ["all-workflows"]
      risk_level: "medium"
      
    implementation:
      action: "Update to v2.1 with ARGUE protocols"
      estimated_effort: "3 days"
      rollback_plan: "Revert to v1.0"
      
    validation:
      criteria: "All workflows execute with ARGUE protocols"
      measurement: "Run full workflow test suite"
      success_threshold: "100% pass rate"
      
  proposal_3:
    type: "skill_creation"
    target: "semantic-intent-clarifier"
    issue: "No skill exists for ARGUE-005 semantic confirmation"
    
    impact_analysis:
      affected_skills: ["human-ai-boundary-guard", "workflow-orchestrator"]
      affected_workflows: ["all-workflows"]
      risk_level: "medium"
      
    implementation:
      action: "Create semantic-intent-clarifier skill"
      estimated_effort: "2 days"
      dependencies: ["ARGUE-005 protocol specification"]
      
    validation:
      criteria: "Skill generates valid clarification questions"
      measurement: "Test with 10 sample scenarios"
      success_threshold: "> 90% valid questions"
```

## Quick Reference

### Proposal Template

```yaml
adjustment_proposal:
  proposal_id: "ADJ-YYYYMMDD-NNN"
  type: "skill_creation|skill_update|skill_merge|skill_retirement|workflow_change|architecture_change|parameter_tuning"
  target: "skill_or_workflow_name"
  trigger: "audit_finding|gap_analysis|meta_skeptic|optimization"
  
  issue:
    description: "Clear description of the issue"
    severity: "critical|high|medium|low"
    
  impact_analysis:
    affected_skills: []
    affected_workflows: []
    affected_agents: []
    risk_level: "low|medium|high"
    
  implementation:
    action: "Specific action to take"
    estimated_effort: "Time estimate"
    dependencies: []
    rollback_plan: "How to revert if needed"
    
  validation:
    criteria: "What success looks like"
    measurement: "How to measure success"
    success_threshold: "Quantified threshold"
    
  priority: "critical|high|medium|low"
  proposed_by: "adjustment-proposer"
  proposed_at: "ISO-8601 timestamp"
```

### Priority Assignment Rules

| Priority | Criteria | Response Time |
|----------|----------|---------------|
| **Critical** | Blocks workflow execution, data loss risk | Immediate |
| **High** | Significantly impacts quality or performance | 24 hours |
| **Medium** | Moderate impact, workarounds exist | 1 week |
| **Low** | Minor improvement, no urgency | 1 month |

## Implementation

### Proposal Engine

```python
class AdjustmentProposer:
    def __init__(self, findings, context):
        self.findings = findings
        self.context = context
        self.proposals = []
        
    def generate_proposals(self):
        """Generate adjustment proposals from findings."""
        
        for finding in self.findings:
            proposal = self.create_proposal(finding)
            if proposal:
                self.proposals.append(proposal)
        
        # Sort by priority
        self.proposals.sort(key=lambda p: p['priority'], reverse=True)
        
        return {
            'proposals': self.proposals,
            'summary': self.generate_summary()
        }
    
    def create_proposal(self, finding):
        """Create proposal from finding."""
        
        proposal_types = {
            'missing_skill': self.create_skill_creation_proposal,
            'incomplete_skill': self.create_skill_update_proposal,
            'outdated_skill': self.create_skill_update_proposal,
            'redundant_skill': self.create_skill_merge_proposal,
            'performance_issue': self.create_parameter_tuning_proposal,
            'workflow_issue': self.create_workflow_change_proposal,
            'architecture_issue': self.create_architecture_change_proposal
        }
        
        proposal_type = finding.get('type')
        creator = proposal_types.get(proposal_type)
        
        if creator:
            return creator(finding)
        
        return None
    
    def create_skill_creation_proposal(self, finding):
        """Create skill creation proposal."""
        
        return {
            'proposal_id': self.generate_id(),
            'type': 'skill_creation',
            'target': finding.get('proposed_skill'),
            'trigger': 'gap_analysis',
            'issue': {
                'description': finding.get('description'),
                'severity': finding.get('priority', 'medium')
            },
            'impact_analysis': {
                'affected_skills': self.identify_affected_skills(finding),
                'affected_workflows': self.identify_affected_workflows(finding),
                'risk_level': 'medium'
            },
            'implementation': {
                'action': f"Create {finding.get('proposed_skill')} skill",
                'estimated_effort': '2-3 days',
                'dependencies': self.identify_dependencies(finding),
                'rollback_plan': 'Remove skill if issues found'
            },
            'validation': {
                'criteria': 'Skill functions correctly',
                'measurement': 'Run skill test suite',
                'success_threshold': '> 85% success rate'
            },
            'priority': finding.get('priority', 'medium')
        }
    
    def create_parameter_tuning_proposal(self, finding):
        """Create parameter tuning proposal."""
        
        return {
            'proposal_id': self.generate_id(),
            'type': 'parameter_tuning',
            'target': finding.get('skill'),
            'trigger': 'performance_issue',
            'issue': {
                'description': finding.get('issue'),
                'severity': finding.get('priority', 'medium')
            },
            'impact_analysis': {
                'affected_skills': [finding.get('skill')],
                'affected_workflows': [],
                'risk_level': 'low'
            },
            'implementation': {
                'action': finding.get('recommended_action', 'Tune parameters'),
                'estimated_effort': '1 hour',
                'dependencies': [],
                'rollback_plan': 'Revert parameter changes'
            },
            'validation': {
                'criteria': 'Performance improved',
                'measurement': 'Run performance tests',
                'success_threshold': finding.get('target_metric', 'Improve by 20%')
            },
            'priority': finding.get('priority', 'medium')
        }
    
    def identify_affected_skills(self, finding):
        """Identify skills affected by proposal."""
        
        affected = []
        
        # Find skills that depend on or interact with the target
        for skill in self.context.skill_library:
            if finding.get('proposed_skill') in skill.dependencies:
                affected.append(skill.name)
            if finding.get('target') in skill.interactions:
                affected.append(skill.name)
        
        return affected
    
    def identify_affected_workflows(self, finding):
        """Identify workflows affected by proposal."""
        
        affected = []
        
        # Find workflows that use the target skill
        for workflow in self.context.workflows:
            if finding.get('target') in workflow.skills:
                affected.append(workflow.name)
        
        return affected
    
    def generate_summary(self):
        """Generate proposal summary."""
        
        by_type = {}
        by_priority = {}
        
        for proposal in self.proposals:
            ptype = proposal['type']
            priority = proposal['priority']
            
            by_type[ptype] = by_type.get(ptype, 0) + 1
            by_priority[priority] = by_priority.get(priority, 0) + 1
        
        return {
            'total_proposals': len(self.proposals),
            'by_type': by_type,
            'by_priority': by_priority,
            'estimated_total_effort': self.calculate_total_effort()
        }
    
    def calculate_total_effort(self):
        """Calculate total estimated effort."""
        
        # Simple estimation based on proposal types
        effort_map = {
            'skill_creation': '3 days',
            'skill_update': '2 days',
            'skill_merge': '1 day',
            'skill_retirement': '0.5 days',
            'workflow_change': '2 days',
            'architecture_change': '5 days',
            'parameter_tuning': '1 hour'
        }
        
        total_effort = 0
        for proposal in self.proposals:
            effort = effort_map.get(proposal['type'], '1 day')
            # Convert to days for simplicity
            if 'hour' in effort:
                total_effort += 0.125  # 1 hour = 0.125 days
            else:
                total_effort += int(effort.split()[0])
        
        return f"{total_effort} days"
```

## Output Format

```yaml
adjustment_proposals:
  proposal_id: "ADJ-20250424-001"
  generated_at: "2025-04-24T12:00:00Z"
  trigger: "architecture_self_audit"
  
  proposals:
    - proposal_id: "ADJ-20250424-001-P1"
      type: "parameter_tuning"
      target: "backend-code-generator"
      priority: "high"
      
      issue:
        description: "8% failure rate exceeds 5% threshold"
        severity: "high"
        
      impact_analysis:
        affected_skills: ["backend-code-generator"]
        affected_workflows: ["implementation"]
        risk_level: "low"
        
      implementation:
        action: "Reduce temperature from 0.3 to 0.2"
        estimated_effort: "1 hour"
        rollback_plan: "Revert temperature change"
        
      validation:
        criteria: "Failure rate < 5%"
        measurement: "Run 100 test generations"
        success_threshold: "< 5 failures"
        
    - proposal_id: "ADJ-20250424-001-P2"
      type: "skill_update"
      target: "workflow-orchestrator"
      priority: "high"
      
      issue:
        description: "Lacks ARGUE protocols and meta-argumentation checkpoints"
        severity: "high"
        
      impact_analysis:
        affected_skills: ["workflow-orchestrator", "all-dependent-skills"]
        affected_workflows: ["all-workflows"]
        risk_level: "medium"
        
      implementation:
        action: "Update to v2.1 with ARGUE protocols"
        estimated_effort: "3 days"
        rollback_plan: "Revert to v1.0"
        
      validation:
        criteria: "All workflows execute with ARGUE protocols"
        measurement: "Run full workflow test suite"
        success_threshold: "100% pass rate"
        
  summary:
    total_proposals: 2
    by_type:
      parameter_tuning: 1
      skill_update: 1
    by_priority:
      high: 2
    estimated_total_effort: "3.1 days"
```

## Integration with Aether.go Methodology

- **Input from**: architecture-self-auditor (audit findings), skill-gap-analyzer (gap analysis), meta-skeptic (challenges)
- **Output to**: adjustment-validator (for validation), skill-library-curator (for implementation)
- **Validates with**: correctness-checker (proposal accuracy)
- **Part of**: D8 Meta-Capability Domain

## Validation Rules

- Each proposal MUST include impact analysis
- Implementation plan MUST include rollback strategy
- Validation criteria MUST be quantified
- Priority MUST be assigned based on severity
- Proposals MUST be sorted by priority
- Total effort MUST be estimated
