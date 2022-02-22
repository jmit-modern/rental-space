<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="mt-5">
      <EventDetail :detail="event" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import EventDetail from '@/components/organisms/page/event/Detail'

export default {
  components: { Breadcrumb, EventDetail },
  data() {
    return {}
  },
  async fetch() {
    const { id } = this.$route.params
    await Promise.all([this.$store.dispatch('event/fetchDetail', { id })])
  },
  computed: {
    ...mapGetters({
      event: 'event/detail',
    }),
    breadcrumbs() {
      return [
        {
          id: 1,
          name: this.$t('top.breadcrumb'),
          url: this.localeRoute({ name: 'index', query: {} }),
        },
        {
          id: 2,
          name: this.$t('event.breadcrumb'),
          url: this.localeRoute({ name: 'event' }),
        },
        {
          id: 3,
          name: this.$t('event.detail.breadcrumb'),
        },
      ]
    },
  },
}
</script>
