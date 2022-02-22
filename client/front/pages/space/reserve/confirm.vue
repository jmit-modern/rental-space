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
              <span>{{ $t('space.reserveStep.space') }}</span>
            </dt>
            <dd class="w-3/5">{{ space.name }}</dd>
            <dd class="w-1/5"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-calendar-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('space.reserveStep.period') }}</span>
            </dt>
            <dd class="w-3/5">
              {{ formatDate(reserveFrom) }}〜{{ formatDate(reserveTo) }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-user-group-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('space.reserveStep.numberOfPeople') }}</span>
            </dt>
            <dd class="w-3/5">
              {{
                $t('space.reserveStep.adultsNumber', {
                  number: reserveDetail.people,
                })
              }}
              <span class="mx-2">/</span>
              {{
                $t('space.reserveStep.childrenNumber', {
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
              <span>{{ $t('space.reserveStep.purpose') }}</span>
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
              <span>{{ $t('space.reserveStep.description') }}</span>
            </dt>
            <dd class="w-3/5">
              {{ reserveDetail.description }}
            </dd>
            <dd class="w-1/5 text-right"></dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5 flex items-center space-x-6">
              <outline-calculator-icon class="w-6 h-6 text-orange" />
              <span>{{ $t('space.reserveStep.plan') }}</span>
            </dt>
            <dd class="w-3/5">{{ plan.name }}</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.subTotal) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">
              {{ $t('space.reserveStep.serviceFee') }}
            </dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.adminFee) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex border-b">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">{{ $t('space.reserveStep.tax') }}</dd>
            <dd class="w-1/5 text-right">
              ￥ {{ formatNumber(checkout.ownerTax) }}
            </dd>
          </dl>
          <dl class="px-2 py-4 flex">
            <dt class="w-1/5"></dt>
            <dd class="w-3/5 text-right">
              {{ $t('space.reserveStep.total') }}
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
          {{ $t('space.reserveStep.next') }}
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
          name: this.$t('space.reserveStep.details'),
          route: this.localeRoute({ name: 'space-reserve' }),
          status: 'complete',
        },
        {
          id: '02',
          name: this.$t('space.reserveStep.confirmation'),
          route: '',
          status: 'current',
        },
        {
          id: '03',
          name: this.$t('space.reserveStep.checkout'),
          route: '',
          status: 'upcoming',
        },
      ],
    }
  },
  async fetch() {
    if (!this.spaceId) {
      this.$router.push(this.localeRoute('space'))
      return
    }
    const params = {
      spaceId: this.spaceId,
      planId: this.planId,
      reserveFrom: this.reserveFrom,
      reserveTo: this.reserveTo,
    }
    this.confirm = await this.$api.store('reservations/checkout', params)
  },
  computed: {
    ...mapGetters({
      reserveDetail: 'localStorage/reservation',
      categoryDict: 'master/categoryDict',
    }),
    spaceId() {
      return this.reserveDetail?.spaceId || null
    },
    planId() {
      return this.reserveDetail?.planId || null
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
    space() {
      return this.confirm?.space || {}
    },
    plan() {
      return this.confirm?.plan || {}
    },
    checkout() {
      return this.confirm?.checkout || {}
    },
  },
  methods: {
    handleNext() {
      this.$router.push(this.localeRoute({ name: 'space-reserve-payment' }))
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
