<template>
  <div class="bg-light p-5 space-y-4">
    <SpacePlanItem v-for="item in items" :key="item.id" :item="item" />
  </div>
</template>

<script>
import SpacePlanItem from '@/components/molecules/page/SpacePlanItem'
export default {
  components: { SpacePlanItem },
  props: {
    items: {
      type: Array,
      default: null,
    },
  },
}
</script>
