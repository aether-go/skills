---
name: sit-scenario-generator
description: Use when creating system integration testing (SIT) scenarios that span multiple services or API endpoints
---

# SIT Scenario Generator

## Overview
Generate comprehensive system integration test (SIT) scenarios that validate end-to-end workflows across multiple services, APIs, and subsystems. Creates automated test scripts for integration testing with realistic data and assertions.

## When to Use

```
Multiple services/components? ──────────────┐
                                            │
Need to validate integration? ──────────────┤
                                            ├─► Use sit-scenario-generator
API contracts or architecture available? ───┤
                                            │
Testing critical user journeys? ───────────┘
```

Use when:
- Creating integration tests across multiple services
- Validating API contracts and service interactions
- Testing critical user journeys spanning multiple components
- System architecture or OpenAPI specs available
- Onboarding to microservices architecture
- Pre-production regression testing
- Verifying data flow across system boundaries

Don't use when:
- Testing single service (use unit/integration tests)
- Business logic unit testing (use TDD skills)
- Simple component testing (use standard test frameworks)
- No API or service boundary to test

## Core Pattern

### SIT vs Other Test Levels

```
┌─────────────────────────────────────────────┐
│  E2E Tests (User Journey)                   │
│  Browser → UI → Frontend → Backend → DB     │
│  Slow, Full System, User Perspective        │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  SIT Tests (Service Integration)            │
│  API → Service A → Service B → Service C    │
│  Medium Speed, Service Boundaries, API Focus│
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│  Integration Tests (Single Service)        │
│  Controller → Service → Repository          │
│  Fast, Internal Components                   │
└─────────────────────────────────────────────┘
```

### Before (Manual SIT Testing)
```javascript
// ❌ Manual test execution, no automation
// 1. Create user via API
curl -X POST http://api/users -d '{"name":"John"}'

// 2. Create order via API (manual ID lookup)
curl -X POST http://api/orders -d '{"userId":"123","items":...}'

// 3. Check inventory (manual verification)
curl http://api/inventory/item/123

// 4. Verify payment (manual status check)
curl http://api/payments/456

// 5. Check email delivery (manual verification)
// 6. Verify analytics event (manual log check)

Issues:
- Slow, error-prone
- No automation
- Hard to reproduce
- No data assertions
- Not CI/CD ready
```

### After (Automated SIT Scenarios)
```javascript
// ✅ Automated SIT test with full workflow
describe('Order Processing SIT', () => {
  let userId, orderId, paymentId;

  it('creates user account', async () => {
    const response = await api.post('/users', {
      name: 'John Doe',
      email: 'john@example.com'
    });
    expect(response.status).toBe(201);
    expect(response.data.id).toBeDefined();
    userId = response.data.id;
  });

  it('creates order with valid user', async () => {
    const orderData = {
      userId,
      items: [{productId: 'prod-123', quantity: 2}],
      shippingAddress: {...}
    };

    const response = await api.post('/orders', orderData);
    expect(response.status).toBe(201);
    orderId = response.data.orderId;
    expect(response.data.total).toBe(99.98);
  });

  it('reserves inventory', async () => {
    const response = await api.get(`/inventory/${userId}/orders/${orderId}`);
    expect(response.data.status).toBe('reserved');
    expect(response.data.items.length).toBe(1);
  });

  it('processes payment successfully', async () => {
    const response = await api.post('/payments', {
      orderId,
      amount: 99.98,
      method: 'credit_card',
      token: 'tok_visa'
    });

    expect(response.status).toBe(200);
    expect(response.data.status).toBe('succeeded');
    paymentId = response.data.paymentId;
  });

  it('sends order confirmation email', async () => {
    // Check email service mock or integration
    const email = await emailService.getLastEmailSent(userId);
    expect(email.subject).toContain('Order Confirmation');
    expect(email.body).toContain(orderId);
  });

  it('records analytics event', async () => {
    const event = await analyticsService.getLastEvent(userId);
    expect(event.name).toBe('order_completed');
    expect(event.properties.orderId).toBe(orderId);
    expect(event.properties.amount).toBe(99.98);
  });
});
```

## Quick Reference

| SIT Pattern | Use Case | Tools |
|-------------|----------|-------|
| **Happy Path** | Normal workflow validation | Cypress, Postman, Supertest |
| **Error Path** | Failure handling across services | Same tools + error assertions |
| **Data Consistency** | DB consistency after workflow | Database test helpers |
| **Performance** | Service response times | Artillery, k6 |
| **Idempotency** | Retry-safe operations | Multiple execution verification |

### Critical SIT Scenarios

| Scenario | Services Involved | Key Validations |
|----------|-------------------|-----------------|
| User Registration | Auth → User DB → Email Service → Analytics | Account created, email sent, event recorded |
| Order Fulfillment | Order → Inventory → Payment → Shipping → Email | Inventory reserved, payment succeeded, order updated |
| Content Moderation | Upload → AI Service → Storage → Notification | Content processed, appropriate action taken |
| Authentication Flow | Auth → Session Cache → Audit Log | Token issued, session stored, audit recorded |

## Implementation

### Scenario Generation from API Specs

#### Input: OpenAPI/Swagger Spec
```yaml
# order-service.yaml
paths:
  /orders:
    post:
      summary: Create order
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/OrderRequest'
      responses:
        201:
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/OrderResponse'

# inventory-service.yaml
paths:
  /inventory/reserve:
    post:
      summary: Reserve inventory for order
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ReserveRequest'
```

#### Generated SIT Scenario (JavaScript/Cypress)
```javascript
// SIT: Order Creation → Inventory Reservation
describe('Order to Inventory SIT', () => {
  const orderService = new OrderServiceAPI();
  const inventoryService = new InventoryServiceAPI();

  it('creates order and reserves inventory successfully', async () => {
    // Step 1: Create order
    const order = await orderService.createOrder({
      userId: 'user-123',
      items: [
        { productId: 'prod-001', quantity: 2 },
        { productId: 'prod-002', quantity: 1 }
      ]
    });

    expect(order.status).toBe('pending');
    expect(order.orderId).toBeDefined();

    // Step 2: Reserve inventory
    const reservation = await inventoryService.reserve({
      orderId: order.orderId,
      items: order.items
    });

    expect(reservation.status).toBe('reserved');
    expect(reservation.reservedAt).toBeDefined();

    // Step 3: Verify order status updated
    const updatedOrder = await orderService.getOrder(order.orderId);
    expect(updatedOrder.status).toBe('confirmed');
  });
});
```

### Data Generation for SIT

#### Realistic Test Data Generator
```javascript
const generateTestData = () => ({
  user: {
    email: `user-${Date.now()}@test.com`,
    name: 'Test User',
    address: {
      street: '123 Test St',
      city: 'Test City',
      zip: '12345'
    }
  },
  product: {
    id: `prod-${Math.floor(Math.random() * 1000)}`,
    name: 'Test Product',
    price: 99.99,
    inventory: 100
  },
  payment: {
    method: 'credit_card',
    token: 'tok_test_visa',
    amount: 0 // Will be calculated dynamically
  }
});

const calculateOrderTotal = (items) =>
  items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
```

### Assertion Strategies

#### Service-to-Service Consistency
```javascript
it('maintains data consistency across services', async () => {
  // Create order
  const order = await createOrder(orderData);

  // Verify in order service
  const orderRecord = await orderService.get(order.id);
  expect(orderRecord.total).toBe(299.97);

  // Verify in inventory service
  const inventoryRecord = await inventoryService.get(order.id);
  expect(inventoryRecord.reservedQuantity).toBe(3);

  // Verify in payment service
  const paymentRecord = await paymentService.getByOrderId(order.id);
  expect(paymentRecord.amount).toBe(299.97);

  // Verify consistency
  expect(orderRecord.total).toBe(paymentRecord.amount);
});
```

#### Error Propagation Validation
```javascript
it('handles payment failure gracefully', async () => {
  const order = await createOrder(orderData);

  // Attempt payment with invalid token
  const paymentResult = await processPayment({
    orderId: order.id,
    amount: order.total,
    token: 'tok_invalid'
  });

  // Verify error response
  expect(paymentResult.status).toBe(400);
  expect(paymentResult.error).toBe('Invalid payment token');

  // Verify order status rollback
  const updatedOrder = await orderService.get(order.id);
  expect(updatedOrder.status).toBe('payment_failed');

  // Verify inventory release
  const inventory = await inventoryService.get(order.id);
  expect(inventory.status).toBe('released');
});
```

### SIT Test Framework Examples

#### Cypress (E2E + SIT hybrid)
```javascript
// cypress/integration/sit/order-fulfillment.cy.js
describe('Order Fulfillment SIT', () => {
  const baseUrl = Cypress.env('API_BASE_URL');

  it('completes full order fulfillment workflow', () => {
    cy.request({
      method: 'POST',
      url: `${baseUrl}/orders`,
      body: generateOrderRequest()
    }).then((orderResponse) => {
      expect(orderResponse.status).to.eq(201);
      const orderId = orderResponse.body.orderId;

      // Verify inventory reservation
      cy.request(`${baseUrl}/inventory/${orderId}`)
        .its('body.status')
        .should('eq', 'reserved');

      // Process payment
      cy.request({
        method: 'POST',
        url: `${baseUrl}/payments`,
        body: generatePaymentRequest(orderId, orderResponse.body.total)
      }).then((paymentResponse) => {
        expect(paymentResponse.status).to.eq(200);
        expect(paymentResponse.body.status).to.eq('succeeded');

        // Verify order status
        cy.request(`${baseUrl}/orders/${orderId}`)
          .its('body.status')
          .should('eq', 'paid');
      });
    });
  });
});
```

#### Postman Collection
```javascript
// Postman Pre-request Script for chained requests
const orderId = pm.environment.get('orderId');

// Generate order request
const orderRequest = {
  userId: 'user-123',
  items: [
    { productId: 'prod-001', quantity: 2 }
  ]
};

pm.sendRequest({
  url: 'http://api/orders',
  method: 'POST',
  header: { 'Content-Type': 'application/json' },
  body: { mode: 'raw', raw: JSON.stringify(orderRequest) }
}, (err, res) => {
  if (err) throw err;

  pm.environment.set('orderId', res.json().orderId);
  pm.environment.set('orderTotal', res.json().total);
});

// Tests tab in subsequent request
pm.test('Order payment successful', () => {
  const jsonData = pm.response.json();
  pm.expect(jsonData.status).to.eql('succeeded');
  pm.expect(jsonData.amount).to.eql(pm.environment.get('orderTotal'));
});
```

#### k6 (Performance SIT)
```javascript
// k6/sit/load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '2m', target: 100 },  // Ramp up
    { duration: '5m', target: 100 },  // Stay
    { duration: '2m', target: 0 },    // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<500'], // 95% under 500ms
    http_req_failed: ['rate<0.01'],    // <1% failures
  },
};

export default function () {
  // Create order
  const orderResponse = http.post(
    'http://api/orders',
    JSON.stringify(generateOrder()),
    { headers: { 'Content-Type': 'application/json' } }
  );

  check(orderResponse, {
    'order created': (r) => r.status === 201,
  });

  if (orderResponse.status === 201) {
    const orderId = orderResponse.json().orderId;

    // Reserve inventory
    const inventoryResponse = http.post(
      `http://api/inventory/${orderId}/reserve`,
      JSON.stringify(orderResponse.json().items),
      { headers: { 'Content-Type': 'application/json' } }
    );

    check(inventoryResponse, {
      'inventory reserved': (r) => r.status === 200,
    });
  }

  sleep(1);
}
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Testing too many services in one scenario | Slow, hard to debug, flaky | Break into smaller focused scenarios |
| Hardcoded test data | Brittle tests, difficult to maintain | Use data generators and factories |
| No cleanup between tests | Data pollution, state leakage | Clean up resources in afterEach |
| Testing implementation details | Breaks on refactoring | Test API contracts and behavior |
| Insufficient assertions | Misses bugs | Assert all key properties and states |
| No error scenario testing | Only happy paths validated | Add failure cases for each service |
| Ignoring async timeouts | Flaky tests on slow systems | Use explicit timeouts and retries |

### Red Flags

- Scenarios taking > 30 seconds to run
- 10+ services in single test
- Hardcoded IDs, tokens, or credentials
- No assertions on intermediate states
- Skipping cleanup after test
- Only testing success cases
- Tests that pass but don't validate anything

## Real-World Impact

**Before (No SIT):**
- Integration bugs found in production
- Manual testing before releases
- Unclear service responsibilities
- Slow rollback procedures
- Customer-facing incidents

**After (Comprehensive SIT):**
- 90% of integration bugs caught in CI
- Automated regression in < 5 minutes
- Clear service contract validation
- Fast rollback with test failures
- 75% reduction in production incidents

**Result:** Faster, more reliable releases with confidence that integration works.

## Integration with Aether.go Methodology

### SIT + BMAD Metrics
```
Business Goal → Integration Reliability Metric → SIT Scenario
```

Example:
- Business Goal: "99.9% order processing success rate"
- BMAD Metric: "Integration errors < 0.1%"
- SIT Requirement: "All happy path scenarios must pass, error paths tested"

### SIT + Spec Tracing
Link SIT scenarios to spec requirements:
```javascript
/**
 * Spec: REQ-ORDER-003 - Order fulfillment workflow
 * Services: Order Service → Inventory → Payment → Shipping
 * Coverage: Happy path, payment failure, inventory shortage
 */
describe('REQ-ORDER-003: Order Fulfillment', () => {
  it('completes order fulfillment successfully', () => {
    // Full workflow test
  });
});
```

### Service Health Dashboard
```javascript
// Monitor SIT results across services
const generateHealthReport = (testResults) => ({
  orderService: {
    successRate: calculateSuccessRate(testResults.order),
    avgResponseTime: calculateAvgTime(testResults.order),
    status: 'healthy'
  },
  inventoryService: {
    successRate: calculateSuccessRate(testResults.inventory),
    avgResponseTime: calculateAvgTime(testResults.inventory),
    status: 'degraded'
  },
  paymentService: {
    successRate: calculateSuccessRate(testResults.payment),
    avgResponseTime: calculateAvgTime(testResults.payment),
    status: 'healthy'
  }
});
```
