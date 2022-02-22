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
          v-for="(expert, expertIdx) in experts"
          :key="expertIdx"
          :class="expertIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
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
            {{ expert.user.username }}
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
            {{ expert.user.email }}
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
            {{ expert.skillTitle }}
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
            {{ expert.cancellationDeadline }} hrs
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
            {{ expert.category.name }}
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
          >
            <nuxt-link
              :to="{ name: 'expert-id', params: { id: expert.id } }"
              class="text-indigo-600 hover:text-indigo-900"
              >View</nuxt-link
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
      theadNames: [
        'User name',
        'Email',
        'Skill title',
        'Cancellation deadline',
        'Category',
      ],
      frontUrl: process.env.frontUrl,
    }
  },
  async fetch() {
    const params = { ...this.$route.query, per_page: 25 }
    const query = filterQueryParams(params)
    await Promise.all([this.$store.dispatch('expert/fetch', query)])
  },
  computed: {
    ...mapGetters({
      experts: 'expert/data',
      pagination: 'expert/pagination',
    }),
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
  methods: {
    async changeStatus(expertId, statusStr) {
      const params = { status: this.spaceStatuses[statusStr] }
      await this.$store.dispatch('expert/update', [expertId, params])
    },
  },
}
</script>
