<template>
  <div class="bg-white flex items-center justify-between">
    <div class="flex-1 flex justify-between sm:hidden">
      <a
        href="#"
        class="
          relative
          inline-flex
          items-center
          px-4
          py-2
          border border-gray-300
          text-sm
          font-medium
          rounded-md
          text-gray-700
          bg-white
          hover:bg-gray-50
        "
      >
        Previous
      </a>
      <a
        href="#"
        class="
          ml-3
          relative
          inline-flex
          items-center
          px-4
          py-2
          border border-gray-300
          text-sm
          font-medium
          rounded-md
          text-gray-700
          bg-white
          hover:bg-gray-50
        "
      >
        Next
      </a>
    </div>
    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
      <div>
        <p class="text-sm text-gray-700">
          {{ $t('pagination.toalResult', { result: total }) }}
        </p>
      </div>
      <div>
        <nav
          class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px"
          aria-label="Pagination"
        >
          <nuxt-link
            v-if="prevpage != null"
            :to="{
              path: $route.path,
              query: { ...$route.query, page: prevpage },
            }"
            class="
              relative
              inline-flex
              items-center
              px-2
              py-2
              rounded-l-md
              border border-gray-300
              bg-white
              text-sm
              font-medium
              text-gray-500
              hover:bg-gray-50
            "
          >
            <span class="sr-only">Previous</span>
            <outline-chevron-left-icon class="h-5 w-5" />
          </nuxt-link>
          <!-- Current: "z-10 bg-indigo-50 border-indigo-500 text-indigo-600", Default: "bg-white border-gray-300 text-gray-500 hover:bg-gray-50" -->
          <nuxt-link
            v-for="num in pageNumbers"
            :key="num"
            :to="{ path: $route.path, query: { ...$route.query, page: num } }"
            :class="[
              'relative inline-flex items-center px-4 py-2 border bg-white text-sm font-medium',
              num == currentPage
                ? 'z-10 bg-orange bg-opacity-10 border-orange text-orange'
                : 'border-gray-300 text-gray-700',
              num == 0 ? 'pointer-events-none' : '',
            ]"
          >
            {{ num != 0 ? num : '...' }}
          </nuxt-link>
          <nuxt-link
            v-if="nextpage != null"
            :to="{
              path: $route.path,
              query: { ...$route.query, page: nextpage },
            }"
            class="
              relative
              inline-flex
              items-center
              px-2
              py-2
              rounded-r-md
              border border-gray-300
              bg-white
              text-sm
              font-medium
              text-gray-500
              hover:bg-gray-50
            "
          >
            <span class="sr-only">Next</span>
            <outline-chevron-right-icon class="h-5 w-5" />
          </nuxt-link>
        </nav>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  props: {
    totalPages: {
      type: Number,
      default: null,
    },
    perPage: {
      type: Number,
      default: null,
    },
    total: {
      type: Number,
      default: null,
    },
  },
  data() {
    return {
      prevpage: null,
      nextpage: null,
      currentPage: null,
      pageNumbers: [],
      pageNumberCount: 0,
    }
  },
  fetch() {
    this.setPageNumbers()
  },
  computed: {
    totalPageCount() {
      return this.totalPages
    },
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
  methods: {
    setPages(currentPage, totalPageCount) {
      this.prevpage = currentPage > 1 ? currentPage - 1 : null
      if (!totalPageCount) {
        this.nextpage = this.$route.query.page
          ? parseInt(this.$route.query.page) + 1
          : 2
      } else {
        this.nextpage =
          currentPage < totalPageCount ? parseInt(currentPage) + 1 : null
      }
      this.pageNumbers = this.getPageList(totalPageCount, currentPage, 7)
    },
    setPageNumbers() {
      const currentPage = this.$route.query.page ? this.$route.query.page : 1
      this.currentPage = currentPage
      this.setPages(currentPage, this.totalPageCount)
    },
    getPageList(totalPages, page, maxLength) {
      // if (maxLength < 5) throw 'maxLength must be at least 5'

      function range(start, end) {
        return Array.from(Array(end - start + 1), (_, i) => i + start)
      }

      const sideWidth = maxLength < 9 ? 1 : 2
      const leftWidth = (maxLength - sideWidth * 2 - 3) >> 1
      const rightWidth = (maxLength - sideWidth * 2 - 2) >> 1
      if (totalPages <= maxLength) {
        // no breaks in list
        return range(1, totalPages)
      }
      if (page <= maxLength - sideWidth - 1 - rightWidth) {
        // no break on left of page
        return range(1, maxLength - sideWidth - 1).concat(
          0,
          range(totalPages - sideWidth + 1, totalPages)
        )
      }
      if (page >= totalPages - sideWidth - 1 - rightWidth) {
        // no break on right of page
        return range(1, sideWidth).concat(
          0,
          range(totalPages - sideWidth - 1 - rightWidth - leftWidth, totalPages)
        )
      }
      // Breaks on both sides
      return range(1, sideWidth).concat(
        0,
        range(page - leftWidth, page + rightWidth),
        0,
        range(totalPages - sideWidth + 1, totalPages)
      )
    },
  },
}
</script>
