---
classification: DP-Official
path: 01_context/codebase-map/DP-General-key-patterns.md
last_updated: 2026-03-09
status: In Progress
---

# Dialpad Codebase — Key Patterns & Conventions

## Purpose

Key architectural and coding patterns that AI agents must follow when generating, reviewing, or modifying Dialpad code. Load alongside `DP-General-index.md` for any engineering task.

---

## 1. Front-End Patterns (Vue 3)

### Component Structure

```vue
<template>
  <!-- Use Dialtone components; never raw HTML elements where dt- exists -->
  <dt-button @click="handleAction">Submit</dt-button>
</template>

<script setup lang="ts">
// Composition API with <script setup> — standard for all new Vue 3 components
import { ref, computed } from 'vue'
import { DtButton } from '@dialpad/dialtone-vue'

// Props defined with TypeScript types
const props = defineProps<{
  label: string
  disabled?: boolean
}>()

// Emits declared explicitly
const emit = defineEmits<{
  (e: 'submit', value: string): void
}>()
</script>

<style scoped>
/* Use CSS custom properties from design tokens — never hardcode values */
.container {
  padding: var(--dt-space-400);
  color: var(--dt-color-foreground-primary);
}
</style>
```

### Key Rules:
1. **Composition API only** — no Options API for new components
2. **TypeScript required** — all new code must be typed
3. **Dialtone components** — use `<dt-button>`, `<dt-input>`, etc. over native HTML equivalents
4. **Design tokens** — CSS custom properties from Dialtone tokens; never hardcode hex/px
5. **`<script setup>`** — preferred over `setup()` function
6. **Scoped styles** — use `<style scoped>` to prevent global CSS leakage

---

## 2. State Management

- **Pinia** is the state management standard for Dialpad 2.0 (web-clients)
- Vuex is present in legacy Dialpad 1.0 code (being migrated)
- New stores: use Pinia with Composition API style

```typescript
// Example Pinia store
import { defineStore } from 'pinia'

export const useCallStore = defineStore('call', () => {
  const activeCall = ref(null)
  const isLoading = ref(false)

  async function fetchCallDetails(callId: string) {
    isLoading.value = true
    try {
      activeCall.value = await api.getCall(callId)
    } finally {
      isLoading.value = false
    }
  }

  return { activeCall, isLoading, fetchCallDetails }
})
```

---

## 3. API Patterns

- **REST APIs** — standard HTTP verbs; JSON request/response
- **Error handling** — always handle API errors explicitly; do not let errors silently fail
- **Loading states** — always show loading state during async operations (`<dt-skeleton>`)
- **Optimistic updates** — for user-initiated actions, update UI immediately and roll back on failure
- Feature-specific APIs are gated by feature flags; confirm flag is set before testing

---

## 4. Feature Flag Pattern

```typescript
// Feature flags are read from the user/company config
import { useFeatureFlag } from '@/composables/useFeatureFlag'

const { isEnabled } = useFeatureFlag('your_feature_flag_name')

// In template
<template>
  <new-feature-component v-if="isEnabled" />
  <legacy-component v-else />
</template>
```

**Rules:**
- Every new feature must be behind a feature flag at launch
- Flag name is defined by Engineering and documented in JIRA
- Flag is turned on for EAP customers first, then all customers at GA
- Never hardcode flag state in tests — test both flag-on and flag-off paths

---

## 5. Internationalization (i18n)

- All user-facing strings must be in the i18n system — never hardcode strings in templates
- String keys follow a hierarchical naming convention by feature area
- Use the `$t()` composable in Vue templates

```vue
<!-- ✅ Correct -->
<dt-button>{{ $t('contact_center.agent.go_on_duty') }}</dt-button>

<!-- ❌ Wrong — hardcoded string -->
<dt-button>Go On Duty</dt-button>
```

---

## 6. Accessibility (a11y)

- All interactive elements must have ARIA labels if visual label is not present
- Color alone must never convey information — use icons, text, or patterns alongside
- Keyboard navigation must work for all interactive elements
- Use `<dt-*>` components — they handle a11y attributes automatically
- Run accessibility audits before Gate 1 for features with new UI surfaces

---

## 7. Testing Patterns

### Unit Tests (Vitest)

```typescript
import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import MyComponent from './MyComponent.vue'

describe('MyComponent', () => {
  it('renders correctly', () => {
    const wrapper = mount(MyComponent, {
      props: { label: 'Test' }
    })
    expect(wrapper.text()).toContain('Test')
  })
})
```

### Key Testing Rules:
1. Test behavior, not implementation — what the user sees, not internal methods
2. Use component factories for complex component setup
3. Mock API calls — never make real network requests in unit tests
4. Test both happy path AND error states
5. Test both feature-flag-on and feature-flag-off paths

---

## 8. Code Review Standards

When reviewing a PR:

| Category | Check |
|---|---|
| **Correctness** | Does it do what the JIRA story says? Are acceptance criteria met? |
| **Dialtone compliance** | No native HTML elements where Dialtone equivalents exist; design tokens used |
| **i18n** | No hardcoded strings |
| **Feature flag** | New UI is behind a flag; both paths tested |
| **Error handling** | API errors handled; loading states shown |
| **Accessibility** | ARIA labels present; keyboard nav works |
| **Tests** | Unit tests cover happy path + error state + flag states |
| **TypeScript** | No `any` types; all props and emits typed |
| **Performance** | No unnecessary re-renders; large lists virtualized |

---

## 9. Python Backend Patterns

For AI agents working on backend tasks:

- **Framework:** Flask or Django (varies by service — confirm before assuming)
- **Testing:** pytest — always run `pytest` before submitting a PR
- **API versioning:** REST APIs are versioned (v1, v2); do not break existing API contracts
- **Error responses:** Consistent JSON error format `{ "error": "...", "code": "..." }`
- **Logging:** Use structured logging — no raw `print()` statements
- **Async:** Use `asyncio` for I/O-bound operations (e.g., AI pipeline steps)

---

## 10. How to Use This File

- **Code review agents:** Load to validate PRs against Dialpad's engineering standards
- **Test writing agents:** Load to identify the correct test framework, patterns, and coverage requirements
- **Ticket breakdown agents:** Load to correctly scope front-end vs. back-end work and identify which patterns apply
- **Always pair with:** `DP-General-index.md` for repo and path navigation
