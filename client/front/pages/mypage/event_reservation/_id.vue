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
                    <outline-office-building-icon class="w-6 h-6 text-orange" />
                    <span>イベント名</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  <div class="flex items-center">
                    <span class="mr-2">{{ event.name }}</span>
                    <a
                      :href="
                        localePath({
                          name: 'event-id',
                          params: { id: event.id },
                        })
                      "
                      target="_blank"
                      ><outline-external-link-icon class="w-4 h-4"
                    /></a>
                  </div>
                </td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-calculator-icon class="w-6 h-6 text-orange" />
                    <span>イベント開催場所</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">{{ eventAddress }}</td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-calendar-icon class="w-6 h-6 text-orange" />
                    <span>開催時間</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  {{ formatDate(event.startingAt) }}〜{{
                    formatDate(event.endingAt)
                  }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- End: Reservation Details -->

        <!-- Event Participation QR code -->
        <div class="mb-8">
          <h1 class="mb-4 text-lg font-bold">イベント参加QRコード</h1>
          <img :src="reservation.qrCode" alt="" />
        </div>
        <!-- End: Event Participation QR code -->

        <!-- Payment Details -->
        <div class="mb-8">
          <h1 class="mb-4 text-lg font-bold">支払詳細</h1>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Payment Id (Stripe)</dt>
            <dd class="w-3/5">{{ reservation.stripeId }}</dd>
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
          url: this.localeRoute({ name: 'mypage-myspace' }),
        },
        {
          id: 3,
          name: '予約イベント',
          url: this.localeRoute({ name: 'mypage-event_reservation' }),
        },
        {
          id: 4,
          name: '予約詳細',
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
