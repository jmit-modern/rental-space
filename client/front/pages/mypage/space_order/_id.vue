<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />
    <mypage-layout>
      <div class="px-4 py-5">
        <div
          v-if="reservation.status !== 'reserved'"
          class="text-sm text-right mb-4"
        >
          <vue-countdown-timer
            :start-time="'2018-01-01 00:00:00'"
            :end-time="
              $dayjs(reservation.paymentExecTime).format('YYYY-MM-DD HH:mm:ss')
            "
            :interval="1000"
            :start-label="'Until start'"
            :end-label="'自動キャンセルまで残り時間'"
            label-position="begin"
            :end-text="'Event ended!'"
            :day-txt="'日'"
            :hour-txt="'時間'"
            :minutes-txt="'分'"
            :seconds-txt="'秒'"
          >
            <template slot="start-label" slot-scope="scope">
              <span
                v-if="
                  scope.props.startLabel !== '' &&
                  scope.props.tips &&
                  scope.props.labelPosition === 'begin'
                "
                class="text-tertiary"
                >{{ scope.props.startLabel }}:</span
              >
              <span
                v-if="
                  scope.props.endLabel !== '' &&
                  !scope.props.tips &&
                  scope.props.labelPosition === 'begin'
                "
                class="text-tertiary"
                >{{ scope.props.endLabel }}:</span
              >
            </template>

            <template slot="countdown" slot-scope="scope">
              <span>{{ scope.props.days }} {{ scope.props.dayTxt }}</span>
              <span>{{ scope.props.hours }} {{ scope.props.hourTxt }}</span>
              <span
                >{{ scope.props.minutes }} {{ scope.props.minutesTxt }}</span
              >
              <span
                >{{ scope.props.seconds }} {{ scope.props.secondsTxt }}</span
              >
            </template>

            <template slot="end-label" slot-scope="scope">
              <span
                v-if="
                  scope.props.startLabel !== '' &&
                  scope.props.tips &&
                  scope.props.labelPosition === 'end'
                "
                class="text-tertiary"
                >{{ scope.props.startLabel }}:</span
              >
              <span
                v-if="
                  scope.props.endLabel !== '' &&
                  !scope.props.tips &&
                  scope.props.labelPosition === 'end'
                "
                class="text-tertiary"
                >{{ scope.props.endLabel }}:</span
              >
            </template>

            <template slot="end-text" slot-scope="scope">
              <span>{{ scope.props.endText }}</span>
            </template>
          </vue-countdown-timer>
        </div>
        <div class="flex justify-between mb-8">
          <div>
            <span class="font-bold">Reservation Status: </span>
            <span>{{ reservation.status }}</span>
          </div>
          <div class="text-right">
            <button
              v-if="reservation.approved"
              :class="[
                'cursor-not-allowed opacity-40 items-center px-4 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
              ]"
            >
              Approved
            </button>
            <button
              v-else
              :class="[
                'hover:opacity-80 cursor-pointer items-center px-4 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
              ]"
              @click="approveOrder"
            >
              Approve
            </button>
          </div>
        </div>
        <!-- Reservation Details -->
        <div class="mb-8">
          <h1 class="mb-4 text-lg font-bold">Order Details</h1>
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
          <h1 class="mb-4 text-lg font-bold">Payment Details</h1>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Payment Status</dt>
            <dd class="w-3/5">Pending</dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Payment Id (Stripe)</dt>
            <dd class="w-3/5"></dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5">Paid Time</dt>
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
          <h1 class="text-lg font-bold mb-4">注文者情報</h1>
          <div>
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5">注文者名</dt>
              <dd class="w-3/5">{{ reservationUser.fullName }}</dd>
              <dd class="w-1/5 text-right"></dd>
            </dl>
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5">メイル</dt>
              <dd class="w-3/5">{{ reservationUser.email }}</dd>
              <dd class="w-1/5 text-right"></dd>
            </dl>
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5">電話番号</dt>
              <dd class="w-3/5">{{ reservationUser.phone }}</dd>
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
    reservationUser() {
      return this.reservation.user || {}
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
          url: this.localeRoute({ name: 'mypage-myspace' }),
        },
        {
          id: 3,
          name: 'スペース注文一覧',
          url: this.localeRoute({ name: 'mypage-space_order' }),
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
    async approveOrder() {
      await this.$store.dispatch('reservation/approve', [this.reservationId])
    },
  },
}
</script>
