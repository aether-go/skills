---
name: adjustment-validator
description: Use when validating adjustment proposals from adjustment-proposer, ensuring changes are safe, effective, and aligned with methodology principles
---

# Adjustment Validator

## Overview
Validate adjustment proposals from adjustment-proposer, ensuring changes are safe, effective, and aligned with Aether methodology principles. Acts as a quality gate before implementing proposed adjustments.

## When to Use

```
Adjustment proposals received? ──────────┐
                                         │
Need to validate before implementation? ─┤
                                         ├─► Use adjustment-validator
Quality gate required? ──────────────────┤
                                         │
Change impact assessment needed? ────────┘
```

Use when:
- Adjustment proposals have been generated
- Need to validate proposals before implementation
- Quality gate for changes is required
- Change impact assessment is needed
- Following P9 recursive self-optimization with safety

Don't use when:
- No proposals exist to validate
- Only single trivial change is proposed
- Change has already been validated

## Core Pattern

### Validation Process

```
Adjustment Proposals
    ├── Safety Check
    ├── Effectiveness Check
    ├── Alignment Check
    └── Feasibility Check
         |
         v
    Validation Report
    ├── Approved Proposals
    ├── Rejected Proposals
    └── Modified Proposals
```

### Validation Dimensions

| Dimension | Focus | Criteria |
|-----------|-------|----------|
| **Safety** | Will change cause harm? | No data loss, no workflow breakage |
| **Effectiveness** | Will change solve the issue? | Addresses root cause, measurable improvement |
| **Alignment** | Does change align with principles? | Compliant with P0-P10 |
| **Feasibility** | Can change be implemented? | Resources available, dependencies met |
| **Completeness** | Is proposal complete? | All fields filled, plan detailed |
| **Risk** | What are the risks? | Risk level acceptable, mitigation plan exists |

### Before (Without Validation)
```yaml
proposal:
  type: "skill_update"
  target: "workflow-orchestrator"
  action: "Update to v2.1"
  
approach:
  - "Implement immediately"
  
issues:
  - "No safety check performed"
  - "No rollback plan validated"
  - "No effectiveness measurement"
  - "Change may break existing workflows"
  - "Resource requirements not assessed"
```

### After (With Validation)
```yaml
proposal:
  type: "skill_update"
  target: "workflow-orchestrator"
  action: "Update to v2.1"
  
validation:
  safety:
    status: "PASS"
    checks:
      - "No data loss risk identified"
      - "Rollback plan is viable"
      - "Change is reversible"
      
  effectiveness:
    status: "PASS"
    checks:
      - "Addresses root cause: missing ARGUE protocols"
      - "Measurable improvement: workflow compliance + 30%"
      - "Success criteria are quantified"
      
  alignment:
    status: "PASS"
    checks:
      - "Compliant with P0: Context-adaptation"
      - "Compliant with P9: Recursive optimization"
      - "No principle conflicts identified"
      
  feasibility:
    status: "PASS"
    checks:
      - "Resources available: 3 days estimated"
      - "Dependencies met: ARGUE protocol spec exists"
      - "Skills available for implementation"
      
  completeness:
    status: "PASS"
    checks:
      - "All required fields populated"
      - "Implementation plan is detailed"
      - "Validation criteria are specific"
      
  risk:
    status: "PASS"
    checks:
      - "Risk level: medium (acceptable)"
      - "Mitigation plan exists"
      - "Monitoring plan defined"
      
verdict: "APPROVED"
conditions:
  - "Implement during low-traffic period"
  - "Monitor workflow success rate for 48 hours"
  - "Rollback if success rate drops below 95%"
```

## Quick Reference

### Validation Checklist

#### Safety Check
- [ ] No data loss risk
- [ ] Rollback plan is viable
- [ ] Change is reversible
- [ ] No security vulnerabilities introduced
- [ ] No compliance violations

#### Effectiveness Check
- [ ] Addresses root cause, not just symptoms
- [ ] Improvement is measurable
- [ ] Success criteria are quantified
- [ ] Expected outcome is clearly defined
- [ ] No unintended side effects

#### Alignment Check
- [ ] Compliant with P0-P10 principles
- [ ] Aligns with methodology goals
- [ ] Consistent with existing patterns
- [ ] No conflicts with other proposals
- [ ] Supports long-term architecture

#### Feasibility Check
- [ ] Resources are available
- [ ] Dependencies are met
- [ ] Timeline is realistic
- [ ] Skills are available
- [ ] Budget is sufficient

#### Completeness Check
- [ ] All proposal fields are populated
- [ ] Implementation plan is detailed
- [ ] Validation criteria are specific
- [ ] Rollback plan is documented
- [ ] Monitoring plan is defined

#### Risk Check
- [ ] Risk level is assessed
- [ ] Risk is acceptable
- [ ] Mitigation plan exists
- [ ] Monitoring plan is defined
- [ ] Escalation path is clear

### Verdict Rules

| Dimension Results | Verdict | Action |
|-------------------|---------|--------|
| All PASS | **APPROVED** | Proceed with implementation |
| One WARNING | **APPROVED_WITH_CONDITIONS** | Implement with conditions |
| Multiple WARNINGS | **REVIEW_REQUIRED** | Review and modify proposal |
| One FAIL | **REJECTED** | Reject and request revision |
| Multiple FAIL | **REJECTED** | Reject and request new proposal |

## Implementation

### Validation Engine

```python
class AdjustmentValidator:
    def __init__(self, proposals, context):
        self.proposals = proposals
        self.context = context
        self.results = []
        
    def validate_all(self):
        """Validate all proposals."""
        
        for proposal in self.proposals:
            result = self.validate_proposal(proposal)
            self.results.append(result)
        
        return {
            'results': self.results,
            'summary': self.generate_summary()
        }
    
    def validate_proposal(self, proposal):
        """Validate single proposal."""
        
        checks = {
            'safety': self.check_safety(proposal),
            'effectiveness': self.check_effectiveness(proposal),
            'alignment': self.check_alignment(proposal),
            'feasibility': self.check_feasibility(proposal),
            'completeness': self.check_completeness(proposal),
            'risk': self.check_risk(proposal)
        }
        
        verdict = self.determine_verdict(checks)
        
        return {
            'proposal_id': proposal['proposal_id'],
            'checks': checks,
            'verdict': verdict,
            'conditions': self.generate_conditions(verdict, checks),
            'validated_at': datetime.now().isoformat()
        }
    
    def check_safety(self, proposal):
        """Check if proposal is safe."""
        
        checks = []
        
        # Check for data loss risk
        if proposal['type'] in ['skill_retirement', 'architecture_change']:
            checks.append({
                'check': 'data_loss_risk',
                'status': 'REVIEW' if not proposal.get('data_migration_plan') else 'PASS',
                'message': 'Data migration plan required for retirement/architecture changes'
            })
        
        # Check rollback plan
        if not proposal.get('implementation', {}).get('rollback_plan'):
            checks.append({
                'check': 'rollback_plan',
                'status': 'FAIL',
                'message': 'Rollback plan is required'
            })
        else:
            checks.append({
                'check': 'rollback_plan',
                'status': 'PASS',
                'message': 'Rollback plan exists'
            })
        
        return self.aggregate_check_result(checks)
    
    def check_effectiveness(self, proposal):
        """Check if proposal is effective."""
        
        checks = []
        
        # Check if issue is addressed
        if not proposal.get('issue', {}).get('description'):
            checks.append({
                'check': 'issue_defined',
                'status': 'FAIL',
                'message': 'Issue description is required'
            })
        else:
            checks.append({
                'check': 'issue_defined',
                'status': 'PASS',
                'message': 'Issue is clearly defined'
            })
        
        # Check if success criteria are quantified
        validation = proposal.get('validation', {})
        if not validation.get('success_threshold'):
            checks.append({
                'check': 'quantified_success',
                'status': 'FAIL',
                'message': 'Success threshold must be quantified'
            })
        else:
            checks.append({
                'check': 'quantified_success',
                'status': 'PASS',
                'message': 'Success criteria are quantified'
            })
        
        return self.aggregate_check_result(checks)
    
    def check_alignment(self, proposal):
        """Check if proposal aligns with principles."""
        
        checks = []
        
        # Check principle compliance
        principle_conflicts = self.check_principle_conflicts(proposal)
        if principle_conflicts:
            checks.append({
                'check': 'principle_compliance',
                'status': 'FAIL',
                'message': f"Principle conflicts: {principle_conflicts}"
            })
        else:
            checks.append({
                'check': 'principle_compliance',
                'status': 'PASS',
                'message': 'No principle conflicts'
            })
        
        return self.aggregate_check_result(checks)
    
    def check_feasibility(self, proposal):
        """Check if proposal is feasible."""
        
        checks = []
        
        # Check resource availability
        effort = proposal.get('implementation', {}).get('estimated_effort')
        if not effort:
            checks.append({
                'check': 'effort_estimated',
                'status': 'FAIL',
                'message': 'Effort estimate is required'
            })
        else:
            checks.append({
                'check': 'effort_estimated',
                'status': 'PASS',
                'message': f"Effort estimated: {effort}"
            })
        
        # Check dependencies
        dependencies = proposal.get('implementation', {}).get('dependencies', [])
        unmet_dependencies = [
            dep for dep in dependencies
            if not self.is_dependency_met(dep)
        ]
        
        if unmet_dependencies:
            checks.append({
                'check': 'dependencies_met',
                'status': 'FAIL',
                'message': f"Unmet dependencies: {unmet_dependencies}"
            })
        else:
            checks.append({
                'check': 'dependencies_met',
                'status': 'PASS',
                'message': 'All dependencies are met'
            })
        
        return self.aggregate_check_result(checks)
    
    def check_completeness(self, proposal):
        """Check if proposal is complete."""
        
        required_fields = [
            'proposal_id', 'type', 'target', 'issue',
            'impact_analysis', 'implementation', 'validation'
        ]
        
        missing_fields = [
            field for field in required_fields
            if not proposal.get(field)
        ]
        
        if missing_fields:
            return {
                'status': 'FAIL',
                'checks': [{
                    'check': 'required_fields',
                    'status': 'FAIL',
                    'message': f"Missing fields: {missing_fields}"
                }]
            }
        
        return {
            'status': 'PASS',
            'checks': [{
                'check': 'required_fields',
                'status': 'PASS',
                'message': 'All required fields are present'
            }]
        }
    
    def check_risk(self, proposal):
        """Check risk level of proposal."""
        
        risk_level = proposal.get('impact_analysis', {}).get('risk_level', 'medium')
        
        checks = []
        
        # Check if risk level is acceptable
        if risk_level == 'high' and not proposal.get('risk_mitigation_plan'):
            checks.append({
                'check': 'risk_mitigation',
                'status': 'FAIL',
                'message': 'High risk proposals require mitigation plan'
            })
        else:
            checks.append({
                'check': 'risk_mitigation',
                'status': 'PASS',
                'message': f"Risk level {risk_level} is acceptable"
            })
        
        return self.aggregate_check_result(checks)
    
    def determine_verdict(self, checks):
        """Determine final verdict based on checks."""
        
        statuses = [check['status'] for check in checks.values()]
        
        if 'FAIL' in statuses:
            return 'REJECTED'
        elif statuses.count('WARNING') > 1:
            return 'REVIEW_REQUIRED'
        elif 'WARNING' in statuses:
            return 'APPROVED_WITH_CONDITIONS'
        else:
            return 'APPROVED'
    
    def generate_conditions(self, verdict, checks):
        """Generate conditions for approval."""
        
        conditions = []
        
        if verdict == 'APPROVED_WITH_CONDITIONS':
            for dimension, result in checks.items():
                if result['status'] == 'WARNING':
                    conditions.append(f"Address {dimension} concerns before implementation")
        
        if verdict == 'APPROVED':
            conditions.append("Monitor for 48 hours after implementation")
            conditions.append("Rollback if success rate drops below 95%")
        
        return conditions
    
    def aggregate_check_result(self, checks):
        """Aggregate individual check results."""
        
        statuses = [check['status'] for check in checks]
        
        if 'FAIL' in statuses:
            status = 'FAIL'
        elif 'WARNING' in statuses:
            status = 'WARNING'
        else:
            status = 'PASS'
        
        return {
            'status': status,
            'checks': checks
        }
    
    def generate_summary(self):
        """Generate validation summary."""
        
        approved = sum(1 for r in self.results if r['verdict'] == 'APPROVED')
        approved_with_conditions = sum(1 for r in self.results if r['verdict'] == 'APPROVED_WITH_CONDITIONS')
        review_required = sum(1 for r in self.results if r['verdict'] == 'REVIEW_REQUIRED')
        rejected = sum(1 for r in self.results if r['verdict'] == 'REJECTED')
        
        return {
            'total': len(self.results),
            'approved': approved,
            'approved_with_conditions': approved_with_conditions,
            'review_required': review_required,
            'rejected': rejected
        }
```

## Output Format

```yaml
validation_results:
  validation_id: "VAL-20250424-001"
  validated_at: "2025-04-24T12:00:00Z"
  validator: "adjustment-validator"
  
  results:
    - proposal_id: "ADJ-20250424-001-P1"
      verdict: "APPROVED"
      
      checks:
        safety:
          status: "PASS"
          checks:
            - check: "rollback_plan"
              status: "PASS"
              message: "Rollback plan exists"
              
        effectiveness:
          status: "PASS"
          checks:
            - check: "quantified_success"
              status: "PASS"
              message: "Success criteria are quantified"
              
        alignment:
          status: "PASS"
          checks:
            - check: "principle_compliance"
              status: "PASS"
              message: "No principle conflicts"
              
        feasibility:
          status: "PASS"
          checks:
            - check: "effort_estimated"
              status: "PASS"
              message: "Effort estimated: 1 hour"
              
        completeness:
          status: "PASS"
          checks:
            - check: "required_fields"
              status: "PASS"
              message: "All required fields are present"
              
        risk:
          status: "PASS"
          checks:
            - check: "risk_mitigation"
              status: "PASS"
              message: "Risk level low is acceptable"
              
      conditions:
        - "Monitor for 48 hours after implementation"
        - "Rollback if success rate drops below 95%"
        
    - proposal_id: "ADJ-20250424-001-P2"
      verdict: "APPROVED_WITH_CONDITIONS"
      
      checks:
        safety:
          status: "PASS"
          
        effectiveness:
          status: "PASS"
          
        alignment:
          status: "WARNING"
          checks:
            - check: "principle_compliance"
              status: "WARNING"
              message: "May impact P8: Human-AI boundary during transition"
              
        feasibility:
          status: "PASS"
          
        completeness:
          status: "PASS"
          
        risk:
          status: "PASS"
          
      conditions:
        - "Address alignment concerns before implementation"
        - "Ensure human oversight during transition"
        - "Monitor for 48 hours after implementation"
        
  summary:
    total: 2
    approved: 1
    approved_with_conditions: 1
    review_required: 0
    rejected: 0
```

## Integration with Aether.go Methodology

- **Input from**: adjustment-proposer (proposals)
- **Output to**: skill-library-curator (approved changes), adjustment-proposer (rejected proposals)
- **Validates with**: correctness-checker (validation accuracy)
- **Part of**: D8 Meta-Capability Domain

## Validation Rules

- All 6 dimensions MUST be checked
- Verdict MUST be one of: APPROVED, APPROVED_WITH_CONDITIONS, REVIEW_REQUIRED, REJECTED
- Conditions MUST be provided for non-APPROVED verdicts
- Rejected proposals MUST include reason
- All checks MUST include specific messages
- Summary MUST include counts by verdict
