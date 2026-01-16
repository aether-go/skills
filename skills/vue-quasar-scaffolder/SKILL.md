---
name: vue-quasar-scaffolder
description: Use when generating Vue 3 + Quasar + TypeScript components based on bitcms frontend patterns
---

# Vue Quasar Scaffolder

## Overview
Generate Vue 3 + Quasar + TypeScript components following bitcms frontend patterns. Creates production-ready UI components, pages, stores, and utilities with Composition API, Pinia state management, and comprehensive TypeScript support.

## When to Use

```
Need Vue frontend? ───────────────┐
                                 │
Building Quasar UI? ───────────────┤
                                 ├─► Use vue-quasar-scaffolder
TypeScript components? ────────────┤
                                 │
Bitcms patterns? ─────────────────┘
```

Use when:
- Starting new Vue 3 + Quasar project
- Creating new UI components or pages
- Implementing CRUD interfaces
- Setting up Pinia stores for state management
- Need TypeScript with strict mode
- Want bitcms-style component structure
- Building admin dashboards or data-heavy applications

Don't use when:
- Backend-only work (use go-backend-scaffolder)
- Simple static websites
- React or other framework projects
- Legacy Vue 2 projects
- Already have established frontend patterns

## Core Pattern

### Frontend Structure (bitcms-inspired)

```
frontend/
├── src/
│   ├── api/                      # API clients and services
│   │   ├── clients/              # Axios instances
│   │   ├── endpoints/            # API endpoint definitions
│   │   └── types/                # API response/request types
│   ├── assets/                   # Static assets (images, fonts)
│   ├── components/               # Reusable components
│   │   ├── business/             # Domain-specific components
│   │   ├── charts/               # Chart components (ECharts)
│   │   ├── common/               # Common UI components
│   │   ├── editor/               # Rich text editor components
│   │   ├── forms/                # Form components
│   │   ├── layouts/              # Layout components
│   │   ├── tables/               # Data table components
│   │   ├── ui/                   # Base UI components
│   │   └── upload/               # File upload components
│   ├── composables/              # Composition functions
│   ├── directives/               # Vue custom directives
│   ├── i18n/                     # Internationalization
│   ├── layouts/                  # Page layouts
│   ├── locales/                  # Translation files
│   ├── pages/                    # Route pages/views
│   ├── router/                   # Vue Router configuration
│   ├── services/                 # Business logic services
│   ├── stores/                   # Pinia stores
│   ├── theme/                    # Theme configuration
│   ├── types/                    # TypeScript type definitions
│   └── utils/                    # Utility functions
├── public/                       # Public static files
└── tests/                        # Test files
```

### Before (Generic Vue Component)
```vue
<template>
  <div>
    <h1>{{ title }}</h1>
    <button @click="increment">Click me: {{ count }}</button>
  </div>
</template>

<script>
export default {
  data() {
    return {
      title: 'My Component',
      count: 0
    }
  },
  methods: {
    increment() {
      this.count++
    }
  }
}
</script>
```

### After (bitcms Vue 3 + TypeScript)
```vue
<template>
  <q-card class="my-component">
    <q-card-section>
      <div class="text-h6">{{ title }}</div>
      <div class="text-caption text-grey-7">{{ description }}</div>
    </q-card-section>
    
    <q-card-section>
      <q-btn
        color="primary"
        :label="buttonLabel"
        @click="handleClick"
        :loading="isLoading"
      />
      <div class="q-mt-md text-body2">Count: {{ count }}</div>
    </q-card-section>
  </q-card>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue'
import { useCounterStore } from '@/stores/counter'
import { QBtn, QCard, QCardSection } from 'quasar'

interface Props {
  /** Component title */
  title: string
  /** Optional description */
  description?: string
}

const props = withDefaults(defineProps<Props>(), {
  description: 'Default description'
})

const emit = defineEmits<{
  (e: 'increment', value: number): void
  (e: 'click'): void
}>()

// Reactive state
const isLoading = ref(false)
const counterStore = useCounterStore()

// Computed properties
const count = computed(() => counterStore.count)
const buttonLabel = computed(() => 
  isLoading.value ? 'Loading...' : `Click me (${count.value})`
)

// Methods
const handleClick = async () => {
  isLoading.value = true
  try {
    await counterStore.increment()
    emit('increment', counterStore.count)
    emit('click')
  } finally {
    isLoading.value = false
  }
}
</script>

<style scoped>
.my-component {
  max-width: 400px;
  margin: 0 auto;
}
</style>
```

## Quick Reference

### Component Generation

| Component | Command/Template | Location |
|-----------|----------------|----------|
| UI Component | `vue-quasar-scaffolder component StatusBadge` | `src/components/ui/StatusBadge.vue` |
| Business Component | `vue-quasar-scaffolder business ProductCard` | `src/components/business/ProductCard.vue` |
| Page | `vue-quasar-scaffolder page Products` | `src/pages/ProductsPage.vue` |
| Layout | `vue-quasar-scaffolder layout MainLayout` | `src/layouts/MainLayout.vue` |
| Store | `vue-quasar-scaffolder store products` | `src/stores/products.store.ts` |
| Composable | `vue-quasar-scaffolder composable useProducts` | `src/composables/useProducts.ts` |
| Form | `vue-quasar-scaffolder form ProductForm` | `src/components/forms/ProductForm.vue` |
| Table | `vue-quasar-scaffolder table ProductsTable` | `src/components/tables/ProductsTable.vue` |

### Essential Templates

#### 1. UI Component Template
```vue
<!-- src/components/ui/Button.vue -->
<template>
  <button
    class="base-button"
    :class="[variantClass, sizeClass, { 'is-loading': isLoading, 'is-disabled': disabled }]"
    :type="type"
    :disabled="disabled || isLoading"
    @click="handleClick"
  >
    <span v-if="$slots.icon" class="button-icon">
      <slot name="icon" />
    </span>
    <span class="button-content">
      <slot />
    </span>
    <span v-if="isLoading" class="button-loader">
      <q-spinner size="1em" />
    </span>
  </button>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { QSpinner } from 'quasar'

interface Props {
  /** Button variant */
  variant?: 'primary' | 'secondary' | 'outline' | 'text' | 'danger'
  /** Button size */
  size?: 'small' | 'medium' | 'large'
  /** Button type attribute */
  type?: 'button' | 'submit' | 'reset'
  /** Loading state */
  isLoading?: boolean
  /** Disabled state */
  disabled?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  size: 'medium',
  type: 'button',
  isLoading: false,
  disabled: false
})

const emit = defineEmits<{
  (e: 'click', event: MouseEvent): void
}>()

// Computed classes
const variantClass = computed(() => `variant-${props.variant}`)
const sizeClass = computed(() => `size-${props.size}`)

// Methods
const handleClick = (event: MouseEvent) => {
  if (!props.disabled && !props.isLoading) {
    emit('click', event)
  }
}
</script>

<style scoped>
.base-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--spacing-xs);
  border: 1px solid transparent;
  border-radius: var(--border-radius-md);
  font-family: inherit;
  font-weight: var(--font-weight-medium);
  cursor: pointer;
  transition: all var(--transition-normal) var(--ease-in-out);
  user-select: none;
}

/* Variants */
.variant-primary {
  background-color: var(--color-primary-600);
  color: white;
}

.variant-primary:hover:not(.is-disabled):not(.is-loading) {
  background-color: var(--color-primary-700);
}

.variant-secondary {
  background-color: var(--color-secondary-600);
  color: white;
}

.variant-outline {
  background-color: transparent;
  border-color: var(--color-gray-300);
  color: var(--color-gray-700);
}

.variant-text {
  background-color: transparent;
  border-color: transparent;
  color: var(--color-primary-600);
}

.variant-danger {
  background-color: var(--color-error-600);
  color: white;
}

/* Sizes */
.size-small {
  padding: var(--spacing-xs) var(--spacing-sm);
  font-size: var(--font-size-xs);
}

.size-medium {
  padding: var(--spacing-sm) var(--spacing-md);
  font-size: var(--font-size-sm);
}

.size-large {
  padding: var(--spacing-md) var(--spacing-lg);
  font-size: var(--font-size-base);
}

/* States */
.is-loading {
  opacity: 0.7;
  cursor: wait;
}

.is-disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

/* Dark mode adjustments */
:global(body.dark-mode) .variant-outline {
  border-color: var(--color-gray-600);
  color: var(--color-gray-300);
}
</style>
```

#### 2. Pinia Store Template
```typescript
// src/stores/products.store.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import type { Product, ProductFilter, PaginatedResponse } from '@/types/products'
import { productService } from '@/services/product.service'
import { useErrorHandler } from '@/composables/useErrorHandler'

export const useProductsStore = defineStore('products', () => {
  // State
  const products = ref<Product[]>([])
  const selectedProduct = ref<Product | null>(null)
  const isLoading = ref(false)
  const error = ref<string | null>(null)
  
  // Pagination state
  const currentPage = ref(1)
  const pageSize = ref(20)
  const totalItems = ref(0)
  const totalPages = ref(0)
  
  // Filter state
  const filter = ref<ProductFilter>({
    search: '',
    category: '',
    status: 'active',
    sortBy: 'created_at',
    sortOrder: 'desc'
  })
  
  // Getters
  const filteredProducts = computed(() => {
    return products.value.filter(product => {
      if (filter.value.search && !product.name.toLowerCase().includes(filter.value.search.toLowerCase())) {
        return false
      }
      if (filter.value.category && product.category !== filter.value.category) {
        return false
      }
      if (filter.value.status && product.status !== filter.value.status) {
        return false
      }
      return true
    })
  })
  
  const activeProducts = computed(() => 
    products.value.filter(p => p.status === 'active')
  )
  
  const productCount = computed(() => products.value.length)
  
  // Actions
  const fetchProducts = async () => {
    isLoading.value = true
    error.value = null
    
    try {
      const response: PaginatedResponse<Product> = await productService.getProducts({
        page: currentPage.value,
        limit: pageSize.value,
        ...filter.value
      })
      
      products.value = response.data
      totalItems.value = response.total
      totalPages.value = response.pages
    } catch (err) {
      error.value = useErrorHandler().handle(err, 'Failed to fetch products')
      throw err
    } finally {
      isLoading.value = false
    }
  }
  
  const fetchProductById = async (id: string) => {
    isLoading.value = true
    error.value = null
    
    try {
      const product = await productService.getProductById(id)
      selectedProduct.value = product
      return product
    } catch (err) {
      error.value = useErrorHandler().handle(err, `Failed to fetch product ${id}`)
      throw err
    } finally {
      isLoading.value = false
    }
  }
  
  const createProduct = async (productData: Partial<Product>) => {
    isLoading.value = true
    error.value = null
    
    try {
      const newProduct = await productService.createProduct(productData)
      products.value.unshift(newProduct)
      return newProduct
    } catch (err) {
      error.value = useErrorHandler().handle(err, 'Failed to create product')
      throw err
    } finally {
      isLoading.value = false
    }
  }
  
  const updateProduct = async (id: string, updates: Partial<Product>) => {
    isLoading.value = true
    error.value = null
    
    try {
      const updatedProduct = await productService.updateProduct(id, updates)
      
      // Update in local state
      const index = products.value.findIndex(p => p.id === id)
      if (index !== -1) {
        products.value[index] = { ...products.value[index], ...updatedProduct }
      }
      
      if (selectedProduct.value?.id === id) {
        selectedProduct.value = { ...selectedProduct.value, ...updatedProduct }
      }
      
      return updatedProduct
    } catch (err) {
      error.value = useErrorHandler().handle(err, `Failed to update product ${id}`)
      throw err
    } finally {
      isLoading.value = false
    }
  }
  
  const deleteProduct = async (id: string) => {
    isLoading.value = true
    error.value = null
    
    try {
      await productService.deleteProduct(id)
      
      // Remove from local state
      products.value = products.value.filter(p => p.id !== id)
      
      if (selectedProduct.value?.id === id) {
        selectedProduct.value = null
      }
    } catch (err) {
      error.value = useErrorHandler().handle(err, `Failed to delete product ${id}`)
      throw err
    } finally {
      isLoading.value = false
    }
  }
  
  // Reset state
  const reset = () => {
    products.value = []
    selectedProduct.value = null
    error.value = null
    currentPage.value = 1
    filter.value = {
      search: '',
      category: '',
      status: 'active',
      sortBy: 'created_at',
      sortOrder: 'desc'
    }
  }
  
  return {
    // State
    products,
    selectedProduct,
    isLoading,
    error,
    currentPage,
    pageSize,
    totalItems,
    totalPages,
    filter,
    
    // Getters
    filteredProducts,
    activeProducts,
    productCount,
    
    // Actions
    fetchProducts,
    fetchProductById,
    createProduct,
    updateProduct,
    deleteProduct,
    reset
  }
})
```

#### 3. Page Component Template
```vue
<!-- src/pages/ProductsPage.vue -->
<template>
  <main-layout>
    <template #header>
      <div class="row items-center q-pa-md">
        <div class="col">
          <div class="text-h4">Products</div>
          <div class="text-subtitle1 text-grey-7 q-mt-xs">
            Manage your product catalog
          </div>
        </div>
        <div class="col-auto">
          <q-btn
            color="primary"
            icon="add"
            label="Add Product"
            @click="showCreateDialog = true"
          />
        </div>
      </div>
    </template>
    
    <template #default>
      <div class="q-pa-md">
        <!-- Filter Bar -->
        <product-filter
          v-model="filter"
          @filter="handleFilter"
          class="q-mb-md"
        />
        
        <!-- Loading State -->
        <div v-if="isLoading && products.length === 0" class="text-center q-py-xl">
          <q-spinner size="xl" />
          <div class="q-mt-md">Loading products...</div>
        </div>
        
        <!-- Error State -->
        <div v-else-if="error" class="q-pa-md">
          <q-banner dense class="bg-negative text-white">
            {{ error }}
            <template #action>
              <q-btn flat color="white" label="Retry" @click="fetchProducts" />
            </template>
          </q-banner>
        </div>
        
        <!-- Data Table -->
        <div v-else>
          <products-table
            :products="filteredProducts"
            :loading="isLoading"
            @edit="handleEdit"
            @delete="handleDelete"
            class="q-mb-md"
          />
          
          <!-- Pagination -->
          <q-pagination
            v-model="currentPage"
            :max="totalPages"
            :max-pages="7"
            direction-links
            boundary-links
            @update:model-value="fetchProducts"
            class="justify-center"
          />
        </div>
      </div>
    </template>
  </main-layout>
  
  <!-- Create Dialog -->
  <product-form-dialog
    v-model="showCreateDialog"
    @submit="handleCreate"
    @cancel="showCreateDialog = false"
  />
  
  <!-- Edit Dialog -->
  <product-form-dialog
    v-model="showEditDialog"
    :product="selectedProduct"
    @submit="handleUpdate"
    @cancel="showEditDialog = false"
  />
  
  <!-- Delete Confirmation -->
  <q-dialog v-model="showDeleteDialog" persistent>
    <q-card style="min-width: 300px">
      <q-card-section>
        <div class="text-h6">Delete Product</div>
        <div class="q-mt-sm">
          Are you sure you want to delete "{{ selectedProduct?.name }}"?
          This action cannot be undone.
        </div>
      </q-card-section>
      
      <q-card-actions align="right">
        <q-btn flat label="Cancel" color="primary" v-close-popup />
        <q-btn 
          flat 
          label="Delete" 
          color="negative" 
          @click="confirmDelete"
          :loading="isLoading"
        />
      </q-card-actions>
    </q-card>
  </q-dialog>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue'
import { useProductsStore } from '@/stores/products.store'
import MainLayout from '@/layouts/MainLayout.vue'
import ProductFilter from '@/components/business/ProductFilter.vue'
import ProductsTable from '@/components/business/ProductsTable.vue'
import ProductFormDialog from '@/components/business/ProductFormDialog.vue'
import { QBtn, QPagination, QSpinner, QBanner, QDialog, QCard, QCardSection, QCardActions } from 'quasar'

// Store
const productsStore = useProductsStore()
const { 
  products, 
  filteredProducts, 
  selectedProduct,
  isLoading, 
  error,
  currentPage,
  totalPages,
  filter,
  fetchProducts,
  fetchProductById,
  createProduct,
  updateProduct,
  deleteProduct
} = storeToRefs(productsStore)

// Local state
const showCreateDialog = ref(false)
const showEditDialog = ref(false)
const showDeleteDialog = ref(false)

// Lifecycle
onMounted(() => {
  fetchProducts.value()
})

// Watchers
watch([currentPage, filter], () => {
  fetchProducts.value()
}, { deep: true })

// Event handlers
const handleFilter = () => {
  currentPage.value = 1
  fetchProducts.value()
}

const handleCreate = async (productData: any) => {
  try {
    await createProduct.value(productData)
    showCreateDialog.value = false
    // Show success notification
  } catch (err) {
    // Error handled by store
  }
}

const handleEdit = async (productId: string) => {
  try {
    await fetchProductById.value(productId)
    showEditDialog.value = true
  } catch (err) {
    // Error handled by store
  }
}

const handleUpdate = async (updates: any) => {
  if (!selectedProduct.value) return
  
  try {
    await updateProduct.value(selectedProduct.value.id, updates)
    showEditDialog.value = false
    // Show success notification
  } catch (err) {
    // Error handled by store
  }
}

const handleDelete = (productId: string) => {
  fetchProductById.value(productId)
  showDeleteDialog.value = true
}

const confirmDelete = async () => {
  if (!selectedProduct.value) return
  
  try {
    await deleteProduct.value(selectedProduct.value.id)
    showDeleteDialog.value = false
    // Show success notification
  } catch (err) {
    // Error handled by store
  }
}
</script>

<style scoped>
/* Page-specific styles */
</style>
```

## Implementation

### Component Generation Workflow

```bash
# Initialize Vue + Quasar project
vue-quasar-scaffolder create-project myapp-frontend

# Generate UI component
vue-quasar-scaffolder generate component Button --variant="primary,secondary,danger"

# Generate business component with CRUD
vue-quasar-scaffolder generate crud Product \
  --fields="name:string,price:number,stock:number" \
  --api="/api/products" \
  --store=products

# Generate page with layout
vue-quasar-scaffolder generate page Products --layout=main --crud

# Generate composable
vue-quasar-scaffolder generate composable useApi --type="fetch,error-handling"
```

### Configuration Templates

#### 1. Package.json Template
```json
{
  "name": "myapp-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:unit": "vitest run --reporter=verbose",
    "test:e2e": "playwright test",
    "lint": "eslint . --ext .vue,.js,.jsx,.cjs,.mjs,.ts,.tsx,.cts,.mts --fix",
    "format": "prettier --write src/",
    "type-check": "vue-tsc --noEmit"
  },
  "dependencies": {
    "@quasar/extras": "^1.17.0",
    "axios": "^1.13.2",
    "pinia": "^2.3.1",
    "quasar": "^2.18.6",
    "vue": "^3.5.26",
    "vue-router": "^4.6.4"
  },
  "devDependencies": {
    "@quasar/vite-plugin": "^1.10.0",
    "@vitejs/plugin-vue": "^4.6.2",
    "@vue/eslint-config-prettier": "^9.0.0",
    "@vue/eslint-config-typescript": "^12.0.0",
    "@vue/test-utils": "^2.4.6",
    "@vue/tsconfig": "^0.5.1",
    "eslint": "^9.39.2",
    "eslint-plugin-vue": "^9.33.0",
    "prettier": "^3.7.4",
    "typescript": "^5.9.3",
    "vite": "^4.5.14",
    "vue-tsc": "^1.8.27",
    "vitest": "^1.6.0"
  }
}
```

#### 2. Vite Config Template
```typescript
// vite.config.ts
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { quasar, transformAssetUrls } from '@quasar/vite-plugin'
import path from 'path'

export default defineConfig({
  plugins: [
    vue({
      template: { transformAssetUrls }
    }),
    quasar({
      sassVariables: 'src/quasar-variables.sass'
    })
  ],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@components': path.resolve(__dirname, './src/components'),
      '@stores': path.resolve(__dirname, './src/stores'),
      '@services': path.resolve(__dirname, './src/services'),
      '@utils': path.resolve(__dirname, './src/utils'),
      '@types': path.resolve(__dirname, './src/types')
    }
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8080',
        changeOrigin: true
      }
    }
  },
  build: {
    target: 'es2020',
    outDir: 'dist',
    assetsDir: 'assets',
    sourcemap: process.env.NODE_ENV !== 'production'
  }
})
```

### Testing Templates

#### 1. Component Test Template
```typescript
// tests/unit/components/ui/Button.spec.ts
import { describe, it, expect, vi } from 'vitest'
import { mount } from '@vue/test-utils'
import Button from '@/components/ui/Button.vue'

describe('Button Component', () => {
  it('renders button with default props', () => {
    const wrapper = mount(Button, {
      slots: {
        default: 'Click me'
      }
    })
    
    expect(wrapper.text()).toContain('Click me')
    expect(wrapper.classes()).toContain('base-button')
    expect(wrapper.classes()).toContain('variant-primary')
    expect(wrapper.classes()).toContain('size-medium')
  })
  
  it('emits click event when clicked', async () => {
    const wrapper = mount(Button, {
      slots: {
        default: 'Click me'
      }
    })
    
    await wrapper.trigger('click')
    expect(wrapper.emitted()).toHaveProperty('click')
  })
  
  it('does not emit click when disabled', async () => {
    const wrapper = mount(Button, {
      props: {
        disabled: true
      },
      slots: {
        default: 'Click me'
      }
    })
    
    await wrapper.trigger('click')
    expect(wrapper.emitted('click')).toBeUndefined()
  })
  
  it('shows loading spinner when isLoading is true', () => {
    const wrapper = mount(Button, {
      props: {
        isLoading: true
      },
      global: {
        stubs: {
          QSpinner: true
        }
      }
    })
    
    expect(wrapper.classes()).toContain('is-loading')
    expect(wrapper.find('.button-loader').exists()).toBe(true)
  })
})
```

#### 2. Store Test Template
```typescript
// tests/unit/stores/products.store.spec.ts
import { describe, it, expect, beforeEach, vi } from 'vitest'
import { setActivePinia, createPinia } from 'pinia'
import { useProductsStore } from '@/stores/products.store'
import { productService } from '@/services/product.service'

vi.mock('@/services/product.service')

describe('Products Store', () => {
  beforeEach(() => {
    setActivePinia(createPinia())
    vi.resetAllMocks()
  })
  
  it('fetches products successfully', async () => {
    const mockProducts = [
      { id: '1', name: 'Product 1', price: 100 },
      { id: '2', name: 'Product 2', price: 200 }
    ]
    
    vi.mocked(productService.getProducts).mockResolvedValue({
      data: mockProducts,
      total: 2,
      pages: 1,
      page: 1,
      limit: 20
    })
    
    const store = useProductsStore()
    await store.fetchProducts()
    
    expect(store.products).toEqual(mockProducts)
    expect(store.totalItems).toBe(2)
    expect(store.isLoading).toBe(false)
    expect(store.error).toBeNull()
  })
  
  it('handles fetch error', async () => {
    const mockError = new Error('Network error')
    vi.mocked(productService.getProducts).mockRejectedValue(mockError)
    
    const store = useProductsStore()
    
    await expect(store.fetchProducts()).rejects.toThrow('Network error')
    expect(store.error).toContain('Failed to fetch products')
    expect(store.isLoading).toBe(false)
  })
  
  it('filters products correctly', () => {
    const store = useProductsStore()
    store.products = [
      { id: '1', name: 'Apple', category: 'fruit', status: 'active' },
      { id: '2', name: 'Banana', category: 'fruit', status: 'active' },
      { id: '3', name: 'Carrot', category: 'vegetable', status: 'inactive' }
    ]
    
    store.filter.search = 'apple'
    expect(store.filteredProducts).toHaveLength(1)
    expect(store.filteredProducts[0].name).toBe('Apple')
    
    store.filter.category = 'fruit'
    expect(store.filteredProducts).toHaveLength(2)
    
    store.filter.status = 'active'
    expect(store.filteredProducts).toHaveLength(2)
  })
})
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Putting business logic in components | Hard to test, violates separation of concerns | Move logic to stores/composables |
| Not using TypeScript interfaces | Loses type safety and IDE support | Define interfaces for all props/state |
| Direct API calls in components | Tight coupling, hard to mock | Use services layer |
| Missing error boundaries | Unhandled errors crash UI | Add error handling in stores/composables |
| Not using Composition API | Vue 2 patterns in Vue 3 | Use `<script setup>` and Composition API |
| Hardcoded styling values | Inconsistent design system | Use CSS custom properties (variables) |
| No loading states | Poor UX during async operations | Add loading indicators |
| Missing accessibility | Inaccessible to some users | Add ARIA labels, keyboard support |

### Red Flags

- Business logic in Vue components
- Direct DOM manipulation
- Global variables for state
- Missing TypeScript types
- No error handling for API calls
- Hardcoded URLs and configuration
- Inline styles without CSS variables
- Missing dark mode support

## Integration with Fullstack Workflow

This skill works with:
- `go-backend-scaffolder` for backend API generation
- `fullstack-project-setup` for project initialization
- `requirements-to-code-docs` for component documentation
- `go-vue-fullstack-workflow` for coordinated workflow

### Example Workflow
```bash
# 1. Initialize fullstack project
fullstack-project-setup create myapp

# 2. Generate backend API
go-backend-scaffolder generate crud Product

# 3. Generate corresponding frontend
vue-quasar-scaffolder generate crud Product \
  --api="/api/products" \
  --fields="name:string,price:number,description:text"

# 4. Generate page with layout
vue-quasar-scaffolder generate page Products \
  --layout=admin \
  --store=products \
  --crud

# 5. Run development server
cd frontend && pnpm dev
```

## Real-World Impact

**Before (Manual Setup):**
- 3-4 days to setup production-ready frontend
- Inconsistent component patterns
- Poor TypeScript adoption
- Missing error handling
- Manual testing setup

**After (With Scaffolder):**
- 1 hour for production-ready frontend
- Consistent component architecture
- Full TypeScript support
- Comprehensive error handling
- Auto-generated tests

**Outcome:** Faster development, better code quality, improved developer experience, consistent UI patterns.