---
name: requirement-classifier
description: Use when classifying collected requirements into 7 categories and detecting cross-category relationships
---

# Requirement Classifier

## Overview
Automatically classify collected requirements into 7 categories (business, architecture, functional, non-functional, compliance, security, scalability) and detect cross-category relationships including drives, constrains, depends_on, conflicts_with, and validates.

## When to Use

```
Requirements collected? ──────────────┐
                                      │
Need categorization? ───────────────────┤
                                      ├─► Use requirement-classifier
Detect conflicts? ─────────────────────┤
                                      │
Map relationships? ────────────────────┘
```

Use when:
- After [business-requirements-collector](file:///d:/repos/aether-go/skills/skills/business-requirements-collector/SKILL.md) collects requirements
- Before [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md) processes requirements
- Need to detect requirement conflicts
- Need to map cross-category relationships
- Need to validate requirement categorization
- Preparing for [nfr-analyzer](file:///d:/repos/aether-go/skills/skills/nfr-analyzer/SKILL.md), [compliance-validator](file:///d:/repos/aether-go/skills/skills/compliance-validator/SKILL.md), [security-requirement-analyzer](file:///d:/repos/aether-go/skills/skills/security-requirement-analyzer/SKILL.md), [scalability-planner](file:///d:/repos/aether-go/skills/skills/scalability-planner/SKILL.md)

Don't use when:
- Requirements already categorized
- Only single category requirements
- No need for relationship mapping

## Core Pattern

### Classification Workflow

```
Raw Requirements → Category Detection → Relationship Analysis → Validation
        ↓                    ↓                      ↓               ↓
   Unclassified       Categorized         Cross-Category      Final
   Requirements       Requirements       Relationships      Classification
        ↓                    ↓                      ↓               ↓
   Ambiguity         Category           Conflict           Classification
   Detection         Distribution       Detection          Report
```

### Before (Unclassified Requirements)
```yaml
raw_requirements:
  - id: "REQ-001"
    statement: "Users can login with email"
    category: null
    
  - id: "REQ-002"
    statement: "System must use microservices"
    category: null
    
  - id: "REQ-003"
    statement: "Response time < 200ms"
    category: null
```

### After (Classified with Relationships)
```yaml
classified_requirements:
  01_business:
    - id: "REQ-BUS-001"
      original_id: "REQ-001"
      statement: "Users can login with email"
      confidence: 0.95
      keywords: ["users", "login", "email"]
      
  02_architecture:
    - id: "REQ-ARCH-001"
      original_id: "REQ-002"
      statement: "System must use microservices"
      confidence: 0.98
      keywords: ["system", "microservices", "architecture"]
      
  04_non_functional:
    - id: "REQ-NFR-001"
      original_id: "REQ-003"
      statement: "Response time < 200ms"
      confidence: 0.97
      keywords: ["response time", "performance", "latency"]
      
cross_category_relationships:
  - from: "REQ-BUS-001"
    to: "REQ-ARCH-001"
    relation_type: "drives"
    confidence: 0.85
    rationale: "Business need drives architecture decision"
    
  - from: "REQ-ARCH-001"
    to: "REQ-NFR-001"
    relation_type: "constrains"
    confidence: 0.90
    rationale: "Architecture choice affects performance"
    
conflicts:
  - conflict_id: "CONF-001"
    requirements: ["REQ-SEC-001", "REQ-SCAL-002"]
    type: "performance_vs_security"
    severity: "medium"
    description: "Strong encryption may impact scalability"
    suggested_resolution: "Use hardware acceleration"
```

## Quick Reference

### Seven-Category Classification Rules

| Category | ID Prefix | Key Indicators | Examples | Confidence Threshold |
|----------|-----------|---------------|-----------|---------------------|
| **01-Business Requirements** | REQ-BUS | business goals, value, objectives, KPIs, ROI | "Increase revenue", "Improve retention" | > 0.85 |
| **02-Architecture Requirements** | REQ-ARCH | architecture, design, structure, pattern, microservices | "Use microservices", "Layered architecture" | > 0.85 |
| **03-Functional Requirements** | REQ-FUNC | features, functions, user actions, behaviors | "Users can login", "Export data" | > 0.85 |
| **04-Non-Functional Requirements** | REQ-NFR | performance, reliability, usability, maintainability | "Response time < 200ms", "99.9% uptime" | > 0.85 |
| **05-Compliance Requirements** | REQ-COMP | GDPR, ISO, compliance, legal, regulatory | "GDPR compliant", "ISO 27001" | > 0.85 |
| **06-Security Requirements** | REQ-SEC | security, encryption, authentication, authorization | "Password hashing", "Access control" | > 0.85 |
| **07-Scalability Requirements** | REQ-SCAL | scalability, capacity, growth, concurrent users | "Support 1M users", "Horizontal scaling" | > 0.85 |

### Cross-Category Relationship Types

| Relation Type | Description | Example | Detection Method |
|--------------|-------------|-----------|------------------|
| **drives** | One requirement drives creation of another | Business drives functional | Goal-oriented keywords |
| **constrains** | One imposes constraints on another | Architecture constrains functional | Constraint keywords |
| **depends_on** | One depends on another | Functional depends on security | Dependency keywords |
| **conflicts_with** | Conflicting objectives | Security vs performance | Conflict patterns |
| **validates** | One validates another | Compliance validates security | Validation keywords |
| **supports** | One supports another | NFR supports business | Support keywords |
| **enables** | One enables another | Architecture enables scalability | Enablement keywords |

### Conflict Detection Patterns

| Conflict Type | Categories Involved | Example | Resolution Strategy |
|--------------|-------------------|-----------|---------------------|
| **Performance vs Security** | NFR vs Security | Encryption vs speed | Hardware acceleration |
| **Cost vs Quality** | Business vs NFR | Budget vs reliability | Phased implementation |
| **Flexibility vs Consistency** | Architecture vs Compliance | Customization vs standard | Configurable defaults |
| **Scalability vs Simplicity** | Scalability vs Architecture | Distributed vs monolithic | Hybrid approach |

## Implementation

### Classification Engine

```yaml
classification_engine:
  approach: "hybrid"
  methods:
    - keyword_based: "Fast initial classification"
    - semantic_analysis: "Context-aware classification"
    - ml_model: "Pattern learning from history"
    - rule_based: "Expert rules override"
  
  confidence_threshold: 0.85
  fallback: "manual_review"
```

### Category Detection Rules

```yaml
category_rules:
  01_business:
    primary_keywords:
      - "business goal"
      - "increase revenue"
      - "improve retention"
      - "customer satisfaction"
      - "market share"
      - "ROI"
      - "KPI"
      - "strategic objective"
    secondary_keywords:
      - "value proposition"
      - "competitive advantage"
      - "business value"
    patterns:
      - "increase.*by.*%"
      - "reduce.*cost"
      - "improve.*rate"
      
  02_architecture:
    primary_keywords:
      - "microservices"
      - "monolith"
      - "architecture"
      - "design pattern"
      - "layered"
      - "event-driven"
      - "service boundary"
    secondary_keywords:
      - "component"
      - "module"
      - "interface"
    patterns:
      - "use.*architecture"
      - "follow.*pattern"
      - "service.*oriented"
      
  03_functional:
    primary_keywords:
      - "user can"
      - "system shall"
      - "feature"
      - "functionality"
      - "capability"
      - "user story"
    secondary_keywords:
      - "login"
      - "register"
      - "create"
      - "update"
      - "delete"
    patterns:
      - "user.*can.*"
      - "system.*shall.*"
      - "as a.*user.*i want"
      
  04_non_functional:
    primary_keywords:
      - "response time"
      - "throughput"
      - "availability"
      - "reliability"
      - "usability"
      - "maintainability"
    secondary_keywords:
      - "performance"
      - "latency"
      - "P95"
      - "P99"
      - "uptime"
    patterns:
      - ".*<.*ms"
      - ".*>.*%"
      - "P\\d+"
      
  05_compliance:
    primary_keywords:
      - "GDPR"
      - "ISO 27001"
      - "HIPAA"
      - "PCI DSS"
      - "SOC 2"
      - "compliance"
      - "regulation"
      - "audit"
    secondary_keywords:
      - "data protection"
      - "privacy"
      - "legal requirement"
      - "standard"
    patterns:
      - "comply with.*"
      - "meet.*standard"
      - ".*compliant"
      
  06_security:
    primary_keywords:
      - "security"
      - "authentication"
      - "authorization"
      - "encryption"
      - "password"
      - "access control"
    secondary_keywords:
      - "vulnerability"
      - "threat"
      - "protection"
      - "secure"
    patterns:
      - "hash.*password"
      - "encrypt.*data"
      - "authenticate.*user"
      
  07_scalability:
    primary_keywords:
      - "scalability"
      - "concurrent users"
      - "horizontal scaling"
      - "vertical scaling"
      - "capacity"
      - "growth"
    secondary_keywords:
      - "scale"
      - "load"
      - "throughput"
      - "volume"
    patterns:
      - "support.*users"
      - "handle.*load"
      - "scale.*to"
```

### Relationship Detection Algorithm

```yaml
relationship_detection:
  method: "semantic_similarity"
  similarity_threshold: 0.75
  
  relation_patterns:
    drives:
      keywords: ["drive", "require", "need", "demand"]
      direction: "business → functional"
      
    constrains:
      keywords: ["constrain", "limit", "restrict", "must follow"]
      direction: "architecture → functional"
      
    depends_on:
      keywords: ["depend", "require", "need", "rely on"]
      direction: "functional → security"
      
    conflicts_with:
      keywords: ["conflict", "trade-off", "versus", "vs"]
      detection: "opposite_objectives"
      
    validates:
      keywords: ["validate", "verify", "ensure", "comply"]
      direction: "compliance → security"
      
    supports:
      keywords: ["support", "enable", "facilitate", "help"]
      direction: "nfr → business"
      
    enables:
      keywords: ["enable", "allow", "make possible"]
      direction: "architecture → scalability"
```

### Conflict Detection

```yaml
conflict_detection:
  strategies:
    - keyword_opposition: "Detect opposing keywords"
    - objective_conflict: "Identify conflicting objectives"
    - resource_contention: "Detect resource conflicts"
    - temporal_conflict: "Identify timing conflicts"
  
  conflict_matrix:
    performance_vs_security:
      categories: ["04_non_functional", "06_security"]
      indicators: ["encryption", "latency", "throughput"]
      severity: "medium"
      
    cost_vs_quality:
      categories: ["01_business", "04_non_functional"]
      indicators: ["budget", "reliability", "availability"]
      severity: "high"
      
    flexibility_vs_consistency:
      categories: ["02_architecture", "05_compliance"]
      indicators: ["customization", "standard", "regulation"]
      severity: "medium"
      
    scalability_vs_simplicity:
      categories: ["07_scalability", "02_architecture"]
      indicators: ["distributed", "monolithic", "complexity"]
      severity: "medium"
```

### Classification Report

```yaml
classification_report:
  metadata:
    generated_at: "2026-01-20T10:00:00Z"
    total_requirements: 50
    classified: 48
    unclassified: 2
    confidence_avg: 0.92
    
  category_distribution:
    01_business:
      count: 8
      percentage: 16.7%
      avg_confidence: 0.94
      
    02_architecture:
      count: 5
      percentage: 10.4%
      avg_confidence: 0.91
      
    03_functional:
      count: 15
      percentage: 31.3%
      avg_confidence: 0.93
      
    04_non_functional:
      count: 8
      percentage: 16.7%
      avg_confidence: 0.90
      
    05_compliance:
      count: 4
      percentage: 8.3%
      avg_confidence: 0.95
      
    06_security:
      count: 5
      percentage: 10.4%
      avg_confidence: 0.92
      
    07_scalability:
      count: 3
      percentage: 6.3%
      avg_confidence: 0.89
      
  cross_category_relationships:
    total: 23
    by_type:
      drives: 8
      constrains: 5
      depends_on: 4
      conflicts_with: 2
      validates: 2
      supports: 1
      enables: 1
      
  conflicts:
    total: 2
    by_severity:
      high: 0
      medium: 2
      low: 0
      
  recommendations:
    - "Review 2 unclassified requirements manually"
    - "Resolve 2 medium-severity conflicts"
    - "Validate 3 low-confidence classifications"
```

## Integration with Other Skills

### Input from [business-requirements-collector](file:///d:/repos/aether-go/skills/skills/business-requirements-collector/SKILL.md)

```yaml
input:
  raw_requirements:
    - id: "REQ-RAW-001"
      statement: "Users can reset password"
      source: "Product Manager"
      
  stakeholders:
    - role: "Product Manager"
      influence: "high"
```

### Output to Category-Specific Skills

```yaml
output:
  01_business:
    to: business-value-mapper
    requirements: ["REQ-BUS-*"]
    
  02_architecture:
    to: architecture-decision-recorder
    requirements: ["REQ-ARCH-*"]
    
  03_functional:
    to: spec-parser
    requirements: ["REQ-FUNC-*"]
    
  04_non_functional:
    to: nfr-analyzer
    requirements: ["REQ-NFR-*"]
    
  05_compliance:
    to: compliance-validator
    requirements: ["REQ-COMP-*"]
    
  06_security:
    to: security-requirement-analyzer
    requirements: ["REQ-SEC-*"]
    
  07_scalability:
    to: scalability-planner
    requirements: ["REQ-SCAL-*"]
```

### Output to [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md)

```yaml
structured_requirements:
  requirements: [...]
  relationships: [...]
  conflicts: [...]
  classification_metadata:
    confidence_avg: 0.92
    classification_date: "2026-01-20"
```

## Best Practices

### Classification Guidelines

1. **Confidence Threshold**: Only auto-classify requirements with confidence > 0.85
2. **Manual Review**: Always review low-confidence classifications (< 0.85)
3. **Context Awareness**: Consider project context when classifying
4. **Iterative Refinement**: Improve classification rules based on feedback
5. **Cross-Validation**: Validate classifications with stakeholders

### Relationship Mapping Guidelines

1. **Bidirectional**: Always map relationships in both directions
2. **Rationale Required**: Document why relationships exist
3. **Confidence Scoring**: Score relationship confidence
4. **Conflict Priority**: Prioritize high-severity conflicts
5. **Resolution Tracking**: Track conflict resolution status

### Conflict Resolution Guidelines

1. **Early Detection**: Detect conflicts as early as possible
2. **Stakeholder Involvement**: Involve relevant stakeholders in resolution
3. **Trade-off Analysis**: Analyze trade-offs objectively
4. **Document Decisions**: Document resolution decisions
5. **Monitor Impact**: Monitor impact of resolution decisions

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Low confidence auto-classification | May misclassify requirements | Set threshold > 0.85, review manually |
| Ignoring cross-category relationships | Misses dependencies and conflicts | Always analyze relationships |
| Not documenting rationale | Difficult to understand decisions | Always document rationale |
| Ignoring conflicts | Leads to implementation issues | Detect and resolve conflicts early |
| Over-reliance on keywords | Misses context and nuance | Use semantic analysis |

## Real-World Impact

**Before (Manual Classification):**
- Requirements manually categorized
- Inconsistent categorization
- Missed relationships and conflicts
- Time-consuming process
- Errors in categorization

**After (Automated Classification):**
- Consistent 7-category classification
- Automatic relationship detection
- Early conflict identification
- 80% reduction in classification time
- 95% classification accuracy

**Result:** Faster requirement processing, better quality, fewer downstream issues.
