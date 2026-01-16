---
name: data-flow-analyzer
description: Use when analyzing data flow and value chains to identify bottlenecks and optimization opportunities
---

# Data Flow Analyzer

## Overview
Analyze data flow through systems to identify value chains, bottlenecks, and optimization opportunities. Visualizes how data moves from source to destination and where value is added.

## When to Use

```
Performance issues? ──────────────────────┐
                                         │
Designing data pipeline? ─────────────────┤
                                         ├─► Use data-flow-analyzer
Debugging data loss/duplication? ──────────┤
                                         │
Optimizing data architecture? ─────────────┘
```

Use when:
- Diagnosing performance bottlenecks
- Designing new data architectures
- Troubleshooting data consistency issues
- Planning data pipeline optimization
- Understanding system data dependencies
- Compliance requires data lineage documentation

## Core Pattern

### Data Flow Visualization

```mermaid
graph LR
    A[User Input] --> B[API Gateway]
    B --> C[Service A]
    C --> D[Database]
    C --> E[Cache]
    C --> F[Analytics]
    E --> C
    F --> G[Dashboard]
```

### Before (Unanalyzed Flow)

```
System: User signup flow
Issues:
- Unknown where data is stored
- Duplicate data across services
- No clear data lineage
- Compliance audit failed
```

### After (Analyzed Flow)

```yaml
Data Flow:
  Step 1: User submits form
    → Validates input (API Gateway)
    → Stores user data (User Service)
    → Sends welcome email (Notification Service)
    → Records analytics event (Analytics Service)

  Data Storage:
    - User data: PostgreSQL (User Service)
    - Session: Redis (Cache)
    - Events: Kafka (Event Bus)

  Value Chain:
    - Email: Engagement (immediate value)
    - Analytics: Insights (future value)
    - Session: Experience (continuous value)

  Optimizations:
    - Add cache for frequently accessed user data
    - Async email sending to improve response time
```

## Implementation

### Data Flow Analysis Steps

1. **Map Data Sources** - Identify all data entry points
2. **Trace Data Paths** - Follow data through the system
3. **Identify Storage** - Document where data persists
4. **Calculate Latency** - Measure end-to-end delay
5. **Find Bottlenecks** - Identify slow components
6. **Optimize** - Apply improvements

### Mermaid Diagram Template

```mermaid
graph TD
    subgraph "Ingestion Layer"
        A[Data Source] -->|Raw Data| B[Ingestion Service]
    end

    subgraph "Processing Layer"
        B -->|Validated| C[Processing Service]
        C -->|Enriched| D[Transformation Service]
    end

    subgraph "Storage Layer"
        D --> E[(Primary DB)]
        D --> F[(Cache)]
        D --> G[(Data Warehouse)]
    end

    subgraph "Analytics Layer"
        G --> H[Analytics Engine]
        H --> I[Dashboard]
    end
```
