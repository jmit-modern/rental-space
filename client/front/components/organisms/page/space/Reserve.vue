<template>
  <div class="border border-orange rounded-sm p-6">
    <div class="mb-5">
      <span class="text-2xl font-bold">￥{{ formatNumber(price) }}</span
      >/{{ $t('space.detail.perHour') }}
    </div>
    <nuxt-link
      :to="
        localeRoute({ name: 'space-id-reservation', params: { id: spaceId } })
      "
      class="
        bg-orange
        text-main
        hover:text hover:bg-opacity-80
        w-full
        py-3
        rounded-sm
        font-bold
        mb-4
        block
        text-center
      "
    >
      {{ $t('space.detail.reserveRequest') }}
    </nuxt-link>
    <div class="text-xs text-center mb-4 border-collapse">
      {{ $t('space.detail.freeCancel') }}: {{ space.cancellationDeadline
      }}{{ $t('space.detail.hours') }}
    </div>
    <div class="text-xs text-center mb-4 border-collapse">
      {{ $t('space.detail.maxCapacity') }}: {{ space.capacity
      }}{{ $t('form.capacityUnit') }}
    </div>

    <table class="text-sm w-full table-fixed">
      <tbody>
        <tr>
          <th class="bg-light w-1/2 p-2 border border-gray-300">
            {{ $t('space.detail.easeOfBooking') }}
          </th>
          <td class="p-2 border border-gray-300">-</td>
        </tr>
        <tr>
          <th class="bg-light w-1/2 p-2 border border-gray-300">
            {{ $t('space.detail.responseTime') }}
          </th>
          <td class="p-2 border border-gray-300">-</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { formatNumber } from '@/utils/format'
export default {
  props: {
    space: {
      type: Object,
      default: null,
    },
  },
  data() {
    return {
      id: null,
    }
  },
  computed: {
    spaceId() {
      return this.space.id || null
    },
    price() {
      return this.space.price || null
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>
