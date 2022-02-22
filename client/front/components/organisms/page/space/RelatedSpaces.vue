<template>
  <div class="grid grid-cols-3 gap-3">
    <div v-for="item in relatedItems" :key="item.id">
      <space-item :item="item" />
    </div>
  </div>
</template>

<script>
import SpaceItem from '@/components/molecules/SpaceItem'

export default {
  components: {
    SpaceItem,
  },
  data() {
    return {
      relatedItems: [],
    }
  },
  async fetch() {
    const { id } = this.$route.params
    const { spaces } = await this.$api.fetch(`spaces/${id}/related_spaces`)
    this.relatedItems = [...spaces]
  },
}
</script>
