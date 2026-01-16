---
name: metrics-definer
description: Use when defining business and technical metrics with monitoring configurations for specific system types
---

# Metrics Definer

## Overview
Define comprehensive business and technical metrics with monitoring configurations tailored to specific system types and business scenarios. Ensures observable, actionable, and complete metric coverage.

## When to Use

```
Need to define metrics? ──────────────────┐
                                        │
Setting up monitoring? ──────────────────┤
                                        ├─► Use metrics-definer
New system/service deployed? ──────────────┤
                                        │
Aether.go BMAD framework? ────────────────┘
```

Use when:
- Designing monitoring strategy for new systems
- Setting up alerts and dashboards
- Implementing APM or observability tools
- Business requires KPI/OKR definitions
- Troubleshooting with no metrics visibility
- Migrating from monolith to microservices
- Compliance requires metric tracking

Don't use when:
- Writing actual metric collection code
- Simple debugging with existing metrics
- Technical metrics without business context

## Core Pattern

### Metrics Hierarchy

```
┌─────────────────────────────────┐
│  Business Metrics (KPIs)       │
│  Revenue, Conversion Rate, NPS  │
└──────────────┬──────────────────┘
               ↓
┌─────────────────────────────────┐
│  Application Metrics            │
│  Requests, Errors, Latency     │
└──────────────┬──────────────────┘
               ↓
┌─────────────────────────────────┐
│  Infrastructure Metrics         │
│  CPU, Memory, Disk, Network     │
└─────────────────────────────────┘
```

### Before (Incomplete Metrics)
```yaml
Existing metrics:
  - CPU usage
  - Memory usage
  - Request count

Issues:
  - No business context (is CPU high during peak or idle?)
  - No error rate (is system working or just fast?)
  - No latency (fast but how fast?)
  - No business KPIs (are we making money?)
  - No alerts (how do we know something's wrong?)
```

### After (Complete Metrics)
```yaml
Business Metrics:
  - Checkout conversion rate
  - Revenue per minute
  - Active users

Application Metrics:
  - Request rate (success vs error)
  - Response time (P50, P95, P99)
  - Error rate by endpoint
  - Database connection pool usage

Infrastructure Metrics:
  - CPU, memory, disk, network
  - Container restarts
  - Node availability

Alerts:
  - Error rate > 5%
  - P95 latency > 2s
  - Checkout conversion rate drops > 10%

Dashboards:
  - Business overview (executive)
  - Service health (SRE)
  - Infrastructure (DevOps)
```

## Quick Reference

### Metrics by System Type

| System Type | Key Business Metrics | Key Technical Metrics | Alert Thresholds |
|-------------|---------------------|----------------------|------------------|
| **E-commerce** | Orders/min, Revenue, Conversion rate | Requests/sec, Error rate, Latency | Error > 2%, Latency P95 > 500ms |
| **SaaS** | DAU, MAU, Feature adoption | API calls, License usage, Uptime | Uptime < 99.9%, Churn > 5% |
| **API Service** | API calls, Rate limit breaches, Client errors | Requests, Latency, Cache hit rate | Error rate > 1%, Latency P99 > 1s |
| **IoT Platform** | Connected devices, Message throughput | Device status, Message latency, Storage | Offline devices > 10%, Latency > 5s |
| **Content Platform** | Page views, Engagement time, Bounce rate | CDN requests, Cache hit rate, Bandwidth | Cache hit < 80%, Latency P95 > 1s |

### Essential Metrics Checklist

**Business Metrics (Must-Have):**
- [ ] Revenue or conversion metrics
- [ ] User engagement (DAU/MAU)
- [ ] Customer satisfaction (NPS/CSAT)
- [ ] Goal completion rate

**Application Metrics (Must-Have):**
- [ ] Request rate (throughput)
- [ ] Error rate (4xx, 5xx)
- [ ] Latency (P50, P95, P99)
- [ ] Queue depth

**Infrastructure Metrics (Must-Have):**
- [ ] CPU, memory, disk, network
- [ ] Container/pod health
- [ ] Database connections
- [ ] Storage usage

## Implementation

### Metric Definition Template

```yaml
# metrics-definition.yaml
system_name: "<System name>"
system_type: "<ecommerce|saas|api|iot|content>"
business_criticality: <HIGH|MEDIUM|LOW>

business_metrics:
  - name: "<Metric name>"
    description: "<What does this measure?>"
    formula: "<How calculated>"
    unit: "<Unit>"
    target: "<Target value>"
    alert_threshold: "<Alert if below/above>"
    data_source: "<Where data comes from>"
    dashboard: "<Executive/Operational>"
    owner: "<Business owner>"

application_metrics:
  - name: "<Metric name>"
    type: <counter|gauge|histogram>
    description: "<What does this measure?>"
    labels: ["<dimension>"]
    aggregation: "<sum|avg|percentile>"
    alert_threshold: "<Condition>"
    data_source: "<APM/Custom>"
    dashboard: "<SRE/DevOps>"

infrastructure_metrics:
  - name: "<Metric name>"
    type: <system|container|database>
    description: "<What does this measure?>"
    collection_method: "<Agent/Exporter>"
    alert_threshold: "<Condition>"
    dashboard: "<Infrastructure>"
    owner: "<SRE/DevOps>"

alerts:
  - name: "<Alert name>"
    metric: "<Metric name>"
    condition: "<Comparison>"
    threshold: "<Value>"
    duration: "<For how long>"
    severity: <critical|warning|info>
    notification_channels: ["<Slack/PagerDuty/Email>"]
    runbook_url: "<Link to runbook>"

dashboards:
  - name: "<Dashboard name>"
    audience: "<Executive|SRE|DevOps|Business>"
    refresh_interval: "<Time>"
    panels: ["<Metric list>"]
```

### Example: E-commerce Platform

```yaml
system_name: "E-commerce Platform"
system_type: "ecommerce"
business_criticality: "HIGH"

business_metrics:
  - name: "checkout_conversion_rate"
    description: "Percentage of users completing checkout"
    formula: "completed_checkouts / initiated_checkouts * 100"
    unit: "percent"
    target: 80
    alert_threshold: "below 70"
    data_source: "Google Analytics"
    dashboard: "Executive"
    owner: "Product Manager"

  - name: "revenue_per_minute"
    description: "Revenue generated per minute"
    formula: "sum(order_amount) over 1 minute"
    unit: "USD"
    target: "trending up"
    alert_threshold: "below baseline"
    data_source: "Order service"
    dashboard: "Executive"
    owner: "Business Owner"

  - name: "active_users"
    description: "Users with active sessions"
    formula: "count(unique_sessions) over 5 minutes"
    unit: "count"
    target: "trending up"
    alert_threshold: "below baseline"
    data_source: "Session service"
    dashboard: "Executive"
    owner: "Product Manager"

application_metrics:
  - name: "http_requests_total"
    type: "counter"
    description: "Total HTTP requests"
    labels: ["method", "endpoint", "status"]
    aggregation: "rate"
    alert_threshold: "N/A (informational)"
    data_source: "Prometheus + Node Exporter"
    dashboard: "SRE"

  - name: "http_request_duration_seconds"
    type: "histogram"
    description: "HTTP request latency"
    labels: ["method", "endpoint"]
    aggregation: "percentile (50, 95, 99)"
    alert_threshold: "P95 > 2s, P99 > 5s"
    data_source: "Prometheus + Node Exporter"
    dashboard: "SRE"

  - name: "http_requests_errors_total"
    type: "counter"
    description: "Total HTTP errors (4xx, 5xx)"
    labels: ["status", "endpoint"]
    aggregation: "rate"
    alert_threshold: "rate > 0.05 (5%)"
    data_source: "Prometheus + Node Exporter"
    dashboard: "SRE"

infrastructure_metrics:
  - name: "cpu_usage_percent"
    type: "system"
    description: "CPU utilization percentage"
    collection_method: "Node Exporter"
    alert_threshold: "above 80% for 5 minutes"
    dashboard: "Infrastructure"
    owner: "DevOps"

  - name: "memory_usage_percent"
    type: "system"
    description: "Memory utilization percentage"
    collection_method: "Node Exporter"
    alert_threshold: "above 85% for 5 minutes"
    dashboard: "Infrastructure"
    owner: "DevOps"

  - name: "container_restart_count"
    type: "container"
    description: "Number of container restarts"
    collection_method: "Kubernetes cAdvisor"
    alert_threshold: "restarts > 3 in 1 hour"
    dashboard: "Infrastructure"
    owner: "SRE"

alerts:
  - name: "high_error_rate"
    metric: "http_requests_errors_total"
    condition: "rate(http_requests_errors_total) / rate(http_requests_total)"
    threshold: "0.05"
    duration: "5 minutes"
    severity: "critical"
    notification_channels: ["pagerduty", "#alerts-slack"]
    runbook_url: "https://runbooks.example.com/high-error-rate"

  - name: "high_latency"
    metric: "http_request_duration_seconds"
    condition: "histogram_quantile(0.95, http_request_duration_seconds)"
    threshold: "2"
    duration: "5 minutes"
    severity: "warning"
    notification_channels: ["#alerts-slack"]
    runbook_url: "https://runbooks.example.com/high-latency"

  - name: "checkout_conversion_drop"
    metric: "checkout_conversion_rate"
    condition: "below"
    threshold: "70"
    duration: "15 minutes"
    severity: "warning"
    notification_channels: ["#product-slack"]
    runbook_url: "https://runbooks.example.com/conversion-drop"

dashboards:
  - name: "Executive Overview"
    audience: "Executive"
    refresh_interval: "5m"
    panels:
      - "revenue_per_minute"
      - "checkout_conversion_rate"
      - "active_users"
      - "orders_total"

  - name: "Service Health"
    audience: "SRE"
    refresh_interval: "30s"
    panels:
      - "http_requests_total"
      - "http_request_duration_seconds (P95, P99)"
      - "http_requests_errors_total"
      - "error_rate"
      - "up (service availability)"

  - name: "Infrastructure"
    audience: "DevOps"
    refresh_interval: "1m"
    panels:
      - "cpu_usage_percent"
      - "memory_usage_percent"
      - "disk_usage_percent"
      - "network_io"
      - "container_restart_count"
```

### Prometheus Queries

```promql
# Error rate
rate(http_requests_errors_total{status=~"5.."}[5m]) /
rate(http_requests_total[5m])

# Latency percentiles
histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))

# Request rate by endpoint
rate(http_requests_total[5m])

# Container restarts
increase(kube_pod_container_status_restarts_total[1h])

# CPU usage
rate(process_cpu_seconds_total[5m])

# Memory usage
process_resident_memory_bytes / (node_memory_MemTotal_bytes * 1024 * 1024)
```

### Alerting Rules (Prometheus)

```yaml
# alerting-rules.yaml
groups:
  - name: application_alerts
    rules:
      - alert: HighErrorRate
        expr: |
          rate(http_requests_errors_total{status=~"5.."}[5m]) /
          rate(http_requests_total[5m]) > 0.05
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          description: "Error rate is above 5% for 5 minutes"

      - alert: HighLatency
        expr: |
          histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 2
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High latency detected"
          description: "P95 latency is above 2 seconds"

  - name: infrastructure_alerts
    rules:
      - alert: HighCPUUsage
        expr: rate(process_cpu_seconds_total[5m]) > 0.8
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High CPU usage"
          description: "CPU usage is above 80%"

      - alert: ContainerCrashLoop
        expr: increase(kube_pod_container_status_restarts_total[1h]) > 3
        labels:
          severity: critical
        annotations:
          summary: "Container in crash loop"
          description: "Container has restarted more than 3 times in 1 hour"
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| No business metrics | Can't justify technical work to stakeholders | Add KPIs that matter to business |
| Too many metrics | Alert fatigue, hard to focus | Focus on 2-3 critical metrics per dashboard |
| Alerts without context | No one knows what to do | Link alerts to runbooks |
| No baselines | Don't know what "normal" is | Establish baseline during calm periods |
| Metric names unclear | Confusing for users | Use descriptive, self-documenting names |
| Wrong aggregation | Misleading metrics | Use appropriate aggregation (sum vs avg) |

## Real-World Impact

**Before (Poor Metrics):**
- System goes down, no one knows why
- Business asks "is our site slow?" no answer
- Alerts trigger constantly, team ignores them
- Can't prove value of optimizations

**After (Good Metrics):**
- Proactive detection of issues before users notice
- Clear business impact of incidents
- Data-driven optimization decisions
- Executives see KPIs in real-time

**Result:** 60% faster incident response, 90% reduction in alert fatigue, confident technical decisions.
