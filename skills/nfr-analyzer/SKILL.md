---
name: nfr-analyzer
description: Use when analyzing non-functional requirements and mapping them to measurable technical metrics with validation strategies
---

# NFR Analyzer

## Overview
Analyze non-functional requirements (NFRs) from the 04_non_functional category, map them to measurable technical metrics, define validation strategies, and ensure NFRs are testable and achievable. Bridges the gap between quality attributes and concrete implementation targets.

## When to Use

```
NFR requirements identified? ─────────────┐
                                           │
Need measurable metrics? ───────────────────┤
                                           ├─► Use nfr-analyzer
Validation strategy needed? ────────────────┤
                                           │
Quality attributes to define? ──────────────┘
```

Use when:
- After [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md) identifies NFRs
- Before [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md) processes requirements
- Need to make NFRs measurable and testable
- Defining performance, reliability, scalability targets
- Creating validation strategies for quality attributes

Don't use when:
- No NFR requirements exist
- NFRs already have defined metrics
- Only functional requirements present

## Core Pattern

### NFR Analysis Workflow

```
NFR Requirements → Category Classification → Metric Mapping → Validation Strategy
        ↓                  ↓                       ↓                  ↓
   Raw NFRs          NFR Categories         Measurable          Test Plans
                                              Metrics
        ↓                  ↓                       ↓                  ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│                         NFR Quality Model                                    │
└─────────────────────────────────────────────────────────────────────────────┘
        ↓
   NFR Specification Document
        ↓
   Input to Spec Parser
```

### Before (Vague NFR)
```yaml
nfr_requirement:
  id: "REQ-NFR-001"
  statement: "The system should be fast"
  category: "04_non_functional"
```

### After (Analyzed NFR)
```yaml
analyzed_nfr:
  id: "REQ-NFR-001"
  original_statement: "The system should be fast"
  
  classification:
    category: "performance"
    subcategory: "response_time"
    quality_attribute: "efficiency"
    
  metrics:
    - name: "api_response_time_p95"
      description: "95th percentile API response time"
      formula: "percentile(response_times, 95)"
      unit: "milliseconds"
      target: 200
      current_baseline: 450
      threshold:
        excellent: "< 100ms"
        acceptable: "100-200ms"
        warning: "200-500ms"
        critical: "> 500ms"
      measurement_method: "APM monitoring"
      data_source: "Prometheus metrics"
      
    - name: "api_response_time_p99"
      description: "99th percentile API response time"
      formula: "percentile(response_times, 99)"
      unit: "milliseconds"
      target: 500
      current_baseline: 1200
      
  validation:
    strategy: "load_testing"
    tools: ["k6", "JMeter", "Locust"]
    test_scenarios:
      - name: "normal_load"
        description: "Normal traffic conditions"
        concurrent_users: 100
        duration: "10 minutes"
        expected_result: "P95 < 200ms"
        
      - name: "peak_load"
        description: "Peak traffic conditions"
        concurrent_users: 500
        duration: "5 minutes"
        expected_result: "P95 < 500ms"
        
    monitoring:
      real_time: true
      alerting: true
      dashboard: "Grafana NFR Dashboard"
      
  dependencies:
    - requirement: "REQ-ARCH-001"
      relation: "constrained_by"
      impact: "Architecture choice affects performance"
      
    - requirement: "REQ-SCAL-001"
      relation: "impacts"
      impact: "Performance targets affect scalability design"
      
  risks:
    - id: "RISK-NFR-001"
      description: "Current baseline exceeds target by 125%"
      probability: "high"
      impact: "high"
      mitigation: "Performance optimization sprint required"
```

## Quick Reference

### NFR Categories

| Category | Subcategories | Key Metrics | Validation Methods |
|----------|--------------|-------------|-------------------|
| **Performance** | Response time, Throughput, Latency | P95, P99, RPS, TPS | Load testing, APM |
| **Reliability** | Availability, Fault tolerance | Uptime %, MTBF, MTTR | Chaos testing, Monitoring |
| **Scalability** | Horizontal, Vertical | Concurrent users, Data volume | Stress testing, Capacity planning |
| **Usability** | Learnability, Efficiency | Task completion time, Error rate | Usability testing, A/B testing |
| **Security** | Confidentiality, Integrity | Vulnerability count, Auth time | Security testing, Penetration testing |
| **Maintainability** | Modularity, Testability | Code complexity, Coverage | Static analysis, Code review |
| **Portability** | Platform independence | Migration effort | Compatibility testing |

### Performance Metrics Template

| Metric | Formula | Unit | Typical Target | Measurement |
|--------|---------|------|----------------|-------------|
| **Response Time (P50)** | percentile(rt, 50) | ms | < 100ms | APM |
| **Response Time (P95)** | percentile(rt, 95) | ms | < 200ms | APM |
| **Response Time (P99)** | percentile(rt, 99) | ms | < 500ms | APM |
| **Throughput** | requests / second | RPS | > 1000 | Load testing |
| **Error Rate** | errors / total_requests | % | < 0.1% | Monitoring |
| **Concurrent Users** | active_sessions | count | > 10000 | Load testing |

### Reliability Metrics Template

| Metric | Formula | Unit | Typical Target | Measurement |
|--------|---------|------|----------------|-------------|
| **Availability** | uptime / total_time | % | > 99.9% | Monitoring |
| **MTBF** | operating_time / failures | hours | > 1000h | Incident tracking |
| **MTTR** | total_downtime / incidents | minutes | < 15min | Incident tracking |
| **Error Rate** | errors / total_operations | % | < 0.01% | Monitoring |
| **Data Durability** | successful_reads / total_reads | % | > 99.999% | Storage metrics |

### Validation Strategy Matrix

| NFR Category | Primary Validation | Secondary Validation | Tools |
|--------------|-------------------|---------------------|-------|
| **Performance** | Load testing | APM monitoring | k6, JMeter, Datadog |
| **Reliability** | Chaos testing | Incident simulation | Chaos Monkey, Gremlin |
| **Scalability** | Stress testing | Capacity modeling | Locust, Gatling |
| **Usability** | User testing | A/B testing | Hotjar, Optimizely |
| **Security** | Penetration testing | Vulnerability scanning | OWASP ZAP, Burp |
| **Maintainability** | Code analysis | Technical debt scan | SonarQube, CodeClimate |

## Implementation

### NFR Classification

```yaml
nfr_classification:
  categories:
    performance:
      description: "System speed and responsiveness"
      subcategories:
        - response_time
        - throughput
        - latency
        - resource_utilization
        
    reliability:
      description: "System stability and fault tolerance"
      subcategories:
        - availability
        - fault_tolerance
        - recoverability
        
    scalability:
      description: "System growth capacity"
      subcategories:
        - horizontal_scaling
        - vertical_scaling
        - data_scaling
        
    usability:
      description: "User experience quality"
      subcategories:
        - learnability
        - efficiency
        - satisfaction
        - accessibility
        
    security:
      description: "System protection level"
      subcategories:
        - confidentiality
        - integrity
        - availability
        - authentication
        
    maintainability:
      description: "System modification ease"
      subcategories:
        - modularity
        - testability
        - documentation
        
    portability:
      description: "System transferability"
      subcategories:
        - platform_independence
        - data_portability
        - interoperability
```

### Metric Definition Template

```yaml
metric_definition:
  id: "MET-{CATEGORY}-{NUMBER}"
  name: "Metric name"
  description: "What this metric measures"
  
  classification:
    category: "performance | reliability | scalability | ..."
    subcategory: "response_time | availability | ..."
    quality_attribute: "ISO 25010 quality attribute"
    
  measurement:
    formula: "Mathematical formula for calculation"
    unit: "Unit of measurement"
    data_type: "numeric | percentage | boolean"
    collection_method: "automated | manual | hybrid"
    frequency: "real-time | hourly | daily"
    
  targets:
    current_baseline: "Current measured value"
    target: "Goal value"
    threshold:
      excellent: "Best achievable value"
      acceptable: "Acceptable range"
      warning: "Needs attention"
      critical: "Must fix immediately"
      
  data_source:
    type: "apm | log | metric | custom"
    tool: "Prometheus | Datadog | Custom"
    endpoint: "Data collection endpoint"
    
  validation:
    test_type: "load_test | stress_test | chaos_test"
    tool: "k6 | JMeter | Gremlin"
    scenario: "Test scenario reference"
```

### Validation Strategy Template

```yaml
validation_strategy:
  id: "VAL-{CATEGORY}-{NUMBER}"
  name: "Validation strategy name"
  
  nfr_references:
    - "REQ-NFR-001"
    - "REQ-NFR-002"
    
  approach:
    primary:
      method: "load_testing"
      description: "Primary validation method"
      tools: ["k6", "JMeter"]
      
    secondary:
      method: "apm_monitoring"
      description: "Continuous monitoring"
      tools: ["Datadog", "Prometheus"]
      
  test_scenarios:
    - id: "TS-001"
      name: "Normal load test"
      description: "Test under normal conditions"
      
      configuration:
        concurrent_users: 100
        duration: "10 minutes"
        ramp_up: "2 minutes"
        
      assertions:
        - metric: "response_time_p95"
          operator: "<"
          value: 200
          unit: "ms"
          
        - metric: "error_rate"
          operator: "<"
          value: 0.1
          unit: "%"
          
    - id: "TS-002"
      name: "Peak load test"
      description: "Test under peak conditions"
      
      configuration:
        concurrent_users: 500
        duration: "5 minutes"
        ramp_up: "1 minute"
        
      assertions:
        - metric: "response_time_p95"
          operator: "<"
          value: 500
          unit: "ms"
          
  monitoring:
    real_time:
      enabled: true
      dashboard: "Grafana NFR Dashboard"
      
    alerting:
      enabled: true
      channels: ["Slack", "PagerDuty"]
      rules:
        - condition: "response_time_p95 > 500ms"
          severity: "warning"
          
        - condition: "response_time_p95 > 1000ms"
          severity: "critical"
```

### NFR Quality Model

```yaml
nfr_quality_model:
  based_on: "ISO 25010"
  
  quality_attributes:
    efficiency:
      description: "Performance relative to resources used"
      subattributes:
        - time_behavior: "Response time, throughput"
        - resource_utilization: "CPU, memory, network"
        
    reliability:
      description: "Maintains functionality under stated conditions"
      subattributes:
        - maturity: "Fault prevention"
        - availability: "Operational readiness"
        - fault_tolerance: "Error handling"
        - recoverability: "Recovery capability"
        
    usability:
      description: "Effectiveness and satisfaction of use"
      subattributes:
        - appropriateness: "Task suitability"
        - learnability: "Ease of learning"
        - operability: "Ease of operation"
        - accessibility: "Inclusivity"
        
    security:
      description: "Protection against unauthorized access"
      subattributes:
        - confidentiality: "Data protection"
        - integrity: "Data accuracy"
        - non_repudiation: "Action proof"
        - authenticity: "Identity verification"
        
    maintainability:
      description: "Ease of modification"
      subattributes:
        - modularity: "Component independence"
        - reusability: "Asset reuse"
        - analysability: "Diagnosis ease"
        - modifiability: "Change ease"
        - testability: "Test criteria ease"
```

### NFR Specification Document

```yaml
nfr_specification:
  metadata:
    project: "Project Name"
    version: "1.0"
    created: "2026-01-20"
    last_updated: "2026-01-20"
    
  summary:
    total_nfrs: 15
    by_category:
      performance: 5
      reliability: 3
      scalability: 2
      security: 3
      usability: 2
      
  nfrs:
    - id: "REQ-NFR-001"
      category: "performance"
      statement: "API response time must be fast"
      
      analyzed:
        classification:
          category: "performance"
          subcategory: "response_time"
          
        metrics:
          - name: "api_response_time_p95"
            target: "200ms"
            baseline: "450ms"
            
        validation:
          strategy: "load_testing"
          tool: "k6"
          
        risks:
          - "Baseline exceeds target by 125%"
          
    - id: "REQ-NFR-002"
      category: "reliability"
      statement: "System must be highly available"
      
      analyzed:
        classification:
          category: "reliability"
          subcategory: "availability"
          
        metrics:
          - name: "system_availability"
            target: "99.9%"
            baseline: "99.5%"
            
        validation:
          strategy: "chaos_testing"
          tool: "Gremlin"
          
  validation_plan:
    test_suites:
      - name: "Performance Suite"
        scenarios: ["TS-001", "TS-002", "TS-003"]
        schedule: "Daily"
        
      - name: "Reliability Suite"
        scenarios: ["TS-004", "TS-005"]
        schedule: "Weekly"
        
  monitoring_plan:
    dashboards:
      - name: "NFR Dashboard"
        metrics: ["response_time_p95", "availability", "error_rate"]
        
    alerts:
      - name: "Performance Alert"
        condition: "response_time_p95 > 500ms"
        severity: "warning"
```

## Integration with Other Skills

### Input from [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md)

```yaml
input:
  nfr_requirements:
    - id: "REQ-NFR-{NUMBER}"
      statement: "NFR statement"
      category: "04_non_functional"
```

### Output to [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md)

```yaml
output:
  analyzed_nfrs:
    - id: "REQ-NFR-{NUMBER}"
      metrics: [...]
      validation: [...]
      dependencies: [...]
```

### Output to [scalability-planner](file:///d:/repos/aether-go/skills/skills/scalability-planner/SKILL.md)

```yaml
output:
  performance_constraints:
    - metric: "response_time_p95"
      target: "200ms"
      impact_on_scaling: "Limits horizontal scaling options"
```

## Best Practices

### NFR Definition Guidelines

1. **Measurable**: Every NFR must have measurable metrics
2. **Achievable**: Targets must be realistic based on baseline
3. **Testable**: Validation strategy must be defined
4. **Prioritized**: NFRs should be prioritized by business impact
5. **Traceable**: Link NFRs to business requirements

### Metric Definition Guidelines

1. **Clear Formula**: Define exact calculation method
2. **Unit Consistency**: Use consistent units across metrics
3. **Threshold Definition**: Define all threshold levels
4. **Data Source**: Specify where data comes from
5. **Collection Frequency**: Define how often to measure

### Validation Guidelines

1. **Multiple Methods**: Use multiple validation approaches
2. **Real-world Scenarios**: Test with realistic conditions
3. **Continuous Monitoring**: Monitor in production
4. **Alerting**: Set up proactive alerting
5. **Regular Review**: Review and adjust targets regularly

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Vague NFRs | Not testable | Define specific metrics |
| No baseline | Cannot measure improvement | Measure current state first |
| Unrealistic targets | Cannot achieve | Set achievable targets |
| No validation | Cannot verify | Define validation strategy |
| Ignoring dependencies | Unexpected conflicts | Analyze cross-category dependencies |

## Real-World Impact

**Before (Vague NFRs):**
- "System should be fast"
- No measurable targets
- No validation strategy
- Cannot verify compliance
- Stakeholder disputes

**After (Analyzed NFRs):**
- "P95 response time < 200ms"
- Clear metrics and targets
- Defined validation strategy
- Automated verification
- Objective assessment

**Result:** Measurable quality targets, automated validation, clear stakeholder alignment.
