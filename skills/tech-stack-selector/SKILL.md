---
name: tech-stack-selector
description: Use when selecting technology stack including application type, languages, frameworks, databases, caching, messaging, and infrastructure. Invoke during Stage 4 Implementation Planning or when user needs to make technology decisions.
---

# Tech Stack Selector

## Overview
Systematically guide users through technology stack selection with interactive questions. Covers application type, programming languages, frameworks, databases, caching, messaging, container orchestration, SSO/IAM, monitoring, and other infrastructure decisions. Integrates with architecture decision recording to document all technology choices.

## When to Use

```
Starting new project? ───────────────┐
                                     │
Need technology decisions? ───────────┤
                                     ├─► Use tech-stack-selector
Stage 4 Implementation Planning? ─────┤
                                     │
Documenting tech choices? ───────────┘
```

Use when:
- Starting a new project requiring technology stack decisions
- Stage 4 of methodology fusion (Implementation Planning)
- Need to document technology choices with rationale
- Team has disagreements about technology selection
- Evaluating technology alternatives systematically
- Creating architecture decision records (ADRs) for tech stack

Don't use when:
- Technology stack is already determined and validated
- Minor library or package choices within established stack
- Simple prototypes with obvious technology choices
- Emergency fixes requiring immediate action

## Core Pattern

### Interactive Technology Selection Process

```
Application Type → Languages → Frameworks → Databases → Caching → Messaging → Infrastructure → Documentation
       ↓              ↓            ↓            ↓           ↓          ↓              ↓              ↓
   Ask user       Ask user     Recommend    Ask user    Ask user   Ask user      Ask user      Create ADR
   to select      to select    based on     to select   to select  to select     to select     with all
   type           languages    selection    databases   caching    messaging     infra         decisions
```

### Selection Workflow

```yaml
tech_stack_selection:
  step_1_application_type:
    question: "What type of application are you building?"
    options: [fullstack, web_app, web_api, microservice, cli, library, mobile_app, mobile_service, desktop, iot_service, browser_extension]
    
  step_2_languages:
    condition: "Depends on application type"
    fullstack:
      backend: [Go, Rust, Node.js, Python, Java, C#, Kotlin]
      frontend: [TypeScript, JavaScript, Dart, Kotlin]
    web_app:
      frontend: [TypeScript, JavaScript, Dart]
      backend_optional: [Go, Rust, Node.js, Python, Java, C#]
    web_api:
      languages: [Go, Rust, Node.js, Python, Java, C#, Kotlin, Elixir]
    microservice:
      languages: [Go, Rust, Node.js, Python, Java, C#, Kotlin, Elixir]
    cli:
      languages: [Go, Rust, Python, Node.js, C#, Zig]
    library:
      languages: [Go, Rust, Python, Node.js, Java, C#, Kotlin]
    mobile_app:
      languages: [Dart (Flutter), Kotlin (Android), Swift (iOS), TypeScript (React Native)]
    mobile_service:
      languages: [Go, Rust, Node.js, Python, Java, Kotlin]
    desktop:
      languages: [Rust, Go, C#, TypeScript (Electron/Tauri), Python]
    iot_service:
      languages: [Go, Rust, Python, C++, Zig]
    browser_extension:
      languages: [TypeScript, JavaScript]
      
  step_3_frameworks:
    condition: "Recommend based on language and application type"
    
  step_4_databases:
    relational: [PostgreSQL, MySQL, TiDB, CockroachDB, SQLite, MariaDB]
    time_series: [TDengine, InfluxDB, TimescaleDB, QuestDB]
    graph: [NebulaGraph, Dgraph, Neo4j, ArangoDB]
    document: [MongoDB, CouchDB, FerretDB]
    key_value: [Redis, BadgerDB, BoltDB, LevelDB]
    search: [Elasticsearch, Meilisearch, Typesense, Quickwit]
    
  step_5_caching:
    options: [Redis, Memcached, BadgerDB, File Cache, In-Memory, Dragonfly]
    
  step_6_messaging:
    options: [Kafka, RabbitMQ, NATS, Redis Pub/Sub, Apache Pulsar, MQTT, ZeroMQ]
    
  step_7_container_orchestration:
    options: [Kubernetes, Docker Swarm, Nomad, Docker Compose, None]
    
  step_8_sso_iam:
    options: [Casdoor, Keycloak, Authentik, Ory Kratos, Auth0, Firebase Auth, AWS Cognito, Custom]
    
  step_9_monitoring:
    options: [Prometheus + Grafana, Datadog, New Relic, OpenTelemetry, Zabbix, Victoria Metrics]
    
  step_10_additional:
    api_gateway: [Kong, Traefik, Envoy, Nginx, APISIX, Tyk]
    service_mesh: [Istio, Linkerd, Consul Connect]
    ci_cd: [GitHub Actions, GitLab CI, Jenkins, Tekton, ArgoCD]
    secrets_management: [Vault, SOPS, AWS Secrets Manager, Azure Key Vault]
```

## Application Types

| Type | Description | Typical Stack |
|------|-------------|---------------|
| **Fullstack** | Complete web application with frontend and backend | Backend + Frontend + Database |
| **Web App** | Frontend-focused web application | Frontend + Optional Backend |
| **Web API** | RESTful or GraphQL API service | Backend + Database |
| **Microservice** | Distributed service in microservices architecture | Backend + Database + Messaging |
| **CLI** | Command-line interface tool | Language + Libraries |
| **Library** | Reusable code library/package | Language + Build Tools |
| **Mobile App** | Native or cross-platform mobile application | Mobile Framework + Backend |
| **Mobile Service** | Backend service for mobile applications | Backend + Database + Push |
| **Desktop** | Desktop application | Language + GUI Framework |
| **IoT Service** | Internet of Things backend service | Backend + Time-series DB + MQTT |
| **Browser Extension** | Browser extension/add-on | TypeScript/JavaScript |

## Language Options

### Backend Languages

| Language | Best For | Key Frameworks | Learning Curve |
|----------|----------|----------------|----------------|
| **Go** | High-performance services, microservices, CLI | Gin, Fiber, go-zero, Echo, Chi | Low-Medium |
| **Rust** | Performance-critical, systems programming, CLI | Axum, Salvo, Actix-web, Warp | High |
| **Node.js** | Rapid development, real-time apps, APIs | Express, Fastify, NestJS, Hono | Low |
| **Python** | Data science, AI/ML, rapid prototyping | FastAPI, Django, Flask | Low |
| **Java** | Enterprise applications, large teams | Spring Boot, Quarkus, Micronaut | Medium-High |
| **C#** | Enterprise, Windows ecosystem | ASP.NET Core, FastEndpoints | Medium |
| **Kotlin** | Android backend, modern Java alternative | Ktor, Spring Boot, Quarkus | Medium |
| **Elixir** | Real-time, high-concurrency | Phoenix, Plug | Medium-High |
| **Zig** | Systems programming, embedded | Built-in HTTP server | High |

### Frontend Languages

| Language | Best For | Key Frameworks |
|----------|----------|----------------|
| **TypeScript** | Type-safe frontend development | Vue, React, Angular, Svelte, Solid |
| **JavaScript** | Quick prototyping, small projects | Vue, React, Svelte |
| **Dart** | Cross-platform mobile/web | Flutter |
| **Kotlin** | Android native | Jetpack Compose |
| **Swift** | iOS native | SwiftUI |

## Framework Recommendations

### Go Backend Frameworks

| Framework | Type | Best For | Key Features |
|-----------|------|----------|--------------|
| **Gin** | Minimal | REST APIs, microservices | Fast, middleware ecosystem |
| **Fiber** | Minimal | High-performance APIs | Express-like API, fast |
| **go-zero** | Full-stack | Microservices | Built-in code generation, service discovery |
| **Echo** | Minimal | REST APIs | Middleware, auto TLS |
| **Chi** | Minimal | REST APIs | Lightweight, Go 1.22+ routing |
| **Kratos** | Full-stack | Microservices | Bilibili's framework, gRPC |
| **GoFrame** | Full-stack | Enterprise apps | ORM, caching, i18n |
| **Hertz** | Minimal | Cloud-native APIs | ByteDance, CloudWeGo |

### Rust Backend Frameworks

| Framework | Type | Best For | Key Features |
|-----------|------|----------|--------------|
| **Axum** | Minimal | High-performance APIs | Tokio ecosystem, ergonomic |
| **Salvo** | Full-stack | Web applications | Middleware, WebSocket, async |
| **Actix-web** | Full-stack | High-performance | Actor model, mature |
| **Warp** | Minimal | REST APIs | Filter-based routing |
| **Rocket** | Full-stack | Type-safe web apps | Compile-time checks |
| **Poem** | Minimal | Async APIs | OpenAPI, GraphQL support |

### Node.js Backend Frameworks

| Framework | Type | Best For | Key Features |
|-----------|------|----------|--------------|
| **Express** | Minimal | REST APIs, quick start | Large ecosystem |
| **Fastify** | Minimal | High-performance APIs | Schema validation, fast |
| **NestJS** | Full-stack | Enterprise applications | TypeScript, DI, modules |
| **Hono** | Minimal | Edge computing | Ultra-fast, multi-runtime |
| **Koa** | Minimal | APIs | Async/await, lightweight |
| **Elysia** | Minimal | High-performance APIs | Bun-optimized, type-safe |

### Python Backend Frameworks

| Framework | Type | Best For | Key Features |
|-----------|------|----------|--------------|
| **FastAPI** | Minimal | APIs, async | Auto docs, type hints, async |
| **Django** | Full-stack | Enterprise apps | ORM, admin, batteries included |
| **Flask** | Minimal | Small apps, APIs | Flexible, extensions |
| **Starlette** | Minimal | Async APIs | Lightweight, ASGI |
| **Sanic** | Minimal | High-performance APIs | Async-first |

### Frontend Frameworks

| Framework | Language | Best For | Key Features |
|-----------|----------|----------|--------------|
| **Vue 3** | TypeScript | Progressive web apps | Composition API, easy learning |
| **React** | TypeScript | Large-scale apps | Component ecosystem, hooks |
| **Angular** | TypeScript | Enterprise apps | Full framework, DI, RxJS |
| **Svelte** | TypeScript | Performance-critical | Compile-time, no VDOM |
| **Solid** | TypeScript | High-performance | Fine-grained reactivity |
| **Quasar** | TypeScript | Cross-platform | Vue-based, mobile/desktop |
| **Nuxt** | TypeScript | SSR/SSG | Vue meta-framework |
| **Next.js** | TypeScript | SSR/SSG | React meta-framework |
| **Astro** | TypeScript | Content sites | Multi-framework, islands |

### Mobile Frameworks

| Framework | Language | Best For | Key Features |
|-----------|----------|----------|--------------|
| **Flutter** | Dart | Cross-platform | Single codebase, hot reload |
| **React Native** | TypeScript | Cross-platform | React ecosystem, native modules |
| **Kotlin Multiplatform** | Kotlin | Shared logic | Native UI, business logic sharing |
| **Capacitor** | TypeScript | Hybrid apps | Web tech, native plugins |

### CLI Frameworks

| Language | Frameworks |
|----------|------------|
| **Go** | Cobra, urfave/cli, Kong, Bubble Tea |
| **Rust** | clap, structopt, argh |
| **Python** | Click, Typer, argparse |
| **Node.js** | Commander, Yargs, oclif |
| **Zig** | Built-in argument parsing |

## Database Options

### Relational Databases

| Database | Best For | Key Features |
|----------|----------|--------------|
| **PostgreSQL** | General purpose, complex queries | Extensions, JSON, full-text search |
| **MySQL** | Web applications, read-heavy | Wide hosting support, simple |
| **TiDB** | Distributed SQL, HTAP | MySQL compatible, horizontal scaling |
| **CockroachDB** | Distributed SQL | PostgreSQL compatible, resilience |
| **SQLite** | Embedded, small apps | Zero-config, single file |
| **MariaDB** | MySQL alternative | Open source, compatible |

### Time-Series Databases

| Database | Best For | Key Features |
|----------|----------|--------------|
| **TDengine** | IoT, monitoring | High performance, SQL support |
| **InfluxDB** | Monitoring, metrics | Flux query language, cloud option |
| **TimescaleDB** | PostgreSQL users | PostgreSQL extension, SQL |
| **QuestDB** | High-throughput | SQL, PostgreSQL wire protocol |
| **Victoria Metrics** | Monitoring | Prometheus compatible, efficient |

### Graph Databases

| Database | Best For | Key Features |
|----------|----------|--------------|
| **NebulaGraph** | Large-scale graphs | Distributed, high performance |
| **Dgraph** | Distributed graphs | GraphQL native, horizontal scaling |
| **Neo4j** | General graph use | Cypher query, mature ecosystem |
| **ArangoDB** | Multi-model | Graph + Document + Key-Value |

### Document Databases

| Database | Best For | Key Features |
|----------|----------|--------------|
| **MongoDB** | General document store | Flexible schema, aggregation |
| **CouchDB** | Offline-first apps | Sync, REST API |
| **FerretDB** | MongoDB alternative | PostgreSQL backend, open source |

### Search Engines

| Database | Best For | Key Features |
|----------|----------|--------------|
| **Elasticsearch** | Full-text search, logs | Distributed, analytics |
| **Meilisearch** | Search as a service | Fast, typo-tolerant |
| **Typesense** | Search engine | Fast, typo-tolerant, open source |
| **Quickwit** | Log analytics | Cloud-native, cost-effective |

## Caching Options

| Cache | Best For | Key Features |
|-------|----------|--------------|
| **Redis** | General purpose caching | Data structures, pub/sub, persistence |
| **Memcached** | Simple key-value caching | Simple, proven, distributed |
| **Dragonfly** | Redis alternative | Multi-threaded, Redis compatible |
| **BadgerDB** | Embedded caching | Go native, LSM tree |
| **In-Memory** | Single process | Fast, no network overhead |
| **File Cache** | Simple, persistent | No additional service needed |

## Message Queue Options

| Queue | Best For | Key Features |
|-------|----------|--------------|
| **Kafka** | Event streaming, big data | High throughput, durability, replay |
| **RabbitMQ** | Traditional messaging | AMQP, routing, reliability |
| **NATS** | Lightweight messaging | Fast, JetStream for persistence |
| **Redis Pub/Sub** | Simple pub/sub | Low latency, no persistence |
| **Apache Pulsar** | Multi-tenant messaging | Geo-replication, tiered storage |
| **MQTT** | IoT messaging | Lightweight, QoS levels |
| **ZeroMQ** | High-performance messaging | Brokerless, low latency |

## Container Orchestration Options

| Platform | Best For | Key Features |
|----------|----------|--------------|
| **Kubernetes** | Large-scale, production | Auto-scaling, self-healing, ecosystem |
| **Docker Swarm** | Small-medium deployments | Simple, Docker native |
| **Nomad** | Mixed workloads | Flexible, simple, multi-region |
| **Docker Compose** | Development, small apps | Simple, single-host |
| **None** | Simple deployments | Direct deployment, VMs |

## SSO/IAM Options

| Solution | Best For | Key Features |
|----------|----------|--------------|
| **Casdoor** | Open source IAM | OAuth2, OIDC, SAML, multi-tenant |
| **Keycloak** | Enterprise SSO | Feature-rich, standards compliant |
| **Authentik** | Modern SSO | Docker-native, flexible flows |
| **Ory Kratos/Hydra** | Cloud-native | Microservices, headless |
| **Auth0** | Managed service | Easy setup, enterprise features |
| **Firebase Auth** | Mobile/web apps | Easy integration, Google managed |
| **AWS Cognito** | AWS ecosystem | Managed, AWS integration |

## Monitoring Options

| Solution | Best For | Key Features |
|----------|----------|--------------|
| **Prometheus + Grafana** | General monitoring | Open source, alerting, visualization |
| **Datadog** | Enterprise monitoring | Full-stack APM, easy setup |
| **New Relic** | Enterprise APM | Full observability, easy setup |
| **OpenTelemetry** | Vendor-neutral | Standard, flexible backend |
| **Zabbix** | Infrastructure monitoring | Mature, agent-based |
| **Victoria Metrics** | Prometheus alternative | Cost-effective, high performance |

## API Gateway Options

| Gateway | Best For | Key Features |
|---------|----------|--------------|
| **Kong** | Enterprise APIs | Plugins, declarative config |
| **Traefik** | Cloud-native | Auto-discovery, Let's Encrypt |
| **Envoy** | Service mesh | High performance, observability |
| **Nginx** | General purpose | Proven, flexible |
| **APISIX** | Cloud-native APIs | Dynamic routing, plugins |
| **Tyk** | Enterprise APIs | Developer portal, analytics |

## CI/CD Options

| Platform | Best For | Key Features |
|----------|----------|--------------|
| **GitHub Actions** | GitHub users | Native integration, marketplace |
| **GitLab CI** | GitLab users | Built-in, Docker support |
| **Jenkins** | Enterprise, complex | Plugin ecosystem, flexibility |
| **Tekton** | Kubernetes-native | Cloud-native, declarative |
| **ArgoCD** | GitOps | Kubernetes-native, declarative |

## Secrets Management Options

| Solution | Best For | Key Features |
|----------|----------|--------------|
| **Vault** | Enterprise secrets | Dynamic secrets, audit |
| **SOPS** | GitOps secrets | Encrypt in Git, simple |
| **AWS Secrets Manager** | AWS ecosystem | Managed, rotation |
| **Azure Key Vault** | Azure ecosystem | Managed, HSM support |
| **Infisical** | Developer-friendly | Open source, CLI-first |

## Implementation

### Step 1: Application Type Selection

Ask the user:
```
What type of application are you building?

1. Fullstack (Frontend + Backend)
2. Web Application (Frontend-focused)
3. Web API / Backend Service
4. Microservice
5. CLI (Command Line Interface)
6. Library / Package
7. Mobile App
8. Mobile Service (Backend for mobile)
9. Desktop Application
10. IoT Service
11. Browser Extension

Please select by number or name:
```

### Step 2: Language Selection

Based on application type, ask appropriate questions:

**For Fullstack:**
```
Select your backend language:
1. Go - High performance, simple concurrency
2. Rust - Maximum performance, memory safety
3. Node.js - Rapid development, JavaScript ecosystem
4. Python - AI/ML integration, rapid prototyping
5. Java - Enterprise, large teams
6. C# - Microsoft ecosystem, enterprise
7. Kotlin - Modern, Java alternative
8. Elixir - Real-time, high concurrency

Select your frontend language:
1. TypeScript - Type-safe, modern
2. JavaScript - Quick start, large ecosystem
3. Dart (Flutter) - Cross-platform mobile/web
```

**For Web API / Microservice:**
```
Select your backend language:
[Same options as above]
```

**For CLI:**
```
Select your CLI language:
1. Go - Fast compilation, single binary
2. Rust - Performance, safety
3. Python - Rapid development
4. Node.js - JavaScript ecosystem
5. Zig - Systems programming
```

**For Mobile App:**
```
Select your mobile framework:
1. Flutter (Dart) - Cross-platform, single codebase
2. React Native (TypeScript) - React ecosystem
3. Kotlin Multiplatform - Shared logic, native UI
4. Native Android (Kotlin)
5. Native iOS (Swift)
```

### Step 3: Framework Selection

Based on language selection, recommend frameworks:

**For Go Backend:**
```
Select your Go framework:
1. Gin - Minimal, fast, popular
2. Fiber - Express-like, high performance
3. go-zero - Microservices, code generation
4. Echo - Minimal, middleware ecosystem
5. Chi - Lightweight, Go 1.22+ routing
6. Kratos - Microservices (Bilibili)
7. GoFrame - Full-stack enterprise
8. Hertz - Cloud-native (ByteDance)
```

**For Rust Backend:**
```
Select your Rust framework:
1. Axum - Tokio ecosystem, ergonomic
2. Salvo - Full-stack, feature-rich
3. Actix-web - Mature, actor model
4. Warp - Filter-based routing
5. Rocket - Type-safe, compile-time checks
6. Poem - Async, OpenAPI support
```

**For Node.js Backend:**
```
Select your Node.js framework:
1. Express - Popular, large ecosystem
2. Fastify - High performance, schema validation
3. NestJS - Enterprise, TypeScript-first
4. Hono - Ultra-fast, edge computing
5. Koa - Async/await, lightweight
6. Elysia - Bun-optimized, type-safe
```

**For Python Backend:**
```
Select your Python framework:
1. FastAPI - Async, auto docs, type hints
2. Django - Full-stack, batteries included
3. Flask - Flexible, minimal
4. Starlette - Lightweight async
5. Sanic - High-performance async
```

**For Frontend (TypeScript):**
```
Select your frontend framework:
1. Vue 3 + Quasar - Progressive, cross-platform
2. Vue 3 + Vite - Progressive, lightweight
3. React + Next.js - SSR/SSG, enterprise
4. React + Vite - SPA, flexible
5. Angular - Enterprise, full framework
6. Svelte + SvelteKit - Compile-time, fast
7. Solid + SolidStart - Fine-grained reactivity
8. Nuxt - Vue meta-framework, SSR
9. Astro - Content-focused, multi-framework
```

### Step 4: Database Selection

```
Do you need a relational database? (y/n)

If yes, select:
1. PostgreSQL - General purpose, feature-rich
2. MySQL - Popular, wide hosting support
3. TiDB - Distributed SQL, MySQL compatible
4. CockroachDB - Distributed, PostgreSQL compatible
5. SQLite - Embedded, simple
6. MariaDB - MySQL alternative, open source

Do you need a time-series database? (y/n)

If yes, select:
1. TDengine - High performance, IoT
2. InfluxDB - Monitoring, metrics
3. TimescaleDB - PostgreSQL extension
4. QuestDB - High-throughput, SQL
5. Victoria Metrics - Prometheus compatible

Do you need a graph database? (y/n)

If yes, select:
1. NebulaGraph - Distributed, large-scale
2. Dgraph - GraphQL native
3. Neo4j - Mature, Cypher query
4. ArangoDB - Multi-model

Do you need a document database? (y/n)

If yes, select:
1. MongoDB - Popular, flexible schema
2. CouchDB - Offline-first, sync
3. FerretDB - PostgreSQL backend

Do you need a search engine? (y/n)

If yes, select:
1. Elasticsearch - Full-text, analytics
2. Meilisearch - Fast, typo-tolerant
3. Typesense - Fast, open source
4. Quickwit - Log analytics
```

### Step 5: Caching Selection

```
Do you need caching? (y/n)

If yes, select:
1. Redis - General purpose, data structures
2. Memcached - Simple key-value
3. Dragonfly - Redis compatible, multi-threaded
4. BadgerDB - Embedded, Go native
5. In-Memory - Fast, single process
6. File Cache - Simple, persistent
```

### Step 6: Message Queue Selection

```
Do you need a message queue? (y/n)

If yes, select:
1. Kafka - Event streaming, high throughput
2. RabbitMQ - Traditional messaging, AMQP
3. NATS - Lightweight, fast
4. Redis Pub/Sub - Simple, low latency
5. Apache Pulsar - Multi-tenant, geo-replication
6. MQTT - IoT, lightweight
7. ZeroMQ - Brokerless, high performance
```

### Step 7: Container Orchestration Selection

```
Select your deployment strategy:
1. Kubernetes - Large-scale, production
2. Docker Swarm - Simple, Docker native
3. Nomad - Flexible, mixed workloads
4. Docker Compose - Development, small apps
5. None (Direct deployment/VMs)
```

### Step 8: SSO/IAM Selection

```
Do you need SSO/IAM? (y/n)

If yes, select:
1. Casdoor - Open source, multi-tenant
2. Keycloak - Enterprise, feature-rich
3. Authentik - Modern, Docker-native
4. Ory Kratos/Hydra - Cloud-native, headless
5. Auth0 - Managed service
6. Firebase Auth - Mobile/web, Google managed
7. AWS Cognito - AWS ecosystem
8. Custom implementation
```

### Step 9: Monitoring Selection

```
Select your monitoring solution:
1. Prometheus + Grafana - Open source, popular
2. Datadog - Enterprise, full-stack APM
3. New Relic - Enterprise, easy setup
4. OpenTelemetry - Vendor-neutral
5. Zabbix - Infrastructure, agent-based
6. Victoria Metrics - Cost-effective
7. None (Will configure later)
```

### Step 10: Additional Infrastructure

```
Do you need an API Gateway? (y/n)

If yes, select:
1. Kong - Enterprise, plugins
2. Traefik - Cloud-native, auto-discovery
3. Envoy - Service mesh, high performance
4. Nginx - Proven, flexible
5. APISIX - Cloud-native, dynamic
6. Tyk - Enterprise, developer portal

Select your CI/CD platform:
1. GitHub Actions - GitHub native
2. GitLab CI - GitLab native
3. Jenkins - Enterprise, flexible
4. Tekton - Kubernetes-native
5. ArgoCD - GitOps
6. None (Will configure later)

Do you need secrets management? (y/n)

If yes, select:
1. Vault - Enterprise, dynamic secrets
2. SOPS - GitOps, simple
3. AWS Secrets Manager - AWS native
4. Azure Key Vault - Azure native
5. Infisical - Developer-friendly, open source
```

### Step 11: Generate Tech Stack Summary

After all selections, generate a summary:

```yaml
tech_stack_summary:
  project_name: "<project_name>"
  application_type: "<selected_type>"
  
  languages:
    backend: "<backend_language>"
    frontend: "<frontend_language>"
    
  frameworks:
    backend: "<backend_framework>"
    frontend: "<frontend_framework>"
    
  databases:
    relational: "<relational_db>"
    time_series: "<time_series_db or none>"
    graph: "<graph_db or none>"
    document: "<document_db or none>"
    search: "<search_engine or none>"
    
  caching: "<cache_solution or none>"
  
  messaging: "<message_queue or none>"
  
  infrastructure:
    orchestration: "<container_platform>"
    api_gateway: "<gateway or none>"
    sso_iam: "<sso_solution or none>"
    monitoring: "<monitoring_solution>"
    ci_cd: "<ci_cd_platform>"
    secrets: "<secrets_solution or none>"
    
  adr_reference: "ADR-XXX: Technology Stack Selection"
```

### Step 12: Create Architecture Decision Record

Use `architecture-decision-recorder` to document all technology decisions:

```markdown
# ADR-XXX: Technology Stack Selection

## Context
<Application type and requirements summary>

## Decision
<Selected technology stack summary>

## Consequences
**Positive:**
- <Benefit 1>
- <Benefit 2>

**Negative:**
- <Trade-off 1>
- <Trade-off 2>

## Alternatives Considered
For each technology choice:
1. <Alternative> - <Why not selected>
2. <Alternative> - <Why not selected>

## Related Decisions
- ADR-YYY: Architecture Pattern Selection
```

## Common Mistakes

### ❌ Choosing Too Many Technologies
**Problem:** Adding every technology "just in case"
**Solution:** Start minimal, add when needed (YAGNI)

### ❌ Ignoring Team Expertise
**Problem:** Selecting technologies team doesn't know
**Solution:** Factor team skills into evaluation

### ❌ Following Trends Blindly
**Problem:** Using "cool" tech without justification
**Solution:** Evaluate based on project requirements

### ❌ Not Considering Operational Costs
**Problem:** Complex stack with high maintenance
**Solution:** Include operational complexity in evaluation

### ❌ Skipping Documentation
**Problem:** No record of why decisions were made
**Solution:** Always create ADR for tech stack decisions

### ❌ Over-engineering Day One
**Problem:** Designing for scale that may never come
**Solution:** Start simple, evolve when needed

## Red Flags

| Rationalization | Reality | Counter |
|-----------------|---------|---------|
| "We need all these databases" | Multiple data stores add complexity | Start with one, add when needed |
| "Microservices for scalability" | Premature microservices slow development | Start with monolith, split when needed |
| "Everyone uses [technology]" | Trends don't match your needs | Evaluate based on YOUR requirements |
| "We might need it later" | YAGNI - adds complexity now | Add when actual need arises |
| "It's the newest framework" | New ≠ better for your case | Consider maturity and ecosystem |

## Integration with Aether.go Methodology

### Stage 4: Implementation Planning

```
Stage 3: Constitutional Review
        ↓
Stage 4: Implementation Planning
        ├── architecture-pattern-selector (architecture pattern)
        ├── tech-stack-selector (this skill)
        ├── architecture-decision-recorder (document decisions)
        └── data-flow-analyzer (data architecture)
        ↓
Stage 5: Code Generation
```

### Constitutional Compliance

- **Simplicity & YAGNI**: Start with minimal stack, add when needed
- **Appropriate Technology**: Match technology to actual requirements
- **Business Value Alignment**: Consider time-to-market and costs
- **Team Empowerment**: Select technologies team can operate

### Skill Dependencies

- **Required**: `architecture-decision-recorder` for documentation
- **Recommended**: `architecture-pattern-selector` for architecture pattern
- **Optional**: `methodology-fusion-orchestrator` for full workflow

## Real-World Impact

### Success Story: Minimal Stack
**Situation:** Startup needed MVP in 2 months
**Selection:** Go + Gin + PostgreSQL + Vue + Redis
**Result:** Launched on time, scaled to 100k users without changes

### Failure Story: Over-engineering
**Situation:** Internal tool for 50 users
**Selection:** Microservices + Kafka + Elasticsearch + Kubernetes
**Result:** 6 months development, 3x budget, team burnout

### Quantitative Benefits
- **50% faster development** with appropriate stack
- **70% lower operational costs** with minimal stack
- **80% fewer production issues** with team-aligned choices
- **60% easier hiring** with popular technologies
