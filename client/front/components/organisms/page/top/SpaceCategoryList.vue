<template>
  <div
    class="
      grid grid-cols-1
      lg:grid-cols-4
      gap-4
      lg:gap-8
      items-center
      px-4
      py-5
      border-b border-gray-300
    "
  >
    <div class="label">
      <h5 class="font-bold text-primary">
        {{ $t('top.spaceCategoryList.label') }}
      </h5>
    </div>
    <div class="col-span-3">
      <div class="grid grid-cols-4 gap-4">
        <nuxt-link
          v-for="category in categories"
          :key="category.id"
          :to="localeRoute({ name: tab, query: { category: category.id } })"
          class="
            border border-gray-300
            text-center
            py-1.5
            rounded-sm
            bg-light
            hover:bg-current hover:text-main hover:border-current
            text-primary
          "
        >
          {{ category.name }}
        </nuxt-link>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  props: {
    tab: {
      type: String,
      default: 'space',
    },
  },
  computed: {
    ...mapGetters({
      categories: 'master/categories',
    }),
    tabLink() {
      const targetUrl = this.localePath(this.tab)
      return targetUrl
    },
  },
}
</script>
