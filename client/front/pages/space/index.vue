<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <!-- Space Filter Area -->
    <div class="mt-14 bg-light p-4">
      <form @submit.prevent="handleSubmit">
        <div>
          <span v-if="pickDate">
            {{ dayjs(pickDate).format('YYYY/MM/DD ') }}
          </span>
          <span v-if="startTime">{{ startTime }}</span>
          <span v-if="startTime || endTime">{{ ' ' }}~{{ ' ' }}</span>
          <span v-if="endTime">{{ endTime }}</span>
        </div>
        <div class="flex items-center mb-4">
          <span>{{ $t('space.sort.label') }}</span>
          <RadioSingleBox
            id="priceUp"
            value="priceUp"
            name="sort"
            :label="$t('space.sort.priceLow')"
            class-name="ml-4"
            :checked="sort == 'priceUp'"
            @change="handleSort"
          />
          <RadioSingleBox
            id="priceDown"
            value="priceDown"
            name="sort"
            :label="$t('space.sort.priceHigh')"
            class-name="ml-4"
            :checked="sort == 'priceDown'"
            @change="handleSort"
          />
          <RadioSingleBox
            id="new"
            value="new"
            name="sort"
            :label="$t('space.sort.new')"
            :checked="sort == 'new' || sort == null"
            class-name="ml-4"
            @change="handleSort"
          />
        </div>
        <input
          id="keyword"
          v-model="keywords"
          type="text"
          name="keyword"
          class="
            min-w-0
            block
            w-full
            max-w-lg
            px-3
            py-2
            rounded-md
            focus:ring-current focus:border-current
            sm:text-sm
            border-gray-300
            pr-12
          "
          :placeholder="$t('space.sort.keywords')"
        />
      </form>
    </div>
    <!-- Title Area -->
    <div class="mt-4 font-bold p-3">
      <span class="text-3xl tracking-widest">{{ categoryName }}</span>
      <span v-if="pagination"
        >( {{ pagination.total }} {{ $t('space.unit') }} )</span
      >
    </div>
    <Divider />
    <template v-if="!$fetchState.pending">
      <div
        class="
          grid grid-cols-1
          gap-6
          sm:grid-cols-2
          md:grid-cols-3
          lg:grid-cols-4
          mt-5
        "
      >
        <space-item v-for="(item, index) in items" :key="index" :item="item" />
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
</template>

<script>
import { mapGetters } from 'vuex'
import dayjs from 'dayjs'
import RadioSingleBox from '@/components/molecules/form/RadioSingleBox'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import SpaceItem from '@/components/molecules/SpaceItem'
import Divider from '@/components/atoms/Divider'
import Pagination from '@/components/organisms/Pagination'
import { filterQueryParams } from '@/utils/http'

export default {
  components: {
    SpaceItem,
    Divider,
    Breadcrumb,
    RadioSingleBox,
    Pagination,
  },
  data() {
    return {
      keywords: '',
      pickDate: null,
      startTime: null,
      endTime: null,
      sort: null,
    }
  },
  async fetch() {
    this.keywords = await this.$route.query.keywords
    this.pickDate = await this.$route.query.pickDate
    this.startTime = await this.$route.query.startTime
    this.endTime = await this.$route.query.endTime
    this.sort = await this.$route.query.sort

    const params = { ...this.query, ...this.defaultParams }
    const query = filterQueryParams(params)
    await Promise.all([this.$store.dispatch('space/fetch', query)])
  },
  computed: {
    ...mapGetters({
      items: 'space/data',
      pagination: 'space/pagination',
      categoryDict: 'master/categoryDict',
    }),
    categoryName() {
      const categoryId = parseInt(this.query.category)
      if (!categoryId || !this.categoryDict[categoryId]) return 'すべて'
      return this.categoryDict[categoryId].name
    },
    defaultParams() {
      return { per_page: 12, status: 1 }
    },
    breadcrumbs() {
      return [
        {
          id: 1,
          name: this.$t('top.breadcrumb'),
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: this.$t('space.breadcrumb'),
        },
      ]
    },
    query() {
      return this.$route.query
    },
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
  methods: {
    handleSort(value) {
      const query = { ...this.query, ...{ sort: value } }
      // add sort params to url query
      this.$router.push({ path: this.$route.path, query })
    },
    handleSubmit() {
      //  change keywords params
      this.$router.push({
        path: this.$route.path,
        query: { ...this.query, keywords: this.keywords },
      })
    },
    dayjs(...args) {
      return dayjs(...args)
    },
  },
}
</script>
