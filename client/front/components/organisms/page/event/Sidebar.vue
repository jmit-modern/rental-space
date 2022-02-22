<template>
  <div class="space-y-4 divide-y">
    <div class="text-2xl mb-6">{{ $t('event.sidebar.sort') }}</div>

    <div class="py-4">
      <div class="font-bold mb-3">{{ $t('event.sidebar.location') }}</div>
      <PrefecturePicker v-model="prefectureId" @change="handlePrefChange" />
    </div>

    <div class="py-4">
      <div class="font-bold mb-3">{{ $t('event.sidebar.category') }}</div>
      <CategoryPicker v-model="categoryId" @change="handleCategoryChange" />
    </div>

    <div class="py-4">
      <div class="font-bold mb-3">{{ $t('event.sidebar.rate') }}</div>
      <div class="space-y-4">
        <RadioBox
          v-model="priceSort"
          :options="priceSortOptions"
          input-name="priceSort"
          wrapper-class="grid grid-cols-1 gap-2"
          @change="handleSortChange"
        />
      </div>
    </div>
  </div>
</template>

<script>
import PrefecturePicker from '@/components/molecules/form/PrefecturePicker'
import CategoryPicker from '@/components/molecules/form/CategoryPicker'
import RadioBox from '@/components/molecules/form/RadioBox'

export default {
  components: { PrefecturePicker, CategoryPicker, RadioBox },
  data() {
    return {
      prefectureId: null,
      categoryId: null,
      priceSort: null,
      priceSortOptions: [
        { code: null, name: this.$t('event.sidebar.priceOptions.all') },
        { code: 1, name: this.$t('event.sidebar.priceOptions.lessThan1k') },
        { code: 2, name: this.$t('event.sidebar.priceOptions.bw1ka3k') },
        { code: 3, name: this.$t('event.sidebar.priceOptions.bw3ka6k') },
        { code: 4, name: this.$t('event.sidebar.priceOptions.moreThan6k') },
      ],
    }
  },
  fetch() {
    this.prefectureId = this.$route.query.prefecture
      ? parseInt(this.$route.query.prefecture)
      : null
    this.categoryId = this.$route.query.category
      ? parseInt(this.$route.query.category)
      : null
  },
  watch: {
    '$route.query': '$fetch',
  },
  watchQuery: true,
  methods: {
    handleSortChange(value) {
      let query = {}
      switch (value) {
        case 1:
          query = { ...this.$route.query, ...{ price_to: 1000 } }
          delete query.price_from
          break
        case 2:
          query = {
            ...this.$route.query,
            ...{ price_from: 1000, price_to: 3000 },
          }
          break
        case 3:
          query = {
            ...this.$route.query,
            ...{
              price_from: 3000,
              price_to: 6000,
            },
          }
          break
        case 4:
          query = { ...this.$route.query, ...{ price_from: 6000 } }
          delete query.price_to
          break
        default:
          query = { ...this.$route.query }
          delete query.price_from
          delete query.price_to
      }
      delete query.page
      this.$router.replace({ query })
    },
    handlePrefChange(prefectureId) {
      if (!prefectureId) return
      const query = { ...this.$route.query, prefecture: prefectureId }
      delete query.page
      this.$router.replace({ query })
    },
    handleCategoryChange(categoryId) {
      if (!categoryId) return
      const query = { ...this.$route.query, category: categoryId }
      delete query.page
      this.$router.replace({ query })
    },
  },
}
</script>
