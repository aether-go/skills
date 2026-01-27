---
name: contract-test-generator
description: Use when generating consumer-driven contract tests for microservices APIs to ensure compatibility and prevent integration failures
---

# Contract Test Generator

## Overview
Generate consumer-driven contract tests for microservices APIs using Pact, OpenAPI, and other contract testing frameworks. Ensures API compatibility between services, prevents breaking changes in production, and establishes reliable integration points within distributed systems. Integrates with Aether.go methodology fusion framework to provide automated contract validation in the integration verification stage.

## When to Use

```
Need to ensure API compatibility? ──────┐
                                        │
Microservices with dependencies? ───────┤
                                        ├─► Use contract-test-generator
Consumer-driven testing needed? ────────┤
                                        │
Prevent breaking changes in production? ─┘
```

Use when:
- Developing or consuming microservices APIs
- Preventing breaking changes between service versions
- Establishing reliable service integration points
- Implementing consumer-driven contract testing (Pact, Spring Cloud Contract)
- Validating OpenAPI/Swagger specifications against implementations
- Ensuring backward and forward compatibility
- Automating API compatibility checks in CI/CD pipelines

Don't use when:
- Testing single service in isolation (use unit/integration tests)
- Simple API with single consumer (consider integration tests)
- No API boundaries between components
- Project uses monolithic architecture without service boundaries
- Manual coordination is acceptable (rarely true)

## Core Pattern

### Consumer-Driven Contract Testing Approach

```
Consumer Spec → Contract Generation → Provider Verification → CI/CD Integration
     ↓                 ↓                    ↓                     ↓
Define API      Generate Pact/        Validate API      Automate compatibility
expectations    OpenAPI contracts    implementation     checks in pipelines
```

### Before (Reactive, Manual Testing)
```
Team A: Updates User Service API response format
Team B: Order Service crashes in production
Emergency: Manual debugging, temporary fixes, blame game
Root Cause: No automated contract validation
Result: Production downtime, team friction, technical debt
```

### After (Proactive, Automated Contract Testing)
```yaml
# Consumer Specification (Order Service)
consumer: OrderService
provider: UserService
interactions:
  - request:
      method: GET
      path: /api/users/123
    response:
      status: 200
      body:
        id: "123"
        name: "John"
        email: "john@example.com"

# Contract Generation (Pact format)
{
  "consumer": {"name": "OrderService"},
  "provider": {"name": "UserService"},
  "interactions": [...],
  "metadata": {"pactSpecification": {"version": "3.0.0"}}
}

# Provider Verification
provider_states:
  - "user 123 exists"
verification:
  - run: "npm run test:pact:verify"
    env:
      PACT_BROKER_URL: "https://broker.example.com"
      PROVIDER_VERSION: "1.2.0"

# CI/CD Integration
pipeline:
  - stage: "contract-tests"
    steps:
      - "consumer: npm run test:pact:publish"
      - "provider: npm run test:pact:verify"
      - "gate: require pact_verification == 'success'"
```

## Quick Reference

| Framework | Language Support | Key Features | Integration Points |
|-----------|-----------------|--------------|-------------------|
| **Pact** | JavaScript, Java, Go, Python, .NET | Consumer-driven contracts, Pact Broker, provider states | CI/CD gates, deployment validation |
| **OpenAPI/Swagger** | All languages | Specification validation, mock generation, compatibility checks | API documentation, client generation |
| **Spring Cloud Contract** | Java/Kotlin | Producer-driven contracts, Stub Runner, WireMock integration | Spring Boot applications, JVM ecosystem |
| **AsyncAPI** | All languages | Event-driven APIs, message schemas, channel validation | Kafka, RabbitMQ, MQTT systems |
| **Protobuf/gRPC** | All languages | Binary contracts, schema evolution, backward compatibility | gRPC services, protocol buffers |

**Common Patterns:**
- `consumer_driven`: Define expectations from consumer perspective
- `provider_verification`: Validate provider implementation matches contracts
- `contract_as_code`: Store contracts in version control
- `pact_broker`: Central contract repository with versioning
- `can_i_deploy`: Deployment gates based on contract compatibility

## Implementation

### Step 1: Define Consumer Expectations
```javascript
// Order Service (Consumer) - Pact test example
const { Pact } = require('@pact-foundation/pact');
const { getOrderUser } = require('./orderService');

describe('Order Service - User API Contract', () => {
  const provider = new Pact({
    consumer: 'OrderService',
    provider: 'UserService',
  });

  beforeAll(() => provider.setup());
  afterEach(() => provider.verify());
  afterAll(() => provider.finalize());

  describe('get user by id', () => {
    it('returns user data with expected fields', async () => {
      // Define expected interaction
      await provider.addInteraction({
        state: 'user with id 123 exists',
        uponReceiving: 'a request for user 123',
        withRequest: {
          method: 'GET',
          path: '/api/users/123',
        },
        willRespondWith: {
          status: 200,
          headers: { 'Content-Type': 'application/json' },
          body: {
            id: Matchers.string('123'),
            name: Matchers.string('John'),
            email: Matchers.email('john@example.com')
          }
        }
      });

      // Execute test
      const user = await getOrderUser('123');
      expect(user).toEqual({
        id: '123',
        name: 'John',
        email: 'john@example.com'
      });
    });
  });
});
```

### Step 2: Generate and Publish Contracts
```bash
# Run consumer tests to generate contracts
npm run test:pact

# Publish contracts to Pact Broker
npm run pact:publish -- \
  --broker-base-url=https://broker.example.com \
  --consumer-version=1.0.0 \
  --branch=main
```

### Step 3: Verify Provider Implementation
```javascript
// User Service (Provider) - Pact verification
const { Verifier } = require('@pact-foundation/pact');

new Verifier().verifyProvider({
  provider: 'UserService',
  providerBaseUrl: 'http://localhost:3000',
  pactBrokerUrl: 'https://broker.example.com',
  providerVersion: '1.2.0',
  publishVerificationResult: true,
  consumerVersionSelectors: [
    { mainBranch: true },
    { deployedOrReleased: true }
  ]
}).then(() => {
  console.log('Pact verification successful!');
});
```

### Step 4: Integrate with CI/CD Pipeline
```yaml
# .github/workflows/contract-tests.yml
name: Contract Tests

on: [push, pull_request]

jobs:
  consumer-tests:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run consumer pact tests
        run: npm run test:pact
      - name: Publish contracts
        run: npm run pact:publish
        env:
          PACT_BROKER_URL: ${{ secrets.PACT_BROKER_URL }}
          PACT_BROKER_TOKEN: ${{ secrets.PACT_BROKER_TOKEN }}

  provider-verification:
    runs-on: ubuntu-latest
    needs: consumer-tests
    steps:
      - uses: actions/checkout@v2
      - name: Start provider service
        run: npm start &
      - name: Verify contracts
        run: npm run pact:verify
        env:
          PACT_BROKER_URL: ${{ secrets.PACT_BROKER_URL }}

  deployment-gate:
    runs-on: ubuntu-latest
    needs: [consumer-tests, provider-verification]
    steps:
      - name: Check deployment readiness
        run: |
          pact-broker can-i-deploy \
            --pacticipant=UserService \
            --version=1.2.0 \
            --to-environment=production
```

### Step 5: Monitor Contract Compliance
```yaml
# Contract compliance dashboard metrics
metrics:
  contract_coverage:
    consumers_with_contracts: 85%  # Percentage of consumers with contracts
    providers_verified: 92%         # Percentage of providers verified
    breaking_changes_prevented: 15  # Number of breaking changes caught
    production_incidents_related: 0 # API compatibility incidents in production
    mean_time_to_detect: "2h"       # Time to detect contract violations
```

## Common Mistakes

### ❌ Manual Contract Management
**Mistake:** Storing contracts in shared drives or email, lacking version control
**Fix:** Treat contracts as code - store in git, version with semver, review changes via PR

### ❌ Consumer-Only Testing
**Mistake:** Only consumers write tests, providers don't verify contracts
**Fix:** Implement bi-directional verification - consumers publish, providers verify

### ❌ Ignoring Schema Evolution
**Mistake:** Treating contracts as immutable, preventing API evolution
**Fix:** Use schema evolution strategies - additive changes, backward compatibility rules

### ❌ Late Contract Testing
**Mistake:** Testing contracts after integration issues occur
**Fix:** Shift-left contract testing - define contracts during API design phase

### ❌ No Deployment Gates
**Mistake:** Deploying without contract verification
**Fix:** Implement "can I deploy" gates in CI/CD pipelines

## Real-World Impact

### Before Contract Test Generator
- **Production incidents**: API breaking changes cause system outages
- **Team friction**: Blame game between consumer and provider teams
- **Slow releases**: Manual coordination delays deployments by days
- **Technical debt**: Workarounds and compatibility layers accumulate
- **Testing gaps**: Integration issues caught only in production

### After Contract Test Generator
- **Zero breaking changes**: Contract violations caught before deployment
- **Confident releases**: Automated verification enables continuous delivery
- **Team collaboration**: Shared contract understanding reduces conflicts
- **API evolution**: Safe, incremental changes with compatibility guarantees
- **Reduced MTTR**: Quick identification of contract violations

**Example Results:**
- 95% reduction in production incidents related to API compatibility
- Deployment coordination time reduced from 3 days to 2 hours
- Team satisfaction increased 40% due to reduced friction
- API evolution velocity increased 3x with safety guarantees

## Red Flags & Rationalizations

| Red Flag | Rationalization | Reality |
|----------|----------------|---------|
| "We'll just version the API" | "Versioning solves compatibility issues" | Versioning adds complexity; contracts prevent issues in first place |
| "Manual testing is enough" | "We can catch issues with manual testing" | Manual testing misses edge cases, doesn't scale, and is error-prone |
| "We trust our team" | "Our team communicates well, won't break things" | Trust is not a scalability strategy; automation prevents human error |
| "Contracts limit flexibility" | "We need freedom to change APIs quickly" | Contracts enable safe evolution; lack of contracts leads to breaking changes |
| "Too complex to implement" | "Contract testing adds too much overhead" | Initial setup pays off in reduced incidents and faster releases |
| "We don't have time" | "Deadlines prevent implementing contract testing" | Time spent fixing production issues exceeds prevention time |
| "We'll use OpenAPI schema validation instead of consumer-driven contracts" | "OpenAPI spec validation is enough; we don't need Pact" | OpenAPI validates provider implementation against spec, but doesn't capture consumer expectations; consumer-driven contracts ensure provider meets actual consumer needs |
| "Our integration tests already cover API compatibility" | "We have end-to-end tests that verify the whole flow" | Integration tests are slow, brittle, and don't provide clear ownership; contract tests are fast, owned by consumer/provider teams, and prevent breaking changes earlier |
| "We'll use feature flags to manage breaking changes" | "Feature flags let us deploy changes safely without contracts" | Feature flags add complexity and don't prevent contract violations; they're complementary to contracts, not a replacement |

**Violating contract discipline = violating system reliability standards.**

When you skip systematic contract testing:
1. **Silent breaking changes** enter production
2. **Consumer systems fail** unpredictably
3. **Debugging complexity** increases exponentially
4. **Team trust erodes** due to repeated incidents

**All of these mean: Use contract-test-generator for any microservices API. No exceptions.**