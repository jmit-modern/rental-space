<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="mt-5">
      <Detail :detail="expert" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Detail from '@/components/organisms/page/expert/Detail'
import Breadcrumb from '@/components/organisms/Breadcrumb'

export default {
  components: { Detail, Breadcrumb },
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('expert/fetchDetail', { id })])
  },
  computed: {
    ...mapGetters({
      expert: 'expert/detail',
    }),
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
          url: this.localeRoute({ name: 'expert' }),
        },
        {
          id: 3,
          name: this.$t('expert.detail.breadcrumb'),
        },
      ]
      return items
    },
  },
}
</script>
