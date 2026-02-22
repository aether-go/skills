---
name: nfr-analyzer
description: Use when analyzing non-functional requirements and mapping them to measurable technical metrics with ISO/IEC 25010:2023 validation strategies
---

# NFR Analyzer

## Overview
Analyze non-functional requirements (NFRs) across the quality dimension categories (05-Performance through 11-Portability), map them to measurable technical metrics based on ISO/IEC 25010:2023, define validation strategies, and ensure NFRs are testable and achievable. Bridges the gap between quality attributes and concrete implementation targets.

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
- After [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md) identifies quality-related NFRs
- Before [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md) processes requirements
- Need to make NFRs measurable and testable
- Defining performance, reliability, security, usability targets
- Creating validation strategies for quality attributes
- Mapping requirements to ISO/IEC 25010:2023 quality model

Don't use when:
- No NFR requirements exist
- NFRs already have defined metrics
- Only functional requirements present

## Core Pattern

### NFR Analysis Workflow (ISO/IEC 25010:2023 Based)

```
NFR Requirements → ISO 25010 Classification → Metric Mapping → Validation Strategy
        ↓                  ↓                       ↓                  ↓
   Raw NFRs        Quality Characteristics    Measurable          Test Plans
                                              Metrics
        ↓                  ↓                       ↓                  ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│                    ISO/IEC 25010:2023 Quality Model                          │
│  8 Quality Characteristics: Performance, Compatibility, Usability,           │
│  Reliability, Security, Maintainability, Portability, Functional Suitability │
└─────────────────────────────────────────────────────────────────────────────┘
        ↓
   NFR Specification Document
        ↓
   Input to Spec Parser
```

### Before (Vague NFR)
```yaml
nfr_requirement:
  id: "REQ-PERF-001"
  statement: "The system should be fast"
  category: "05_performance"
```

### After (Analyzed NFR with ISO 25010 Mapping)
```yaml
analyzed_nfr:
  id: "REQ-PERF-001"
  original_statement: "The system should be fast"
  
  classification:
    category: "05_performance"
    subcategory: "response_time"
    iso_25010:
      characteristic: "Performance Efficiency"
      subcharacteristic: "Time Behavior"
      description: "Response and processing times and throughput rates of a system when performing its functions"
    
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
      
    - requirement: "REQ-REL-001"
      relation: "supports"
      impact: "Performance targets affect reliability design"
      
  risks:
    - id: "RISK-NFR-001"
      description: "Current baseline exceeds target by 125%"
      probability: "high"
      impact: "high"
      mitigation: "Performance optimization sprint required"
```

## Quick Reference

### ISO/IEC 25010:2023 Quality Characteristics and NFR Categories

| ISO Characteristic | Subcharacteristics | NFR Category | Key Metrics | Validation Methods |
|-------------------|---------------------|--------------|-------------|-------------------|
| **Performance Efficiency** | Time behavior, Resource utilization, Capacity | 05-Performance | P95, P99, RPS, TPS, CPU%, Memory% | Load testing, APM |
| **Compatibility** | Coexistence, Interoperability | 06-Compatibility | Integration success rate, API compliance | Integration testing |
| **Usability** | Appropriateness recognizability, Learnability, Operability, User error protection, Accessibility | 07-Usability | Task completion time, Error rate, SUS score | Usability testing, A/B testing |
| **Reliability** | Maturity, Availability, Fault tolerance, Recoverability | 08-Reliability | Uptime %, MTBF, MTTR | Chaos testing, Monitoring |
| **Security** | Confidentiality, Integrity, Non-repudiation, Authenticity | 09-Security | Vulnerability count, Auth time, Encryption coverage | Security testing, Penetration testing |
| **Maintainability** | Modularity, Reusability, Analysability, Modifiability, Testability | 10-Maintainability | Code complexity, Coverage, Tech debt | Static analysis, Code review |
| **Portability** | Adaptability, Installability, Replaceability | 11-Portability | Migration effort, Platform coverage | Compatibility testing |

### Performance Metrics Template (ISO 25010: Performance Efficiency)

| Metric | Formula | Unit | Typical Target | ISO Subcharacteristic | Measurement |
|--------|---------|------|----------------|----------------------|-------------|
| **Response Time (P50)** | percentile(rt, 50) | ms | < 100ms | Time behavior | APM |
| **Response Time (P95)** | percentile(rt, 95) | ms | < 200ms | Time behavior | APM |
| **Response Time (P99)** | percentile(rt, 99) | ms | < 500ms | Time behavior | APM |
| **Throughput** | requests / second | RPS | > 1000 | Time behavior | Load testing |
| **CPU Utilization** | cpu_time / total_time | % | < 70% | Resource utilization | Monitoring |
| **Memory Utilization** | used_memory / total_memory | % | < 80% | Resource utilization | Monitoring |
| **Concurrent Users** | active_sessions | count | > 10000 | Capacity | Load testing |
| **Data Volume** | data_processed / time | GB/hour | > 100 | Capacity | Monitoring |

### Reliability Metrics Template (ISO 25010: Reliability)

| Metric | Formula | Unit | Typical Target | ISO Subcharacteristic | Measurement |
|--------|---------|------|----------------|----------------------|-------------|
| **Availability** | uptime / total_time | % | > 99.9% | Availability | Monitoring |
| **MTBF** | operating_time / failures | hours | > 1000h | Maturity | Incident tracking |
| **MTTR** | total_downtime / incidents | minutes | < 15min | Recoverability | Incident tracking |
| **Error Rate** | errors / total_operations | % | < 0.01% | Maturity | Monitoring |
| **Fault Tolerance Score** | successful_failovers / total_failures | % | > 99% | Fault tolerance | Chaos testing |
| **Data Durability** | successful_reads / total_reads | % | > 99.999% | Maturity | Storage metrics |

### Security Metrics Template (ISO 25010: Security)

| Metric | Formula | Unit | Typical Target | ISO Subcharacteristic | Measurement |
|--------|---------|------|----------------|----------------------|-------------|
| **Vulnerability Count** | count(critical_vulns) | count | 0 | Confidentiality | Security scan |
| **Authentication Time** | avg(auth_duration) | ms | < 500ms | Authenticity | APM |
| **Encryption Coverage** | encrypted_data / total_data | % | 100% | Confidentiality | Audit |
| **Access Control Effectiveness** | blocked_unauthorized / total_unauthorized | % | 100% | Integrity | Security logs |
| **Audit Trail Completeness** | logged_events / total_events | % | 100% | Non-repudiation | Audit |

### Usability Metrics Template (ISO 25010: Usability)

| Metric | Formula | Unit | Typical Target | ISO Subcharacteristic | Measurement |
|--------|---------|------|----------------|----------------------|-------------|
| **Task Completion Rate** | completed_tasks / attempted_tasks | % | > 95% | Operability | Usability testing |
| **Task Completion Time** | avg(task_duration) | seconds | < 30s | Operability | Usability testing |
| **Error Rate** | user_errors / actions | % | < 5% | User error protection | Usability testing |
| **Learnability Score** | tasks_completed_first_try / total_tasks | % | > 80% | Learnability | Usability testing |
| **SUS Score** | System Usability Scale | score | > 68 | Appropriateness | Survey |
| **Accessibility Score** | WCAG compliance | % | 100% | Accessibility | Accessibility audit |

### Validation Strategy Matrix

| NFR Category | ISO Characteristic | Primary Validation | Secondary Validation | Tools |
|--------------|-------------------|-------------------|---------------------|-------|
| **05-Performance** | Performance Efficiency | Load testing | APM monitoring | k6, JMeter, Datadog |
| **06-Compatibility** | Compatibility | Integration testing | Compatibility testing | Postman, Newman |
| **07-Usability** | Usability | User testing | A/B testing | Hotjar, Optimizely |
| **08-Reliability** | Reliability | Chaos testing | Incident simulation | Chaos Monkey, Gremlin |
| **09-Security** | Security | Penetration testing | Vulnerability scanning | OWASP ZAP, Burp |
| **10-Maintainability** | Maintainability | Code analysis | Technical debt scan | SonarQube, CodeClimate |
| **11-Portability** | Portability | Compatibility testing | Deployment testing | Docker, Kubernetes |

## Implementation

### ISO 25010 NFR Classification

```yaml
nfr_classification:
  iso_25010_mapping:
    performance_efficiency:
      iso_characteristic: "Performance Efficiency"
      description: "Performance relative to resources used"
      nfr_category: "05_performance"
      subcharacteristics:
        - name: "Time behavior"
          description: "Response and processing times"
          metrics: ["response_time", "throughput", "latency"]
          
        - name: "Resource utilization"
          description: "Resources used during operation"
          metrics: ["cpu_utilization", "memory_utilization", "network_io"]
          
        - name: "Capacity"
          description: "Maximum limits of operation"
          metrics: ["concurrent_users", "data_volume", "request_rate"]
        
    compatibility:
      iso_characteristic: "Compatibility"
      description: "Ability to coexist and interoperate"
      nfr_category: "06_compatibility"
      subcharacteristics:
        - name: "Coexistence"
          description: "Operating alongside other products"
          metrics: ["isolation_effectiveness", "resource_sharing"]
          
        - name: "Interoperability"
          description: "Communicating with other products"
          metrics: ["api_compliance", "data_format_compatibility"]
        
    usability:
      iso_characteristic: "Usability"
      description: "Effectiveness and satisfaction of use"
      nfr_category: "07_usability"
      subcharacteristics:
        - name: "Appropriateness recognizability"
          description: "Users recognize suitability"
          metrics: ["feature_discovery_rate", "first_impression_score"]
          
        - name: "Learnability"
          description: "Ease of learning"
          metrics: ["time_to_proficiency", "training_hours"]
          
        - name: "Operability"
          description: "Ease of operation"
          metrics: ["task_completion_rate", "error_rate"]
          
        - name: "User error protection"
          description: "Protection against user errors"
          metrics: ["error_prevention_rate", "recovery_success_rate"]
          
        - name: "Accessibility"
          description: "Usability for all users"
          metrics: ["wcag_compliance", "assistive_tech_compatibility"]
        
    reliability:
      iso_characteristic: "Reliability"
      description: "Maintains functionality under stated conditions"
      nfr_category: "08_reliability"
      subcharacteristics:
        - name: "Maturity"
          description: "Fault prevention"
          metrics: ["defect_rate", "stability_score"]
          
        - name: "Availability"
          description: "Operational readiness"
          metrics: ["uptime_percentage", "planned_downtime"]
          
        - name: "Fault tolerance"
          description: "Error handling"
          metrics: ["failover_success_rate", "graceful_degradation"]
          
        - name: "Recoverability"
          description: "Recovery capability"
          metrics: ["mttr", "rpo_achievement"]
        
    security:
      iso_characteristic: "Security"
      description: "Protection against unauthorized access"
      nfr_category: "09_security"
      subcharacteristics:
        - name: "Confidentiality"
          description: "Data protection"
          metrics: ["encryption_coverage", "data_leak_incidents"]
          
        - name: "Integrity"
          description: "Data accuracy"
          metrics: ["data_validation_rate", "tamper_detection"]
          
        - name: "Non-repudiation"
          description: "Action proof"
          metrics: ["audit_trail_completeness", "log_integrity"]
          
        - name: "Authenticity"
          description: "Identity verification"
          metrics: ["authentication_success_rate", "identity_verification"]
        
    maintainability:
      iso_characteristic: "Maintainability"
      description: "Ease of modification"
      nfr_category: "10_maintainability"
      subcharacteristics:
        - name: "Modularity"
          description: "Component independence"
          metrics: ["coupling_score", "cohesion_score"]
          
        - name: "Reusability"
          description: "Asset reuse"
          metrics: ["code_reuse_rate", "component_reuse"]
          
        - name: "Analysability"
          description: "Diagnosis ease"
          metrics: ["debugging_time", "log_quality"]
          
        - name: "Modifiability"
          description: "Change ease"
          metrics: ["change_lead_time", "change_failure_rate"]
          
        - name: "Testability"
          description: "Test criteria ease"
          metrics: ["test_coverage", "test_automation_rate"]
        
    portability:
      iso_characteristic: "Portability"
      description: "System transferability"
      nfr_category: "11_portability"
      subcharacteristics:
        - name: "Adaptability"
          description: "Adaptation to different environments"
          metrics: ["platform_support_count", "configuration_flexibility"]
          
        - name: "Installability"
          description: "Installation ease"
          metrics: ["installation_time", "installation_success_rate"]
          
        - name: "Replaceability"
          description: "Replacement ease"
          metrics: ["migration_effort", "backward_compatibility"]
```

### Metric Definition Template

```yaml
metric_definition:
  id: "MET-{CATEGORY}-{NUMBER}"
  name: "Metric name"
  description: "What this metric measures"
  
  classification:
    nfr_category: "05_performance | 06_compatibility | 07_usability | 08_reliability | 09_security | 10_maintainability | 11_portability"
    iso_25010:
      characteristic: "ISO 25010 characteristic name"
      subcharacteristic: "ISO 25010 subcharacteristic"
    
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
    test_type: "load_test | stress_test | chaos_test | security_test"
    tool: "k6 | JMeter | Gremlin | OWASP ZAP"
    scenario: "Test scenario reference"
```

### Validation Strategy Template

```yaml
validation_strategy:
  id: "VAL-{CATEGORY}-{NUMBER}"
  name: "Validation strategy name"
  
  iso_25010_reference:
    characteristic: "Performance Efficiency"
    subcharacteristic: "Time Behavior"
    
  nfr_references:
    - "REQ-PERF-001"
    - "REQ-PERF-002"
    
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
          iso_verification: "Time Behavior"
          
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

### ISO 25010 Quality Trade-off Analysis

```yaml
quality_tradeoffs:
  performance_vs_reliability:
    iso_characteristics: ["Performance Efficiency", "Reliability"]
    trade_off: "Higher performance may reduce reliability (e.g., caching vs consistency)"
    affected_categories: ["05_performance", "08_reliability"]
    resolution: "Define acceptable balance based on business requirements"
    
  security_vs_usability:
    iso_characteristics: ["Security", "Usability"]
    trade_off: "Stronger security may impact user experience"
    affected_categories: ["09_security", "07_usability"]
    resolution: "Implement user-friendly security measures (SSO, biometrics)"
    
  performance_vs_maintainability:
    iso_characteristics: ["Performance Efficiency", "Maintainability"]
    trade_off: "Optimized code may be harder to maintain"
    affected_categories: ["05_performance", "10_maintainability"]
    resolution: "Balance optimization with code clarity, document optimizations"
    
  portability_vs_performance:
    iso_characteristics: ["Portability", "Performance Efficiency"]
    trade_off: "Platform abstractions may impact performance"
    affected_categories: ["11_portability", "05_performance"]
    resolution: "Use efficient abstractions, profile on target platforms"
```

### NFR Specification Document

```yaml
nfr_specification:
  metadata:
    project: "Project Name"
    version: "1.0"
    created: "2026-01-20"
    last_updated: "2026-01-20"
    iso_standard: "ISO/IEC 25010:2023"
    
  summary:
    total_nfrs: 25
    by_iso_characteristic:
      performance_efficiency: 5
      compatibility: 2
      usability: 3
      reliability: 4
      security: 5
      maintainability: 3
      portability: 3
      
  nfrs:
    - id: "REQ-PERF-001"
      category: "05_performance"
      iso_25010:
        characteristic: "Performance Efficiency"
        subcharacteristic: "Time Behavior"
      statement: "API response time must be fast"
      
      analyzed:
        classification:
          category: "05_performance"
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
          
    - id: "REQ-REL-001"
      category: "08_reliability"
      iso_25010:
        characteristic: "Reliability"
        subcharacteristic: "Availability"
      statement: "System must be highly available"
      
      analyzed:
        classification:
          category: "08_reliability"
          subcategory: "availability"
          
        metrics:
          - name: "system_availability"
            target: "99.9%"
            baseline: "99.5%"
            
        validation:
          strategy: "chaos_testing"
          tool: "Gremlin"
          
    - id: "REQ-SEC-001"
      category: "09_security"
      iso_25010:
        characteristic: "Security"
        subcharacteristic: "Confidentiality"
      statement: "All data must be encrypted"
      
      analyzed:
        classification:
          category: "09_security"
          subcategory: "confidentiality"
          
        metrics:
          - name: "encryption_coverage"
            target: "100%"
            baseline: "85%"
            
        validation:
          strategy: "security_audit"
          tool: "OWASP ZAP"
          
  validation_plan:
    test_suites:
      - name: "Performance Suite"
        iso_characteristic: "Performance Efficiency"
        scenarios: ["TS-001", "TS-002", "TS-003"]
        schedule: "Daily"
        
      - name: "Reliability Suite"
        iso_characteristic: "Reliability"
        scenarios: ["TS-004", "TS-005"]
        schedule: "Weekly"
        
      - name: "Security Suite"
        iso_characteristic: "Security"
        scenarios: ["TS-006", "TS-007"]
        schedule: "Weekly"
        
  monitoring_plan:
    dashboards:
      - name: "NFR Dashboard"
        metrics: ["response_time_p95", "availability", "error_rate", "security_score"]
        
    alerts:
      - name: "Performance Alert"
        condition: "response_time_p95 > 500ms"
        severity: "warning"
        
      - name: "Availability Alert"
        condition: "availability < 99.9%"
        severity: "critical"
```

## Integration with Other Skills

### Input from [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md)

```yaml
input:
  nfr_requirements:
    05_performance: [...]
    06_compatibility: [...]
    07_usability: [...]
    08_reliability: [...]
    09_security: [...]
    10_maintainability: [...]
    11_portability: [...]
  iso_25010_references: [...]
```

### Output to [spec-parser](file:///d:/repos/aether-go/skills/skills/spec-parser/SKILL.md)

```yaml
output:
  analyzed_nfrs:
    - id: "REQ-{CATEGORY}-{NUMBER}"
      iso_25010:
        characteristic: "..."
        subcharacteristic: "..."
      metrics: [...]
      validation: [...]
      dependencies: [...]
      quality_tradeoffs: [...]
```
