<template>
  <div>
    <div v-for="cat in facilityCats" :key="cat.id" class="mt-4">
      <FacilityCatItems :category="cat" :space-facilities="items" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import FacilityCatItems from '@/components/molecules/page/FacilityCatItems'

export default {
  components: { FacilityCatItems },
  props: {
    items: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    ...mapGetters({
      facilityCats: 'master/facilityCategories',
    }),
  },
  methods: {},
}
</script>
