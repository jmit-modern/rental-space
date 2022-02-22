<!-- This example requires Tailwind CSS v2.0+ -->
<template>
  <div class="bg-white shadow overflow-hidden sm:rounded-md">
    <div class="pt-20 text-center text-3xl font-bold mb-12 text-primary">
      {{ $t('top.eventList.title') }}
    </div>
    <ul class="divide-y divide-gray-200">
      <li v-for="(item, index) in events" :key="index">
        <a :href="`event/${item.id}`" class="block hover:bg-light">
          <div class="flex items-center px-4 py-4 sm:px-6">
            <div
              class="
                min-w-0
                flex-1
                px-4
                md:grid md:grid-cols-2 md:gap-4
                text-secondary
              "
            >
              <div class="text-xl inline-flex items-center">
                {{ item.name }}
              </div>
              <div>
                <div class="flex">
                  <outline-calendar-icon class="w-5 h-5" />
                  <span class="ml-3">
                    {{ $dayjs(item.startingAt).format('YYYY/MM/DD HH:mm') }} ~
                    {{ $dayjs(item.endingAt).format('YYYY/MM/DD HH:mm') }}
                  </span>
                </div>
                <div class="flex">
                  <outline-location-marker-icon class="w-5 h-5" />
                  <span class="ml-3">{{
                    item.space ? item.space.address1 : ''
                  }}</span>
                </div>
              </div>
            </div>
            <div>
              <outline-chevron-right-icon
                class="h-5 w-5 text-gray-400"
                aria-hidden="true"
              />
            </div>
          </div>
        </a>
      </li>
    </ul>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { filterQueryParams } from '@/utils/http'
import dayjs from 'dayjs'

export default {
  async fetch() {
    const params = { ...this.$route.query, ...this.defaultParams }
    const query = filterQueryParams(params)

    await Promise.all([this.$store.dispatch('event/fetch', query)])
  },
  computed: {
    ...mapGetters({
      events: 'event/data',
    }),
    defaultParams() {
      return {
        per_page: 5,
        status: 1,
        starting_at: dayjs().format('YYYY-MM-DD H:mm:ss'),
      }
    },
  },
  methods: {
    dayjs(...args) {
      return dayjs(...args)
    },
  },
}
</script>
