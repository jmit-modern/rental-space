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
          v-for="(space, spaceIdx) in spaces"
          :key="space.email"
          :class="spaceIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
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
            {{ space.name }}
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-sm text-gray-500 capitalize"
          >
            {{ space.spaceType }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ space.category.name }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
            <nuxt-link
              :to="{ name: 'user-id-edit', params: { id: space.owner.id } }"
              class="text-indigo-600 hover:text-indigo-900"
              >{{ space.owner.username }}</nuxt-link
            >
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap capitalize text-sm text-gray-500"
          >
            {{ space.status }}
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
          >
            <a
              :href="`${frontUrl}/space/${space.id}`"
              class="text-indigo-600 hover:text-indigo-900 cursor-pointer"
              target="_blank"
              >View</a
            ><span> | </span>
            <span
              v-if="space.status == 'active'"
              class="text-red-700 cursor-pointer"
              @click="changeStatus(space.id, 'inactive')"
              >Deactivate</span
            >
            <span
              v-else
              class="cursor-pointer"
              @click="changeStatus(space.id, 'active')"
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
      theadNames: ['Name', 'Type', 'Category', 'Owner', 'Status'],
      frontUrl: process.env.frontUrl,
    }
  },
  async fetch() {
    const params = { ...this.$route.query, per_page: 25 }
    const query = filterQueryParams(params)
    await Promise.all([
      this.$store.dispatch('space/fetch', query),
      this.$store.dispatch('space/fetchSpaceStatuses'),
    ])
  },
  computed: {
    ...mapGetters({
      spaces: 'space/data',
      spaceStatuses: 'space/spaceStatuses',
      pagination: 'space/pagination',
    }),
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
  methods: {
    async changeStatus(spaceId, statusStr) {
      const params = { status: this.spaceStatuses[statusStr] }
      await this.$store.dispatch('space/update', [spaceId, params])
    },
  },
}
</script>
