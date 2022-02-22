<template>
  <div>
    <table class="min-w-full divide-y divide-gray-200">
      <thead class="bg-gray-50">
        <tr>
          <th
            v-for="(tName, index) of theadNames"
            :key="index"
            scope="col"
            class="
              px-6
              py-3
              text-left text-xs
              font-medium
              text-gray-500
              uppercase
              tracking-wider
            "
          >
            {{ tName }}
          </th>
          <th scope="col" class="relative px-6 py-3">
            <span class="sr-only">Edit</span>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="(event, eventIdx) in events"
          :key="eventIdx"
          :class="eventIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
        >
          <td
            class="
              px-6
              py-4
              whitespace-nowrap
              text-sm
              font-medium
              text-gray-900
            "
          >
            {{ event.name }}
          </td>
          <td
            class="
              px-6
              py-4
              whitespace-nowrap
              text-sm
              font-medium
              text-gray-900
            "
          >
            {{ event.owner.email }}
          </td>
          <td
            class="
              px-6
              py-4
              whitespace-nowrap
              text-sm
              font-medium
              text-gray-900
            "
          >
            {{ event.category.name }}
          </td>
          <td
            class="
              px-6
              py-4
              whitespace-nowrap
              text-sm
              font-medium
              text-gray-900
              capitalize
            "
          >
            {{ event.status }}
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
          >
            <a
              :href="`${frontUrl}/event/${event.id}`"
              class="text-indigo-600 hover:text-indigo-900 cursor-pointer"
              target="_blank"
              >View</a
            ><span> | </span>
            <span
              v-if="event.status == 'active'"
              class="text-red-700 cursor-pointer"
              @click="changeStatus(event.id, 'inactive')"
              >Deactivate</span
            >
            <span
              v-else
              class="cursor-pointer"
              @click="changeStatus(event.id, 'active')"
              >Activate</span
            >
          </td>
        </tr>
      </tbody>
    </table>
    <div class="px-5 py-6">
      <pagination
        v-if="pagination.totalPages"
        :total-pages="pagination.totalPages"
        :current-page="pagination.currentPage"
        :per-page="pagination.perPage"
        :total="pagination.total"
      />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Pagination from '@/components/organisms/Pagination'
import { filterQueryParams } from '@/utils/http'

export default {
  components: {
    Pagination,
  },
  data() {
    return {
      theadNames: ['Event name', 'Owner', 'Category', 'Status'],
      frontUrl: process.env.frontUrl,
    }
  },
  async fetch() {
    const params = { ...this.$route.query, per_page: 25 }
    const query = filterQueryParams(params)
    await Promise.all([
      this.$store.dispatch('event/fetch', query),
      this.$store.dispatch('event/fetchEventStatuses'),
    ])
  },
  computed: {
    ...mapGetters({
      events: 'event/data',
      eventStatuses: 'event/eventStatuses',
      pagination: 'event/pagination',
    }),
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
  methods: {
    async changeStatus(eventId, statusStr) {
      const params = { status: this.eventStatuses[statusStr] }
      await this.$store.dispatch('event/update', [eventId, params])
    },
  },
}
</script>
