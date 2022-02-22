<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="flex mt-10 space-x-5 items-start">
      <div class="w-80 sticky top-10">
        <Sidebar />
      </div>
      <div class="w-0 flex-1 overflow-hidden">
        <div class="border border-gray-300 rounded-lg">
          <div class="px-5 py-6">
            <div class="flex mb-2 space-x-2">
              <BadgeClose
                v-if="prefectureName"
                :value="prefectureName"
                @close="removeFilter('prefecture')"
              />
              <BadgeClose
                v-if="categoryName"
                :value="categoryName"
                @close="removeFilter('category')"
              />
            </div>
            <div class="mt-1 relative">
              <input
                id="keyword"
                v-model="keywords"
                type="text"
                name="keyword"
                class="
                  min-w-0
                  block
                  w-full
                  px-3
                  py-2
                  rounded-md
                  focus:ring-current focus:border-current
                  sm:text-sm
                  border-gray-300
                  pr-12
                  bg-light
                "
                :placeholder="$t('expert.topSearch.placeholder')"
                @keyup.enter="handleKeywordsSearch"
              />
              <span
                class="
                  inline-flex
                  absolute
                  -inset-y-0
                  right-0
                  items-center
                  px-3
                  rounded-r-md
                  text-gray-500
                  sm:text-sm
                  cursor-pointer
                  bg-orange
                "
                @click.prevent="handleKeywordsSearch"
              >
                <outline-search-icon class="w-6 h-6" stroke="#fff" />
              </span>
            </div>
          </div>
          <divider />
          <template v-if="!$fetchState.pending">
            <div
              v-for="expert in experts"
              :key="expert.id"
              class="cursor-pointer"
              @click="showSlideOver(expert.id)"
            >
              <expert-item :item="expert" />
              <divider />
            </div>
            <div class="px-5 py-6">
              <pagination
                v-if="pagination.totalPages"
                :total-pages="pagination.totalPages"
                :current-page="pagination.currentPage"
                :per-page="pagination.perPage"
                :total="pagination.total"
              />
            </div>
          </template>
        </div>
      </div>
    </div>

    <div
      v-if="show"
      class="fixed inset-0 oveflow-hidden"
      @click="closeSlideOver"
    >
      <div class="absolute inset-0 overflow-hidden">
        <div class="absolute inset-0 bg-light bg-opacity-60"></div>
      </div>
    </div>
    <div class="fixed inset-y-0 right-0 pl-10 max-w-full flex">
      <transition name="slide" :duration="1000">
        <ExpertDetailSlide v-if="show" @close="closeSlideOver" />
      </transition>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import ExpertItem from '@/components/molecules/ExpertItem'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import Divider from '@/components/atoms/Divider'
import Pagination from '@/components/organisms/Pagination'
import Sidebar from '@/components/organisms/page/expert/Sidebar'
import BadgeClose from '@/components/atoms/badges/BadgeClose'
import ExpertDetailSlide from '@/components/organisms/page/expert/ExpertDetailSlide'

export default {
  components: {
    ExpertItem,
    Breadcrumb,
    Divider,
    Pagination,
    Sidebar,
    BadgeClose,
    ExpertDetailSlide,
  },
  data() {
    return {
      keywords: null,
      show: false,
    }
  },
  async fetch() {
    const { query } = this.$route
    await Promise.all([this.$store.dispatch('expert/fetch', query)])
  },
  computed: {
    ...mapGetters({
      experts: 'expert/data',
      pagination: 'expert/pagination',
      prefDict: 'master/prefDict',
      categoryDict: 'master/categoryDict',
    }),
    prefectureName() {
      const prefectureId = parseInt(this.$route.query.prefecture)
      if (!prefectureId || !this.prefDict[prefectureId]) return null
      return this.prefDict[prefectureId].name
    },
    categoryName() {
      const categoryId = parseInt(this.$route.query.category)
      if (!categoryId || !this.categoryDict[categoryId]) return null
      return this.categoryDict[categoryId].name
    },
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: this.$t('top.breadcrumb'),
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: this.$t('expert.breadcrumb'),
        },
      ]
      return items
    },
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: ['page'],
  methods: {
    async showSlideOver(id) {
      document.body.classList.add('modal-open')
      await Promise.all([this.$store.dispatch('expert/fetchDetail', { id })])
      this.show = true
    },
    closeSlideOver() {
      this.show = false
      document.body.classList.remove('modal-open')
    },
    removeFilter(value) {
      const query = Object.assign({}, this.$route.query)
      if (value === 'time') {
        delete query.starting_at
        delete query.ending_at
      }
      if (value === 'prefecture') {
        delete query.prefecture
      }
      if (value === 'category') {
        delete query.category
      }
      this.$router.replace({ query })
    },
    handleKeywordsSearch() {
      let query
      if (this.keywords) {
        query = { ...this.$route.query, keywords: this.keywords }
      } else {
        query = Object.assign({}, this.$route.query)
        delete query.keywords
      }
      this.$router.replace({ query })
    },
  },
}
</script>

<style lang="scss" scoped>
.slide-enter-active,
.slide-leave-active {
  transition: transform 0.5s;
}
.slide-enter, .slide-leave-to /* .fade-leave-active below version 2.1.8 */ {
  transform: translateX(100%);
}
body.modal-open {
  overflow: hidden;
}
</style>
