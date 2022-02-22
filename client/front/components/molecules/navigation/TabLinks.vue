<template>
  <div>
    <div class="sm:hidden">
      <label for="tabs" class="sr-only">Select a tab</label>
      <select
        id="tabs"
        name="tabs"
        class="
          block
          w-full
          pl-3
          pr-10
          py-2
          text-base
          border-gray-300
          focus:outline-none focus:ring-indigo-500 focus:border-indigo-500
          sm:text-sm
          rounded-md
        "
      >
        <option
          v-for="({ title, route }, index) in tabs"
          :key="index"
          :selected="isActive(route.name)"
        >
          {{ title }}
        </option>
      </select>
    </div>
    <div class="hidden sm:block">
      <div class="border-b border-gray-200 mb-8">
        <nav class="-mb-px flex space-x-8" aria-label="Tabs">
          <nuxt-link
            v-for="({ title, route }, index) in tabs"
            :key="index"
            :to="route"
            :class="[
              isActive(route.name)
                ? 'border-indigo-500 text-indigo-600'
                : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300',
              'whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm',
            ]"
          >
            {{ title }}
          </nuxt-link>
        </nav>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    tabs: {
      type: Array,
      required: true,
    },
  },
  methods: {
    isActive(name) {
      return name === this.$route.name
    },
  },
}
</script>
