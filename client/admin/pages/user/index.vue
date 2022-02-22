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
          v-for="(user, userIdx) in users"
          :key="user.email"
          :class="userIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'"
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
            {{ user.username }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ user.fullName }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ user.email }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ user.userType }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ user.spaces.length }}
          </td>
          <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
            {{ user.events.length }}
          </td>
          <td
            class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
          >
            <nuxt-link
              :to="{ name: 'user-id-edit', params: { id: user.id } }"
              class="text-indigo-600 hover:text-indigo-900"
              >Edit</nuxt-link
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
      theadNames: ['Username', 'Name', 'Email', 'Role', 'Spaces', 'Events'],
    }
  },
  async fetch() {
    const params = { ...this.$route.query }
    const query = filterQueryParams(params)
    await Promise.all([this.$store.dispatch('user/fetch', query)])
  },
  computed: {
    ...mapGetters({
      users: 'user/data',
      pagination: 'user/pagination',
    }),
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
}
</script>
