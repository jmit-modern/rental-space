<template>
  <div>
    <div
      v-if="showCat"
      class="
        hover:underline
        text-orange
        cursor-pointer
        inline-flex
        items-center
        mb-3
      "
      @click="toggleItems"
    >
      {{ category.name }}
      <outline-chevron-down-icon v-if="!showItems" class="w-4 h-4" />
      <outline-chevron-up-icon v-else class="w-4 h-4" />
    </div>
    <div v-if="showItems" class="grid grid-cols-3 gap-3">
      <div
        v-for="item in items"
        :key="item.id"
        :class="item.status == false ? 'line-through text-gray-300' : ''"
      >
        {{ item.name }}
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    category: {
      type: Object,
      default: null,
    },
    spaceFacilities: {
      type: Array,
      default: () => [],
    },
  },
  data() {
    return { showItems: false, showCat: true }
  },
  fetch() {
    if (this.category.name === 'default') {
      this.showCat = false
      this.showItems = true
    }
  },
  computed: {
    items() {
      const items = this.category.facilities.map((item) => {
        if (this.facilityIds.includes(item.id)) {
          return { ...item, status: true }
        } else {
          return { ...item, status: false }
        }
      })

      return items
    },
    facilityIds() {
      return this.spaceFacilities.map((facility) => facility.id)
    },
  },
  methods: {
    toggleItems() {
      this.showItems = !this.showItems
    },
  },
}
</script>
