<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />
    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8 text-xl">予約イベント詳細</div>
        <!-- Event Reservation Details -->
        <div class="mb-8">
          <table class="table-fixed w-full border-collapse border">
            <tbody>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-user-circle-icon class="w-6 h-6 text-orange" />
                    <span>注文者名</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  {{ customer.fullName }}
                </td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-mail-icon class="w-6 h-6 text-orange" />
                    <span>メールアドレス</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">{{ customer.email }}</td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-phone-icon class="w-6 h-6 text-orange" />
                    <span>電話番号</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">{{ customer.phone }}</td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-office-building-icon class="w-6 h-6 text-orange" />
                    <span>参加イベント名</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  <div class="flex items-center">
                    <span class="mr-2">{{ event.name }}</span>
                    <a
                      :href="
                        localePath({
                          name: 'mypage-myevent-edit-id',
                          params: { id: event.id },
                        })
                      "
                      target="_blank"
                      ><outline-external-link-icon class="w-4 h-4"
                    /></a>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- End: Reservation Details -->

        <!-- Payment Details -->
        <div class="mb-8">
          <h1 class="mb-4 text-lg font-bold">支払詳細</h1>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Payment Status</dt>
            <dd class="w-3/5">{{ reservation.status }}</dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Paid Time</dt>
            <dd class="w-3/5">
              {{ formatDate(reservation.createdAt) }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">イベント参加金額</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(reservation.subTotal) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">サービス料</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(reservation.adminFee) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">消費税</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(reservation.ownerTax) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">合計金額（税込）</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(reservation.total) }}
            </dd>
          </dl>
        </div>
        <!-- End: Payment Details -->
      </div>
    </mypage-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import Breadcrumb from '@/components/organisms/Breadcrumb'

export default {
  components: {
    MypageLayout,
    Breadcrumb,
  },
  middleware: 'auth',
  async fetch() {
    await Promise.all([
      this.$store.dispatch('eventReservation/fetchDetail', {
        id: this.reservationId,
      }),
    ])
  },
  computed: {
    ...mapGetters({
      reservation: 'eventReservation/detail',
    }),
    customer() {
      return this.reservation.user || {}
    },
    event() {
      return this.reservation.event || {}
    },
    eventAddress() {
      return this.event.space?.address1 || null
    },
    reservationId() {
      return this.$route.params.id || null
    },
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
          url: this.localeRoute({ name: 'mypage' }),
        },
        {
          id: 3,
          name: 'イベント注文一覧',
          url: this.localeRoute({ name: 'mypage-event_order' }),
        },
        {
          id: 4,
          name: '注文詳細',
          url: '',
        },
      ]
      return items
    },
  },
  methods: {
    formatDate(date) {
      return this.$dayjs(date).format('YYYY年MM月DD日 (dd) HH:mm')
    },
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>
