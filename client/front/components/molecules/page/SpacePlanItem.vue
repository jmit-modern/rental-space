<template>
  <div class="bg-main p-5">
    <div class="flex justify-between items-center mb-4">
      <div class="text-lg">{{ item.name }}</div>
      <div class="font-bold">￥{{ formatNumber(item.price) }}〜/時間</div>
    </div>

    <Divider />

    <div
      class="
        border border-orange
        p-1
        inline-flex
        mb-4
        mt-4
        text-xs
        items-center
      "
    >
      <outline-lightning-bolt-icon class="w-4 h-4" stroke="#ff8e3c" />
      <span class="mx-1">今すぐ予約</span>
      <solid-information-circle-icon class="w-4 h-4" />
    </div>

    <div class="flex mb-5 items-center">
      <outline-clock-icon class="w-4 h-4 mr-1" stroke="#ff8e3c" />
      <span>最低利用時間{{ item.minimumTime }}時間〜</span>
    </div>

    <div class="text-right">
      <nuxt-link
        :to="
          localeRoute({ name: 'space-id-reservation', params: { id: spaceId } })
        "
        class="inline-flex items-center hover:underline"
        >このプランで予約する <outline-chevron-right-icon class="w-4 h-4" />
      </nuxt-link>
    </div>
  </div>
</template>

<script>
import { formatNumber } from '@/utils/format'
import Divider from '@/components/atoms/Divider'

export default {
  components: { Divider },
  props: {
    item: {
      type: Object,
      default: null,
    },
  },
  computed: {
    spaceId() {
      return this.$route.params.id || null
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>
