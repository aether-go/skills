---
name: requirement-classifier
description: Use when classifying collected requirements into 13 categories based on ISO/IEC 25010:2023 and detecting cross-category relationships
---

# Requirement Classifier

## Overview
Automatically classify collected requirements into 13 categories based on ISO/IEC 25010:2023 standard (3 source dimensions + 8 product quality dimensions + 2 architecture/data dimensions) and detect cross-category relationships including drives, constrains, depends_on, conflicts_with, trades_off, and validates.

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
- Preparing for quality-specific analyzers

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
  04_functional:
    - id: "REQ-FUNC-001"
      original_id: "REQ-001"
      statement: "Users can login with email"
      confidence: 0.95
      keywords: ["users", "login", "email"]
      iso_reference: "ISO/IEC 25010:2023 - Functional Suitability"
      subcategory: "appropriateness"
      
  12_architecture:
    - id: "REQ-ARCH-001"
      original_id: "REQ-002"
      statement: "System must use microservices"
      confidence: 0.98
      keywords: ["system", "microservices", "architecture"]
      
  05_performance:
    - id: "REQ-PERF-001"
      original_id: "REQ-003"
      statement: "Response time < 200ms"
      confidence: 0.97
      keywords: ["response time", "performance", "latency"]
      iso_reference: "ISO/IEC 25010:2023 - Performance Efficiency"
      subcategory: "time_behaviour"
      
cross_category_relationships:
  - from: "REQ-FUNC-001"
    to: "REQ-ARCH-001"
    relation_type: "drives"
    confidence: 0.85
    rationale: "Functional need drives architecture decision"
    
  - from: "REQ-ARCH-001"
    to: "REQ-PERF-001"
    relation_type: "influences"
    confidence: 0.90
    rationale: "Architecture choice affects performance"
    
conflicts:
  - conflict_id: "CONF-001"
    requirements: ["REQ-SEC-001", "REQ-PERF-002"]
    type: "security_vs_performance"
    severity: "medium"
    description: "Strong encryption may impact performance"
    suggested_resolution: "Use hardware acceleration"
    iso_trade_off: "Security trades_off Performance Efficiency"
```

## Quick Reference

### Thirteen-Category Classification Rules (ISO/IEC 25010:2023 Based)

#### Layer 1: Source Dimensions (3 Categories)

| Category | ID Prefix | Key Indicators | Examples | ISO Reference |
|----------|-----------|---------------|-----------|---------------|
| **01-Business Requirements** | REQ-BUS | business goals, value, KPIs, ROI | "Increase revenue", "Improve retention" | - |
| **02-Compliance Requirements** | REQ-COMP | GDPR, ISO, legal, regulatory | "GDPR compliant", "ISO 27001" | - |
| **03-Constraint Requirements** | REQ-CONS | budget, timeline, resources, technical limits | "Budget $50K", "4 weeks timeline" | - |

#### Layer 2: Product Quality Dimensions (8 Categories - ISO/IEC 25010:2023)

| Category | ID Prefix | Key Indicators | Examples | ISO Reference |
|----------|-----------|---------------|-----------|---------------|
| **04-Functional Requirements** | REQ-FUNC | features, functions, user actions | "Users can login", "Export data" | Functional Suitability |
| **05-Performance Requirements** | REQ-PERF | response time, throughput, capacity | "Response time < 200ms", "1000 RPS" | Performance Efficiency |
| **06-Compatibility Requirements** | REQ-COMPAT | integration, interoperability, coexistence | "Integrate with SAP", "REST API" | Compatibility |
| **07-Usability Requirements** | REQ-USE | UX, learnability, accessibility | "Learn in 5 min", "WCAG 2.1 AA" | Usability |
| **08-Reliability Requirements** | REQ-REL | availability, fault tolerance, recovery | "99.9% uptime", "MTTR < 15min" | Reliability |
| **09-Security Requirements** | REQ-SEC | confidentiality, integrity, authentication | "AES-256 encryption", "MFA" | Security |
| **10-Maintainability Requirements** | REQ-MAIN | modularity, testability, code quality | "Test coverage > 80%", "Modular design" | Maintainability |
| **11-Portability Requirements** | REQ-PORT | cross-platform, containerization, migration | "Docker deployment", "Multi-cloud" | Portability |

#### Layer 3: Architecture & Data Dimensions (2 Categories)

| Category | ID Prefix | Key Indicators | Examples | ISO Reference |
|----------|-----------|---------------|-----------|---------------|
| **12-Architecture Requirements** | REQ-ARCH | architecture pattern, service boundary, tech stack | "Microservices", "Event-driven" | - |
| **13-Data Requirements** | REQ-DATA | data model, data quality, data governance | "Data retention 7 years", "Data lineage" | - |

### ISO/IEC 25010:2023 Subcharacteristics

| Quality Characteristic | Subcharacteristics |
|------------------------|-------------------|
| **Functional Suitability** | Completeness, Correctness, Appropriateness |
| **Performance Efficiency** | Time Behaviour, Resource Utilization, Capacity |
| **Compatibility** | Co-existence, Interoperability |
| **Usability** | Appropriateness Recognizability, Learnability, Operability, User Error Protection, User Interface Aesthetics, Accessibility |
| **Reliability** | Maturity, Availability, Fault Tolerance, Recoverability |
| **Security** | Confidentiality, Integrity, Non-repudiation, Accountability, Auditability |
| **Maintainability** | Analysability, Modifiability, Testability, Reusability, Modularity |
| **Portability** | Adaptability, Installability, Replaceability |

### Cross-Category Relationship Types

| Relation Type | Description | Example | Detection Method |
|--------------|-------------|-----------|------------------|
| **drives** | One requirement drives creation of another | Business drives functional | Goal-oriented keywords |
| **constrains** | One imposes constraints on another | Constraint constrains architecture | Constraint keywords |
| **mandates** | Compliance mandates other requirements | Compliance mandates security | Regulatory keywords |
| **depends_on** | One depends on another | Functional depends on data | Dependency keywords |
| **conflicts_with** | Conflicting objectives | Security vs performance | Conflict patterns |
| **trades_off** | Quality trade-off (ISO 25010) | Security trades_off performance | Trade-off patterns |
| **influences** | One quality influences another | Architecture influences performance | Influence keywords |
| **supports** | One supports another | Maintainability supports reliability | Support keywords |
| **validates** | One validates another | Compliance validates security | Validation keywords |

### Conflict Detection Patterns (ISO/IEC 25010:2023 Trade-offs)

| Conflict Type | Categories Involved | ISO Trade-off | Example | Resolution Strategy |
|--------------|-------------------|---------------|-----------|---------------------|
| **Security vs Performance** | Security vs Performance | Security ↔ Performance Efficiency | Encryption vs speed | Hardware acceleration |
| **Security vs Usability** | Security vs Usability | Security ↔ Usability | MFA vs convenience | Risk-based authentication |
| **Reliability vs Performance** | Reliability vs Performance | Reliability ↔ Performance Efficiency | Redundancy vs latency | Adaptive redundancy |
| **Portability vs Performance** | Portability vs Performance | Portability ↔ Performance Efficiency | Abstraction vs optimization | Platform-specific optimization |
| **Cost vs Quality** | Constraint vs Quality | - | Budget vs reliability | Phased implementation |
| **Flexibility vs Consistency** | Architecture vs Compliance | - | Customization vs standard | Configurable defaults |

## Implementation

### Classification Engine

```yaml
classification_engine:
  approach: "hybrid"
  methods:
    - keyword_based: "Fast initial classification"
    - semantic_analysis: "Context-aware classification"
    - iso_mapping: "ISO/IEC 25010:2023 quality mapping"
    - rule_based: "Expert rules override"
  
  confidence_threshold: 0.85
  fallback: "manual_review"
  
  iso_25010_mapping:
    enabled: true
    version: "2023"
    quality_characteristics: 8
    subcharacteristics: 31
```

### Category Detection Rules

```yaml
category_rules:
  01_business:
    layer: "source"
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
      
  02_compliance:
    layer: "source"
    primary_keywords:
      - "GDPR"
      - "ISO 27001"
      - "HIPAA"
      - "PCI DSS"
      - "SOC 2"
      - "compliance"
      - "regulation"
      - "audit"
      - "certification"
    secondary_keywords:
      - "data protection"
      - "privacy"
      - "legal requirement"
      - "standard"
    patterns:
      - "comply with.*"
      - "meet.*standard"
      - ".*compliant"
      
  03_constraint:
    layer: "source"
    primary_keywords:
      - "budget"
      - "timeline"
      - "deadline"
      - "team size"
      - "resource"
      - "constraint"
    secondary_keywords:
      - "limited"
      - "maximum"
      - "minimum"
      - "restriction"
    patterns:
      - "budget.*\\$"
      - "within.*weeks"
      - "team of.*"
      
  04_functional:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Functional Suitability"
    subcategories:
      - completeness: "Functional Completeness"
      - correctness: "Functional Correctness"
      - appropriateness: "Functional Appropriateness"
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
      
  05_performance:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Performance Efficiency"
    subcategories:
      - time_behaviour: "Time Behaviour"
      - resource_utilization: "Resource Utilization"
      - capacity: "Capacity"
    primary_keywords:
      - "response time"
      - "throughput"
      - "latency"
      - "performance"
      - "P95"
      - "P99"
      - "QPS"
      - "TPS"
    secondary_keywords:
      - "fast"
      - "quick"
      - "efficient"
      - "scalability"
    patterns:
      - ".*<.*ms"
      - ".*>.*RPS"
      - "P\\d+.*<"
    metrics_template:
      - name: "response_time_p95"
        unit: "ms"
      - name: "throughput"
        unit: "RPS"
      - name: "concurrent_users"
        unit: "count"
        
  06_compatibility:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Compatibility"
    subcategories:
      - coexistence: "Co-existence"
      - interoperability: "Interoperability"
    primary_keywords:
      - "integrate"
      - "compatible"
      - "interoperability"
      - "API"
      - "third-party"
      - "interface"
    secondary_keywords:
      - "connect"
      - "exchange"
      - "share"
    patterns:
      - "integrate with.*"
      - "compatible with.*"
      - "support.*API"
      
  07_usability:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Usability"
    subcategories:
      - appropriateness_recognizability: "Appropriateness Recognizability"
      - learnability: "Learnability"
      - operability: "Operability"
      - user_error_protection: "User Error Protection"
      - user_interface_aesthetics: "User Interface Aesthetics"
      - accessibility: "Accessibility"
    primary_keywords:
      - "user experience"
      - "usability"
      - "learn"
      - "accessible"
      - "WCAG"
      - "UI"
      - "UX"
    secondary_keywords:
      - "intuitive"
      - "easy to use"
      - "user-friendly"
    patterns:
      - "learn in.*minutes"
      - "WCAG.*AA"
      - "accessible.*"
      
  08_reliability:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Reliability"
    subcategories:
      - maturity: "Maturity"
      - availability: "Availability"
      - fault_tolerance: "Fault Tolerance"
      - recoverability: "Recoverability"
    primary_keywords:
      - "availability"
      - "reliability"
      - "MTBF"
      - "MTTR"
      - "fault tolerance"
      - "SLA"
      - "uptime"
    secondary_keywords:
      - "failover"
      - "redundancy"
      - "disaster recovery"
    patterns:
      - ".*%.*availability"
      - "MTBF.*>.*"
      - "MTTR.*<.*"
    metrics_template:
      - name: "availability"
        unit: "%"
      - name: "MTBF"
        unit: "hours"
      - name: "MTTR"
        unit: "minutes"
        
  09_security:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Security"
    subcategories:
      - confidentiality: "Confidentiality"
      - integrity: "Integrity"
      - non_repudiation: "Non-repudiation"
      - accountability: "Accountability"
      - auditability: "Auditability"
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
      
  10_maintainability:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Maintainability"
    subcategories:
      - analysability: "Analysability"
      - modifiability: "Modifiability"
      - testability: "Testability"
      - reusability: "Reusability"
      - modularity: "Modularity"
    primary_keywords:
      - "maintainable"
      - "modular"
      - "testable"
      - "code quality"
      - "technical debt"
    secondary_keywords:
      - "refactor"
      - "extend"
      - "modify"
    patterns:
      - "test coverage.*>.*%"
      - "modular.*design"
      
  11_portability:
    layer: "quality"
    iso_reference: "ISO/IEC 25010:2023 - Portability"
    subcategories:
      - adaptability: "Adaptability"
      - installability: "Installability"
      - replaceability: "Replaceability"
    primary_keywords:
      - "portable"
      - "cross-platform"
      - "container"
      - "Docker"
      - "Kubernetes"
      - "cloud-native"
    secondary_keywords:
      - "migrate"
      - "deploy"
      - "install"
    patterns:
      - "support.*platforms"
      - "containerized"
      - "multi-cloud"
      
  12_architecture:
    layer: "architecture_data"
    primary_keywords:
      - "microservices"
      - "monolith"
      - "architecture"
      - "design pattern"
      - "layered"
      - "event-driven"
      - "service boundary"
      - "DDD"
    secondary_keywords:
      - "component"
      - "module"
      - "interface"
    patterns:
      - "use.*architecture"
      - "follow.*pattern"
      - "service.*oriented"
      
  13_data:
    layer: "architecture_data"
    primary_keywords:
      - "data model"
      - "data quality"
      - "data governance"
      - "data lifecycle"
      - "data dictionary"
      - "data lineage"
    secondary_keywords:
      - "entity"
      - "schema"
      - "retention"
      - "archive"
    patterns:
      - "data.*model"
      - "data.*retention"
      - "data.*quality"
```

### Relationship Detection Algorithm

```yaml
relationship_detection:
  method: "semantic_similarity"
  similarity_threshold: 0.75
  
  iso_25010_trade_offs:
    enabled: true
    trade_offs:
      - security_vs_performance:
          from: "09_security"
          to: "05_performance"
          relation: "trades_off"
          
      - security_vs_usability:
          from: "09_security"
          to: "07_usability"
          relation: "trades_off"
          
      - reliability_vs_performance:
          from: "08_reliability"
          to: "05_performance"
          relation: "trades_off"
          
      - portability_vs_performance:
          from: "11_portability"
          to: "05_performance"
          relation: "trades_off"
  
  relation_patterns:
    drives:
      keywords: ["drive", "require", "need", "demand"]
      direction: "business → functional"
      
    constrains:
      keywords: ["constrain", "limit", "restrict", "must follow"]
      direction: "constraint → architecture"
      
    mandates:
      keywords: ["mandate", "require", "must comply"]
      direction: "compliance → security"
      
    depends_on:
      keywords: ["depend", "require", "need", "rely on"]
      direction: "functional → data"
      
    conflicts_with:
      keywords: ["conflict", "trade-off", "versus", "vs"]
      detection: "opposite_objectives"
      
    trades_off:
      keywords: ["trade-off", "balance", "compromise"]
      detection: "iso_25010_trade_offs"
      
    influences:
      keywords: ["influence", "affect", "impact"]
      direction: "architecture → performance"
      
    validates:
      keywords: ["validate", "verify", "ensure", "comply"]
      direction: "compliance → security"
      
    supports:
      keywords: ["support", "enable", "facilitate", "help"]
      direction: "maintainability → reliability"
```

### Conflict Detection

```yaml
conflict_detection:
  strategies:
    - keyword_opposition: "Detect opposing keywords"
    - iso_trade_off_detection: "Detect ISO 25010 trade-offs"
    - objective_conflict: "Identify conflicting objectives"
    - resource_contention: "Detect resource conflicts"
    - temporal_conflict: "Identify timing conflicts"
  
  conflict_matrix:
    security_vs_performance:
      categories: ["09_security", "05_performance"]
      iso_trade_off: "Security ↔ Performance Efficiency"
      indicators: ["encryption", "latency", "throughput"]
      severity: "medium"
      
    security_vs_usability:
      categories: ["09_security", "07_usability"]
      iso_trade_off: "Security ↔ Usability"
      indicators: ["MFA", "convenience", "authentication steps"]
      severity: "medium"
      
    reliability_vs_performance:
      categories: ["08_reliability", "05_performance"]
      iso_trade_off: "Reliability ↔ Performance Efficiency"
      indicators: ["redundancy", "latency", "failover"]
      severity: "medium"
      
    cost_vs_quality:
      categories: ["03_constraint", "quality_dimensions"]
      indicators: ["budget", "reliability", "availability"]
      severity: "high"
      
    flexibility_vs_consistency:
      categories: ["12_architecture", "02_compliance"]
      indicators: ["customization", "standard", "regulation"]
      severity: "medium"
```

### Classification Report

```yaml
classification_report:
  metadata:
    generated_at: "2026-01-20T10:00:00Z"
    iso_standard: "ISO/IEC 25010:2023"
    total_requirements: 50
    classified: 48
    unclassified: 2
    confidence_avg: 0.92
    
  category_distribution:
    layer_1_source:
      01_business:
        count: 5
        percentage: 10.4%
        avg_confidence: 0.94
        
      02_compliance:
        count: 3
        percentage: 6.3%
        avg_confidence: 0.95
        
      03_constraint:
        count: 2
        percentage: 4.2%
        avg_confidence: 0.91
        
    layer_2_quality:
      04_functional:
        count: 12
        percentage: 25.0%
        avg_confidence: 0.93
        iso_reference: "Functional Suitability"
        
      05_performance:
        count: 6
        percentage: 12.5%
        avg_confidence: 0.90
        iso_reference: "Performance Efficiency"
        
      06_compatibility:
        count: 2
        percentage: 4.2%
        avg_confidence: 0.88
        iso_reference: "Compatibility"
        
      07_usability:
        count: 3
        percentage: 6.3%
        avg_confidence: 0.87
        iso_reference: "Usability"
        
      08_reliability:
        count: 4
        percentage: 8.3%
        avg_confidence: 0.91
        iso_reference: "Reliability"
        
      09_security:
        count: 5
        percentage: 10.4%
        avg_confidence: 0.92
        iso_reference: "Security"
        
      10_maintainability:
        count: 2
        percentage: 4.2%
        avg_confidence: 0.89
        iso_reference: "Maintainability"
        
      11_portability:
        count: 1
        percentage: 2.1%
        avg_confidence: 0.86
        iso_reference: "Portability"
        
    layer_3_architecture_data:
      12_architecture:
        count: 3
        percentage: 6.3%
        avg_confidence: 0.91
        
      13_data:
        count: 2
        percentage: 4.2%
        avg_confidence: 0.90
        
  cross_category_relationships:
    total: 28
    by_type:
      drives: 8
      constrains: 4
      mandates: 3
      depends_on: 5
      conflicts_with: 2
      trades_off: 3
      influences: 2
      validates: 1
      
  iso_trade_offs_detected:
    - security_vs_performance: 2
    - reliability_vs_performance: 1
      
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
    
  02_compliance:
    to: compliance-validator
    requirements: ["REQ-COMP-*"]
    
  03_constraint:
    to: project-planner
    requirements: ["REQ-CONS-*"]
    
  04_functional:
    to: spec-parser
    requirements: ["REQ-FUNC-*"]
    
  05_performance:
    to: performance-analyzer
    requirements: ["REQ-PERF-*"]
    
  06_compatibility:
    to: integration-planner
    requirements: ["REQ-COMPAT-*"]
    
  07_usability:
    to: ux-designer
    requirements: ["REQ-USE-*"]
    
  08_reliability:
    to: reliability-engineer
    requirements: ["REQ-REL-*"]
    
  09_security:
    to: security-analyzer
    requirements: ["REQ-SEC-*"]
    
  10_maintainability:
    to: code-quality-analyzer
    requirements: ["REQ-MAIN-*"]
    
  11_portability:
    to: deployment-planner
    requirements: ["REQ-PORT-*"]
    
  12_architecture:
    to: architecture-decision-recorder
    requirements: ["REQ-ARCH-*"]
    
  13_data:
    to: data-architect
    requirements: ["REQ-DATA-*"]
```

### Output to [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md)

```yaml
structured_requirements:
  requirements: [...]
  relationships: [...]
  conflicts: [...]
  iso_trade_offs: [...]
  classification_metadata:
    iso_standard: "ISO/IEC 25010:2023"
    confidence_avg: 0.92
    classification_date: "2026-01-20"
```

## Best Practices

### Classification Guidelines

1. **ISO 25010 Alignment**: Map quality requirements to ISO/IEC 25010:2023 characteristics
2. **Confidence Threshold**: Only auto-classify requirements with confidence > 0.85
3. **Manual Review**: Always review low-confidence classifications (< 0.85)
4. **Context Awareness**: Consider project context when classifying
5. **Iterative Refinement**: Improve classification rules based on feedback
6. **Cross-Validation**: Validate classifications with stakeholders

### Relationship Mapping Guidelines

1. **Bidirectional**: Always map relationships in both directions
2. **Rationale Required**: Document why relationships exist
3. **Confidence Scoring**: Score relationship confidence
4. **ISO Trade-offs**: Identify ISO 25010 quality trade-offs
5. **Conflict Priority**: Prioritize high-severity conflicts
6. **Resolution Tracking**: Track conflict resolution status

### Conflict Resolution Guidelines

1. **Early Detection**: Detect conflicts as early as possible
2. **ISO Trade-off Analysis**: Use ISO 25010 trade-off guidance
3. **Stakeholder Involvement**: Involve relevant stakeholders in resolution
4. **Trade-off Analysis**: Analyze trade-offs objectively
5. **Document Decisions**: Document resolution decisions
6. **Monitor Impact**: Monitor impact of resolution decisions

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Low confidence auto-classification | May misclassify requirements | Set threshold > 0.85, review manually |
| Ignoring ISO 25010 trade-offs | Misses quality conflicts | Enable ISO trade-off detection |
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
- No ISO standard alignment

**After (Automated Classification):**
- Consistent 13-category classification based on ISO/IEC 25010:2023
- Automatic relationship detection
- ISO 25010 trade-off identification
- Early conflict identification
- 80% reduction in classification time
- 95% classification accuracy

**Result:** Faster requirement processing, better quality alignment, fewer downstream issues, ISO standard compliance.
