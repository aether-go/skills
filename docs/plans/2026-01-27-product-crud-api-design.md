# Product CRUD API Design

## Overview
FastAPI + MongoDB CRUD API for Product entity with 2-day MVP deadline.

## Requirements
- Language: Python with FastAPI
- Database: MongoDB (Motor async driver)
- Fields: id (UUID), name (string), price (float), category (string), in_stock (boolean)
- Operations: Create, Read, Update, Delete, List with pagination
- Validation: Price must be positive, name required
- Authentication: None for now (internal API)
- Time: 2-day MVP deadline

## Design Decisions

### 1. Project Structure (Minimal)
```
product-crud-api/
├── main.py              # FastAPI app, routes, dependency injection
├── database.py          # MongoDB connection setup
├── models.py            # Pydantic models for request/response
├── schemas.py           # MongoDB document schemas
├── crud.py              # CRUD operations
├── .env.example         # Environment variables template
├── requirements.txt     # Dependencies
├── pytest.ini           # Test configuration
└── tests/
    ├── conftest.py      # Test fixtures
    ├── test_main.py     # API endpoint tests
    └── test_crud.py     # CRUD operation tests
```

### 2. Dependencies
- fastapi
- uvicorn[standard]
- motor (async MongoDB driver)
- pymongo
- pydantic
- python-dotenv
- pytest
- pytest-asyncio
- httpx (for async test client)

### 3. Data Models
**MongoDB Schema:**
- `_id`: ObjectId (auto-generated)
- `id`: UUID (external API identifier)
- `name`: string (required)
- `price`: float (> 0)
- `category`: string
- `in_stock`: boolean (default: True)
- `created_at`: datetime
- `updated_at`: datetime

**Pydantic Models:**
- `ProductCreate`: POST request validation
- `ProductUpdate`: PATCH request validation (optional fields)
- `ProductResponse`: API response format
- `PaginatedResponse`: Standardized pagination response

### 4. Validation Rules
- Price: Field(gt=0)
- Name: Field(min_length=1)
- UUID: Generated on creation if not provided

### 5. API Endpoints
```
GET    /products           - List products with pagination
POST   /products           - Create new product
GET    /products/{id}      - Get single product by UUID
PUT    /products/{id}      - Full update (replace)
PATCH  /products/{id}      - Partial update
DELETE /products/{id}      - Delete product
```

**Query Parameters (GET /products):**
- `page`: integer (default: 1)
- `limit`: integer (default: 10, max: 100)
- `category`: optional filter
- `in_stock`: optional boolean filter

### 6. Response Format
Standardized JSON response:
```json
{
  "data": {...},
  "error": null,
  "total": 100,
  "page": 1,
  "limit": 10
}
```

Error responses use same structure with `error` field populated.

### 7. Database Configuration
- Environment variables: `MONGODB_URI`, `DATABASE_NAME`
- Async connection using Motor
- Connection pooling
- Graceful shutdown handling

### 8. Testing Strategy
**Test Database:** Separate MongoDB instance or in-memory
**Async Test Client:** httpx.AsyncClient with pytest-asyncio
**Fixtures:** Database connection, test client, clean data
**Test Coverage:**
- Unit tests for CRUD operations
- Integration tests for API endpoints
- Validation tests for constraints
- Pagination and filtering tests

### 9. Time Management (2-day deadline)
**Day 1:** Core implementation (database, models, CRUD, basic endpoints)
**Day 2:** Testing, error handling, documentation, deployment setup

## Trade-offs
1. **Minimal structure** vs comprehensive package layout
2. **Standardized response format** adds overhead but improves consistency
3. **Comprehensive tests** despite time pressure - ensures quality
4. **Offset/limit pagination** simpler than cursor-based but less performant at scale
5. **No authentication** for MVP - can be added later

## Success Criteria
- All CRUD operations functional
- Validation working correctly
- Pagination and filtering operational
- Tests passing
- Can be deployed with environment variables