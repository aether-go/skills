---
name: architecture-self-auditor
description: Use when auditing the architecture for coverage, redundancy, bottleneck, balance, evolution, and semantic risk dimensions
---

# Architecture Self-Auditor

## Overview
Audit the architecture for coverage, redundancy, bottleneck, balance, evolution, and semantic risk dimensions. Provides comprehensive assessment of the Aether methodology implementation, identifying areas for improvement and optimization.

## When to Use

```
Architecture established? ───────────────┐
                                         │
Need comprehensive audit? ───────────────┤
                                         ├─► Use architecture-self-auditor
Periodic review required? ───────────────┤
                                         │
Quality assessment needed? ──────────────┘
```

Use when:
- Architecture is established and needs assessment
- Periodic review is required (recommended monthly)
- Quality assessment of methodology implementation is needed
- Preparing for optimization or refactoring
- Following P9 recursive self-optimization

Don't use when:
- Architecture is not yet established
- Only single dimension needs checking
- Only code review is needed

## Core Pattern

### Architecture Audit Dimensions

```
Architecture Assessment
    ├── Coverage Audit
    ├── Redundancy Audit
    ├── Bottleneck Audit
    ├── Balance Audit
    ├── Evolution Audit
    └── Semantic Risk Audit
         |
         v
    Comprehensive Audit Report
```

### Audit Dimensions

| Dimension | Focus | Metrics | Target |
|-----------|-------|---------|--------|
| **Coverage** | Are methodology elements supported by skills? | Coverage % | > 95% |
| **Redundancy** | Are there overlapping skills? | Overlap score | < 10% |
| **Bottleneck** | Are there frequently failing/timing out skills? | Failure rate, P95 latency | < 5%, < 30s |
| **Balance** | Is skill count balanced across domains? | Standard deviation | < 2 |
| **Evolution** | Is skill library continuously updated? | Update frequency, retirement rate | > 1/month, < 5% |
| **Semantic Risk** | Frequency of semantic checkpoint triggers and user correction rate | Clarification count, major correction count | < 3/session, < 10% |

### Before (Without Self-Audit)
```yaml
architecture:
  skills_count: 50
  domains: 7
  
issues:
  - "D1 has 15 skills, D8 has 3 skills (unbalanced)"
  - "3 skills have 90% overlap in functionality"
  - "backend-code-generator fails 20% of the time"
  - "No skills updated in 3 months"
  - "Semantic checkpoints triggered 10 times in last session"
  
result:
  - Inefficient skill usage
  - Redundant maintenance
  - Unreliable workflow
  - Stagnant methodology
  - Poor user experience
```

### After (With Self-Audit)
```yaml
architecture:
  skills_count: 49
  domains: 8
  
audit:
  coverage:
    status: "PASS"
    coverage: 97%
    missing: ["mobile-specific-skills"]
    
  redundancy:
    status: "WARNING"
    overlap_score: 12%
    overlapping_skills:
      - ["backend-code-generator", "api-generator"]
      - ["test-generator", "unit-test-generator"]
      
  bottleneck:
    status: "WARNING"
    failing_skills:
      - skill: "backend-code-generator"
        failure_rate: 8%
        p95_latency: 45s
        
  balance:
    status: "PASS"
    domain_distribution:
      D1: 8, D2: 7, D3: 8, D4: 6, D5: 8, D6: 5, D7: 8, D8: 9
    std_deviation: 1.2
    
  evolution:
    status: "PASS"
    update_frequency: 2/month
    retirement_rate: 3%
    
  semantic_risk:
    status: "PASS"
    clarification_count: 2
    major_correction_count: 1
    correction_rate: 5%
    
recommendations:
  - "Merge backend-code-generator and api-generator"
  - "Optimize backend-code-generator performance"
  - "Add mobile-specific skills to improve coverage"
```

## Quick Reference

### Audit Checklist

#### Coverage Audit
- [ ] All methodology elements have supporting skills
- [ ] All derivation layers (L1-L5) have skills
- [ ] All scenario modes have skills
- [ ] All constitutional principles have validation skills
- [ ] Gap analysis completed

#### Redundancy Audit
- [ ] No skills have > 80% functional overlap
- [ ] Similar skills have clear differentiation
- [ ] Skill responsibilities are well-defined
- [ ] No duplicate functionality across domains

#### Bottleneck Audit
- [ ] All skills have failure rate < 5%
- [ ] All skills have P95 latency < 30s
- [ ] No skills timeout frequently
- [ ] Resource usage is within limits

#### Balance Audit
- [ ] Skill count standard deviation < 2
- [ ] No domain has < 3 skills
- [ ] No domain has > 12 skills
- [ ] Distribution is approximately uniform

#### Evolution Audit
- [ ] Skills updated within last month
- [ ] Retirement rate < 5%
- [ ] New skills added for emerging needs
- [ ] Deprecated skills removed

#### Semantic Risk Audit
- [ ] Clarification count < 3 per session
- [ ] Major correction count < 1 per session
- [ ] Correction rate < 10%
- [ ] Semantic checkpoints are effective

## Implementation

### Audit Engine

```python
class ArchitectureSelfAuditor:
    def __init__(self, skill_library, usage_metrics):
        self.skills = skill_library
        self.metrics = usage_metrics
        self.audit_results = {}
        
    def perform_audit(self):
        """Perform comprehensive architecture audit."""
        
        self.audit_coverage()
        self.audit_redundancy()
        self.audit_bottleneck()
        self.audit_balance()
        self.audit_evolution()
        self.audit_semantic_risk()
        
        return {
            'overall_status': self.determine_overall_status(),
            'dimensions': self.audit_results,
            'recommendations': self.generate_recommendations()
        }
    
    def audit_coverage(self):
        """Audit methodology coverage by skills."""
        
        methodology_elements = self.get_methodology_elements()
        covered_elements = set()
        
        for skill in self.skills:
            for element in skill.supports:
                covered_elements.add(element)
        
        coverage = len(covered_elements) / len(methodology_elements)
        
        self.audit_results['coverage'] = {
            'status': 'PASS' if coverage > 0.95 else 'WARNING' if coverage > 0.85 else 'FAIL',
            'coverage': coverage,
            'missing': list(methodology_elements - covered_elements)
        }
    
    def audit_redundancy(self):
        """Audit skill redundancy."""
        
        overlaps = []
        
        for i, skill1 in enumerate(self.skills):
            for skill2 in self.skills[i+1:]:
                overlap = self.calculate_overlap(skill1, skill2)
                if overlap > 0.8:
                    overlaps.append({
                        'skills': [skill1.name, skill2.name],
                        'overlap': overlap
                    })
        
        overlap_score = len(overlaps) / len(self.skills) if self.skills else 0
        
        self.audit_results['redundancy'] = {
            'status': 'PASS' if overlap_score < 0.1 else 'WARNING',
            'overlap_score': overlap_score,
            'overlapping_skills': overlaps
        }
    
    def audit_bottleneck(self):
        """Audit skill performance bottlenecks."""
        
        failing_skills = []
        
        for skill in self.skills:
            metrics = self.metrics.get(skill.name, {})
            failure_rate = metrics.get('failure_rate', 0)
            p95_latency = metrics.get('p95_latency', 0)
            
            if failure_rate > 0.05 or p95_latency > 30:
                failing_skills.append({
                    'skill': skill.name,
                    'failure_rate': failure_rate,
                    'p95_latency': p95_latency
                })
        
        self.audit_results['bottleneck'] = {
            'status': 'PASS' if not failing_skills else 'WARNING',
            'failing_skills': failing_skills
        }
    
    def audit_balance(self):
        """Audit skill distribution balance across domains."""
        
        domain_counts = {}
        for skill in self.skills:
            domain = skill.domain
            domain_counts[domain] = domain_counts.get(domain, 0) + 1
        
        counts = list(domain_counts.values())
        mean = sum(counts) / len(counts) if counts else 0
        variance = sum((c - mean) ** 2 for c in counts) / len(counts) if counts else 0
        std_deviation = variance ** 0.5
        
        self.audit_results['balance'] = {
            'status': 'PASS' if std_deviation < 2 else 'WARNING',
            'domain_distribution': domain_counts,
            'std_deviation': std_deviation
        }
    
    def audit_evolution(self):
        """Audit skill library evolution."""
        
        updates_last_month = sum(
            1 for skill in self.skills
            if skill.last_updated > (datetime.now() - timedelta(days=30))
        )
        
        retirement_rate = len([s for s in self.skills if s.status == 'retired']) / len(self.skills) if self.skills else 0
        
        self.audit_results['evolution'] = {
            'status': 'PASS' if updates_last_month > 0 and retirement_rate < 0.05 else 'WARNING',
            'update_frequency': updates_last_month,
            'retirement_rate': retirement_rate
        }
    
    def audit_semantic_risk(self):
        """Audit semantic risk from clarifications."""
        
        sessions = self.metrics.get('sessions', [])
        
        total_clarifications = sum(s.get('clarification_count', 0) for s in sessions)
        total_corrections = sum(s.get('major_correction_count', 0) for s in sessions)
        total_sessions = len(sessions)
        
        avg_clarifications = total_clarifications / total_sessions if total_sessions else 0
        avg_corrections = total_corrections / total_sessions if total_sessions else 0
        correction_rate = total_corrections / total_clarifications if total_clarifications else 0
        
        self.audit_results['semantic_risk'] = {
            'status': 'PASS' if avg_clarifications < 3 and correction_rate < 0.1 else 'WARNING',
            'clarification_count': avg_clarifications,
            'major_correction_count': avg_corrections,
            'correction_rate': correction_rate
        }
    
    def generate_recommendations(self):
        """Generate optimization recommendations."""
        
        recommendations = []
        
        for dimension, result in self.audit_results.items():
            if result['status'] != 'PASS':
                recommendations.extend(
                    self.get_recommendations_for_dimension(dimension, result)
                )
        
        return recommendations
```

## Output Format

```yaml
architecture_audit:
  audit_id: "aa-20250424-001"
  timestamp: "2025-04-24T12:00:00Z"
  auditor: "architecture-self-auditor"
  
  overall_status: "WARNING"
  
  dimensions:
    coverage:
      status: "PASS"
      coverage: 0.97
      missing: ["mobile-specific-skills"]
      
    redundancy:
      status: "WARNING"
      overlap_score: 0.12
      overlapping_skills:
        - skills: ["backend-code-generator", "api-generator"]
          overlap: 0.85
          
    bottleneck:
      status: "WARNING"
      failing_skills:
        - skill: "backend-code-generator"
          failure_rate: 0.08
          p95_latency: 45
          
    balance:
      status: "PASS"
      domain_distribution:
        D1: 8, D2: 7, D3: 8, D4: 6, D5: 8, D6: 5, D7: 8, D8: 9
      std_deviation: 1.2
      
    evolution:
      status: "PASS"
      update_frequency: 2
      retirement_rate: 0.03
      
    semantic_risk:
      status: "PASS"
      clarification_count: 2
      major_correction_count: 1
      correction_rate: 0.05
      
  recommendations:
    - dimension: "redundancy"
      priority: "high"
      action: "Merge backend-code-generator and api-generator"
      rationale: "85% functional overlap"
      
    - dimension: "bottleneck"
      priority: "high"
      action: "Optimize backend-code-generator performance"
      rationale: "8% failure rate exceeds 5% threshold"
      
    - dimension: "coverage"
      priority: "medium"
      action: "Add mobile-specific skills"
      rationale: "Mobile development not covered"
```

## Integration with Aether.go Methodology

- **Input from**: skill-library-curator (skill data), context-manager (usage metrics)
- **Output to**: adjustment-proposer (optimization recommendations), skill-library-curator (skill updates)
- **Validates with**: correctness-checker (audit accuracy)
- **Part of**: D8 Meta-Capability Domain (META-004)

## Validation Rules

- All 6 dimensions MUST be audited
- Overall status MUST reflect worst dimension status
- Recommendations MUST be provided for non-PASS dimensions
- Audit MUST be performed periodically (recommended monthly)
- Metrics MUST be based on actual usage data
- Recommendations MUST include priority and rationale
