<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />
    <mypage-layout>
      <div class="px-4 py-5">
        <div class="mb-8 text-xl">My Reservation Detail</div>
        <div class="mb-8">
          <span class="font-bold">Reservation Status: </span>
          <span>{{ reservation.status }}</span>
        </div>
        <!-- Reservation Details -->
        <div class="mb-8">
          <h1 class="mb-4 text-lg font-bold">Reservation Details</h1>
          <table class="table-fixed w-full border-collapse border">
            <tbody>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-office-building-icon class="w-6 h-6 text-orange" />
                    <span>スペース</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  <div class="flex items-center">
                    <span class="mr-2">{{ space.name }}</span>
                    <a
                      :href="
                        localePath({
                          name: 'space-id',
                          params: { id: space.id },
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
                    <span>プラン</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  {{ planName }}
                </td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-calendar-icon class="w-6 h-6 text-orange" />
                    <span>利用期間</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  {{ formatDate(reservation.reserveFrom) }}〜{{
                    formatDate(reservation.reserveTo)
                  }}
                </td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-user-group-icon class="w-6 h-6 text-orange" />
                    <span>人数</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  大人 {{ reservation.people }} 人
                  <span class="mx-2">/</span> 子ども（12歳以下）
                  {{ reservation.children }} 人
                </td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-presentation-chart-line-icon
                      class="w-6 h-6 text-orange"
                    />
                    <span>用途</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  {{ categoryName }}
                </td>
              </tr>
              <tr>
                <th class="w-1/4 border p-4">
                  <div class="flex items-center space-x-6">
                    <outline-presentation-chart-bar-icon
                      class="w-6 h-6 text-orange"
                    />
                    <span>用途詳細</span>
                  </div>
                </th>
                <td class="w-3/4 border p-4">
                  {{ reservation.description }}
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <!-- End: Reservation Details -->
        <!-- Payment Details -->
        <div class="mb-8">
          <h1 class="mb-4 text-lg font-bold">決済詳細</h1>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Payment Status</dt>
            <dd class="w-3/5"></dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">支払状態</dt>
            <dd class="w-3/5"></dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">スペース賃料</dd>
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
        <!-- Owner Details -->
        <div v-if="reservation.status == 'reserved'" class="mb-8">
          <h1 class="text-lg font-bold mb-4">Owner Detail</h1>
          <div>
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5">Name</dt>
              <dd class="w-3/5">{{ spaceOwner.fullName }}</dd>
              <dd class="w-1/5 text-right"></dd>
            </dl>
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5">Email</dt>
              <dd class="w-3/5">{{ spaceOwner.email }}</dd>
              <dd class="w-1/5 text-right"></dd>
            </dl>
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5">Phone number</dt>
              <dd class="w-3/5">{{ spaceOwner.phone }}</dd>
              <dd class="w-1/5 text-right"></dd>
            </dl>
          </div>
        </div>
        <!-- End: Owner Details -->
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
      this.$store.dispatch('reservation/fetchDetail', {
        id: this.reservationId,
      }),
    ])
  },
  computed: {
    ...mapGetters({
      reservation: 'reservation/detail',
    }),
    space() {
      return this.reservation.space || {}
    },
    planName() {
      return this.reservation.plan?.name || null
    },
    reservationId() {
      return this.$route.params.id || null
    },
    categoryName() {
      return this.reservation.category?.name || null
    },
    spaceOwner() {
      return this.space.owner || {}
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
          name: '予約スペース',
          url: this.localeRoute({ name: 'mypage-space_reservation' }),
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
