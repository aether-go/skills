---
name: contract-test-generator
description: Use when generating consumer-driven contract tests for microservices APIs to ensure compatibility and prevent integration failures
---

# Contract Test Generator

## Overview
Generate consumer-driven contract tests that ensure microservices API compatibility across service boundaries. Creates contract definitions (Pact, OpenAPI) and validation tests that run in CI/CD pipelines to prevent integration failures before deployment.

## When to Use

```
Need microservices API compatibility? ─────┐
                                          │
Consumer-driven contracts required? ───────┤
                                          ├─► Use contract-test-generator
Prevent integration failures in CI/CD? ────┤
                                          │
API versioning and evolution? ─────────────┘
```

Use when:
- Building microservices architectures with multiple consumers
- Need to ensure API compatibility between services
- Implementing consumer-driven contract testing (Pact, OpenAPI)
- Preventing integration failures in CI/CD pipelines
- Managing API versioning and evolution
- Need automated contract validation

Don't use when:
- Monolithic applications without service boundaries
- Simple CRUD APIs with single consumer
- Manual testing suffices
- No CI/CD pipeline for automated validation

## Core Pattern

### Consumer-Driven Contract Testing Workflow

```
Consumer Service → Define Expectations → Contract Generator → Pact/OpenAPI File
       ↑                                                                 ↓
       └── Provider Verification ←── CI/CD Pipeline ←── Contract Publishing
```

### Before (Manual Integration Testing)
```
Consumer team: "We need new API endpoint"
Provider team: Implements based on vague spec
Integration fails in production
Result: Service disruption, debugging chaos
```

### After (Automated Contract Testing)
```yaml
# Contract Test Generation Workflow
workflow_id: "CT-API-001"
contracts_generated:
  - consumer: "order-service"
    provider: "payment-service"
    interactions:
      - request:
          method: POST
          path: "/payments"
          body: { "order_id": "123", "amount": 99.99 }
        response:
          status: 201
          body: { "payment_id": "abc", "status": "processed" }
    pact_file: "pacts/order-service-payment-service.json"
    ci_integration: true
    
validation_results:
  - provider: "payment-service"
    verification: passed
    mismatches: 0
    ci_status: "green"
    
impact:
  - integration_failures_prevented: 3
  - deployment_confidence: "99%"
  - developer_feedback_cycle: "5 minutes"
```

## Quick Reference

### Supported Contract Formats

| Format | Tools | Use Case |
|--------|-------|----------|
| **Pact** | Pact Broker, Pact CLI | Consumer-driven contracts with provider verification |
| **OpenAPI** | Swagger, OpenAPI Generator | API specification with validation |
| **AsyncAPI** | AsyncAPI Generator | Event-driven architectures |
| **GraphQL** | GraphQL Codegen | GraphQL schema contracts |

### Integration Points

```yaml
ci_cd_integration:
  pipeline_stages:
    - contract_generation:
        trigger: "on_api_change"
        tools: ["pact", "openapi"]
        output: "./contracts"
        
    - contract_validation:
        trigger: "before_deployment"
        provider_verification: true
        fail_on_mismatch: true
        
    - contract_publishing:
        trigger: "on_success"
        publish_to: "pact_broker"
        versioning: "semantic"
```

### Common Test Patterns

```python
# Example Pact contract generation
def generate_pact_contract(consumer, provider, interactions):
    pact = Consumer(consumer).has_pact_with(Provider(provider))
    
    for interaction in interactions:
        pact.given(interaction['state']).upon_receiving(
            interaction['description']
        ).with_request(
            method=interaction['request']['method'],
            path=interaction['request']['path'],
            body=interaction['request'].get('body')
        ).will_respond_with(
            status=interaction['response']['status'],
            body=interaction['response'].get('body')
        )
    
    pact.verify()
    return pact
```

## Implementation

### Contract Generator Engine

```python
class ContractTestGenerator:
    """Generate consumer-driven contract tests."""
    
    def __init__(self, format="pact", broker_url=None):
        self.format = format
        self.broker_url = broker_url
        self.contracts = []
        
    def generate_contract(self, consumer, provider, interactions):
        """Generate contract between consumer and provider."""
        
        contract = {
            'consumer': consumer,
            'provider': provider,
            'interactions': interactions,
            'metadata': {
                'generated_at': datetime.now(),
                'format': self.format,
                'version': '1.0'
            }
        }
        
        if self.format == "pact":
            return self._generate_pact(contract)
        elif self.format == "openapi":
            return self._generate_openapi(contract)
        elif self.format == "asyncapi":
            return self._generate_asyncapi(contract)
            
        raise ValueError(f"Unsupported format: {self.format}")
    
    def _generate_pact(self, contract):
        """Generate Pact contract file."""
        
        pact_spec = {
            'consumer': {'name': contract['consumer']},
            'provider': {'name': contract['provider']},
            'interactions': [],
            'metadata': {
                'pactSpecification': {'version': '3.0.0'},
                'createdAt': contract['metadata']['generated_at'].isoformat()
            }
        }
        
        for idx, interaction in enumerate(contract['interactions']):
            pact_interaction = {
                'description': interaction.get('description', f"Interaction {idx}"),
                'providerState': interaction.get('state'),
                'request': {
                    'method': interaction['request']['method'],
                    'path': interaction['request']['path']
                },
                'response': {
                    'status': interaction['response']['status']
                }
            }
            
            if 'body' in interaction['request']:
                pact_interaction['request']['body'] = interaction['request']['body']
            if 'body' in interaction['response']:
                pact_interaction['response']['body'] = interaction['response']['body']
                
            pact_spec['interactions'].append(pact_interaction)
        
        return {
            'format': 'pact',
            'spec': pact_spec,
            'file_path': f"pacts/{contract['consumer']}-{contract['provider']}.json"
        }
    
    def _generate_openapi(self, contract):
        """Generate OpenAPI specification."""
        
        openapi_spec = {
            'openapi': '3.0.0',
            'info': {
                'title': f"{contract['provider']} API",
                'version': '1.0.0'
            },
            'paths': {},
            'components': {
                'schemas': {}
            }
        }
        
        # Convert interactions to OpenAPI paths
        for interaction in contract['interactions']:
            path = interaction['request']['path']
            method = interaction['request']['method'].lower()
            
            if path not in openapi_spec['paths']:
                openapi_spec['paths'][path] = {}
            
            openapi_spec['paths'][path][method] = {
                'responses': {
                    str(interaction['response']['status']): {
                        'description': 'Successful response',
                        'content': {
                            'application/json': {
                                'schema': {
                                    'type': 'object',
                                    'properties': self._extract_schema(interaction['response'].get('body', {}))
                                }
                            }
                        }
                    }
                }
            }
            
            if 'body' in interaction['request']:
                openapi_spec['paths'][path][method]['requestBody'] = {
                    'content': {
                        'application/json': {
                            'schema': {
                                'type': 'object',
                                'properties': self._extract_schema(interaction['request']['body'])
                            }
                        }
                    }
                }
        
        return {
            'format': 'openapi',
            'spec': openapi_spec,
            'file_path': f"openapi/{contract['provider']}.yaml"
        }
    
    def _extract_schema(self, data):
        """Extract JSON schema from data sample."""
        
        if isinstance(data, dict):
            return {
                key: {'type': type(value).__name__}
                for key, value in data.items()
            }
        return {}
```

### CI/CD Integration

```yaml
# .github/workflows/contract-tests.yml
name: Contract Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  generate-contracts:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Generate contract tests
        uses: contract-test-generator-action@v1
        with:
          format: "pact"
          consumer: "${{ github.event.repository.name }}"
          provider: "payment-service"
          interactions: "${{ secrets.CONTRACT_INTERACTIONS }}"
          
      - name: Publish to Pact Broker
        run: |
          pact-broker publish pacts/*.json \
            --consumer-app-version=${{ github.sha }} \
            --broker-base-url=${{ secrets.PACT_BROKER_URL }}
            
  verify-contracts:
    runs-on: ubuntu-latest
    needs: generate-contracts
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Verify provider against contracts
        run: |
          pact-verifier \
            --provider-base-url=http://localhost:8080 \
            --pact-broker-base-url=${{ secrets.PACT_BROKER_URL }} \
            --provider-app-version=${{ github.sha }}
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Generating contracts after implementation | Defeats consumer-driven approach | Generate contracts before implementation |
| Not versioning contracts | Breaks compatibility tracking | Use semantic versioning for contracts |
| Skipping provider verification | Allows breaking changes to slip through | Always verify provider against contracts |
| Hardcoding test data | Brittle tests that break on data changes | Use matchers and flexible matching |
| Ignoring CI/CD integration | Manual validation misses failures | Integrate contract tests into pipeline |
| Not sharing contracts | Teams work in isolation | Use contract broker for sharing |

### Red Flags
- Manual contract generation
- No CI/CD integration
- Contracts not versioned
- No provider verification
- Hardcoded expectations
- Missing contract broker

## Real-World Impact

**Before (Manual Integration Testing):**
- Microservices teams develop independently
- Integration failures discovered in production
- Debugging takes days across team boundaries
- API changes break consumers unexpectedly
- Low deployment confidence

**After (Automated Contract Testing):**
- Consumer expectations drive provider implementation
- Integration failures caught in CI/CD
- API changes validated against all consumers
- High deployment confidence
- Teams can release independently

**Outcome:** Faster releases, fewer production incidents, independent team deployments, predictable API evolution.

## Integration with Aether.go Methodology

### Specification-Driven Contracts

```yaml
# Contract generation from specifications
specification_driven_contracts:
  source: "spec-parser output"
  transformation:
    - user_stories → API endpoints
    - acceptance_criteria → contract expectations
  validation:
    - constitutional_principle: "API Compatibility"
      check: "All API changes have corresponding contract updates"
      enforcement: strict
```

### Constitutional Principle Integration

```yaml
constitution_enforcement:
  stage_6_integration_validation:
    - principle: "API Compatibility"
      check: "Contract tests exist for all service boundaries"
      enforcement: strict
      
  stage_7_deployment:
    - principle: "Integration Safety"
      check: "Contract verification passes before deployment"
      enforcement: strict
```

### Metrics and Feedback

```python
# Contract testing metrics
contract_metrics = {
    'compatibility_score': calculate_compatibility_score(contracts),
    'integration_failure_rate': track_integration_failures(deployments),
    'contract_coverage': measure_contract_coverage(apis),
    'verification_latency': monitor_verification_times(ci_runs)
}

# Feedback loop for improvement
feedback_loop = {
    'detect': "Contract verification failures",
    'analyze': "Root cause of mismatches",
    'improve': "Update contracts or implementations",
    'validate': "Re-run verification"
}
```

### Cross-Skill Integration

- **spec-parser**: Source of API specifications
- **tdd-red-green-refactor**: Contract tests as part of TDD
- **sit-scenario-generator**: Integration test scenarios
- **metrics-definer**: Contract coverage metrics
- **deployment-orchestrator**: Contract verification gate

**Result:** End-to-end contract testing integrated into development workflow, ensuring API compatibility and preventing integration failures.