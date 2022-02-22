<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />
    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8 text-xl">{{ $t('mypage.space_order.title') }}</div>
        <div v-if="!$fetchState.pending && reservations" class="divide-y">
          <div
            v-for="reservation in reservations"
            :key="reservation.id"
            class="flex items-center justify-between p-4 space-x-4"
          >
            <div class="flex justify-between flex-1">
              <h1 class="flex-1">
                {{ reservation.space.name }}
              </h1>
              <span class="text-sm flex-initial">
                {{ formatDate(reservation.reserveFrom) }}<br />
                {{ formatDate(reservation.reserveTo) }}
              </span>
            </div>
            <div class="flex-initial">
              <nuxt-link
                :to="
                  localePath({
                    name: 'mypage-space_order-id',
                    params: { id: reservation.id },
                  })
                "
              >
                <outline-eye-icon class="w-6 h-6" />
              </nuxt-link>
            </div>
          </div>
        </div>
      </div>
    </mypage-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import { filterQueryParams } from '@/utils/http'

export default {
  components: {
    MypageLayout,
    Breadcrumb,
  },
  middleware: 'auth',
  async fetch() {
    const { user } = this.$auth.user
    const params = {
      owner_id: user.id,
    }
    const query = filterQueryParams(params)
    await Promise.all([this.$store.dispatch('reservation/fetchOrders', query)])
  },
  computed: {
    ...mapGetters({
      reservations: 'reservation/data',
    }),
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: 'ホーム',
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: 'マイページ',
          url: this.localeRoute({ name: 'mypage-myspace' }),
        },
        {
          id: 3,
          name: 'スペース注文一覧',
        },
      ]
      return items
    },
  },
  methods: {
    formatDate(date) {
      return this.$dayjs(date).format('YYYY年MM月DD日 (dd) HH:mm')
    },
  },
}
</script>
