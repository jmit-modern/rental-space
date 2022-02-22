<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Steps :steps="steps" />
    </div>

    <div class="mt-8 py-4 bg-light">
      <div class="px-12 py-6">
        <div class="mb-8">
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-office-building-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('expert.reserveStep.invitee') }}</span>
            </dt>
            <dd class="w-3/5">{{ expert.user.fullName }}</dd>
            <dd class="w-1/5"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-calendar-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('expert.reserveStep.period') }}</span>
            </dt>
            <dd class="w-3/5">
              {{ formatDate(reserveFrom) }}〜{{ formatDate(reserveTo) }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-user-group-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('expert.reserveStep.numberOfPeople') }}</span>
            </dt>
            <dd class="w-3/5">
              {{
                $t('expert.reserveStep.adultsNumber', {
                  number: reserveDetail.people,
                })
              }}
              <span class="mx-2">/</span>
              {{
                $t('expert.reserveStep.childrenNumber', {
                  number: reserveDetail.children,
                })
              }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-presentation-chart-line-icon
                class="w-6 h-6 text-orange"
              />
              <span>{{ $t('expert.reserveStep.purpose') }}</span>
            </dt>
            <dd class="w-3/5">
              {{ categoryName }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-presentation-chart-bar-icon
                class="w-6 h-6 text-orange"
              />
              <span>{{ $t('expert.reserveStep.description') }}</span>
            </dt>
            <dd class="w-3/5">
              {{ reserveDetail.description }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-calculator-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('expert.reserveStep.skillTitle') }}</span>
            </dt>
            <dd class="w-3/5">{{ expert.skillTitle }}</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.subTotal) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">
              {{ $t('expert.reserveStep.serviceFee') }}
            </dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.adminFee) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">{{ $t('expert.reserveStep.tax') }}</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.ownerTax) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">
              {{ $t('expert.reserveStep.total') }}
            </dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.total) }}
            </dd>
          </dl>
        </div>

        <button
          :class="[
            'w-full items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
            invalid
              ? 'cursor-not-allowed opacity-40'
              : 'hover:opacity-80 cursor-pointer',
          ]"
          :disabled="invalid"
          @click.prevent="handleNext"
        >
          {{ $t('expert.reserveStep.next') }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import Steps from '@/components/molecules/navigation/Steps'

export default {
  components: {
    Steps,
  },
  middleware: 'auth',
  fetchOnServer: false,
  data() {
    return {
      invalid: false,
      confirm: null,
      steps: [
        {
          id: '01',
          name: this.$t('expert.reserveStep.details'),
          route: this.localeRoute({ name: 'expert-reserve' }),
          status: 'complete',
        },
        {
          id: '02',
          name: this.$t('expert.reserveStep.confirmation'),
          route: '',
          status: 'current',
        },
        {
          id: '03',
          name: this.$t('expert.reserveStep.checkout'),
          route: '',
          status: 'upcoming',
        },
      ],
    }
  },
  async fetch() {
    if (!this.expertId) {
      this.$router.push(this.localeRoute('expert'))
      return
    }
    const params = {
      expertId: this.expertId,
      reserveFrom: this.reserveFrom,
      reserveTo: this.reserveTo,
    }
    this.confirm = await this.$api.store('expert_reservations/checkout', params)
  },
  computed: {
    ...mapGetters({
      reserveDetail: 'localStorage/expertReservation',
      categoryDict: 'master/categoryDict',
    }),
    expertId() {
      return this.reserveDetail?.expertId || null
    },
    reserveFrom() {
      return this.reserveDetail?.reserveFrom || null
    },
    reserveTo() {
      return this.reserveDetail?.reserveTo || null
    },
    categoryName() {
      if (!this.reserveDetail.categoryId) return null
      return this.categoryDict[this.reserveDetail.categoryId].name
    },
    expert() {
      return this.confirm?.expert || { user: {} }
    },
    checkout() {
      return this.confirm?.checkout || {}
    },
  },
  methods: {
    handleNext() {
      this.$router.push(this.localeRoute({ name: 'expert-reserve-payment' }))
    },
    formatNumber(...args) {
      return formatNumber(...args)
    },
    formatDate(date) {
      return this.$dayjs(date).format('YYYY年MM月DD日 (dd) HH:mm')
    },
  },
}
</script>
