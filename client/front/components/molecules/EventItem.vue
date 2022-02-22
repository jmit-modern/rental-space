<template>
  <div class="px-5 py-6 hover:bg-light">
    <div class="grid grid-cols-7 gap-4">
      <div class="col-span-2">
        <img :src="itemImage" alt="" class="w-full" />
      </div>
      <div class="col-span-3">
        <div class="text-xl mb-1">{{ item.name }}</div>
        <div v-html="item.description" class="text-sm description"></div>
      </div>
      <div class="col-span-2 space-y-3 border-l pl-4">
        <div class="flex items-center">
          <outline-location-marker-icon class="w-4 h-4 flex-initial" />
          <span
            class="
              whitespace-nowrap
              overflow-hidden overflow-ellipsis
              ml-2
              flex-1
            "
            >{{ address }}</span
          >
        </div>
        <div class="flex items-center">
          <outline-calendar-icon class="w-4 h-4" />
          <span class="ml-2">
            {{ $dayjs(item.startingAt).format('YYYY/MM/DD HH:mm') }}
          </span>
        </div>
        <div class="flex items-center">
          <outline-calendar-icon class="w-4 h-4 text-tertiary" />
          <span class="ml-2">{{
            $dayjs(item.endingAt).format('YYYY/MM/DD HH:mm')
          }}</span>
        </div>
        <div class="flex items-center pb-1">
          <span class="font-bold text-base w-5 text-center">¥</span>
          <span class="ml-2">{{ formatNumber(item.price) }} ~</span>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { formatNumber } from '@/utils/format'
export default {
  props: {
    item: {
      type: Object,
      default: () => {},
    },
  },
  computed: {
    itemImage() {
      return this.item.eventImages.length > 0
        ? this.item.eventImages[0].url
        : null
    },
    address() {
      return this.item.space ? this.item.space.address1 : ''
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>

<style scoped>
.description {
  overflow: hidden;
  display: -webkit-box;
  -webkit-box-orient: vertical;
  -webkit-line-clamp: 3;
}
</style>
