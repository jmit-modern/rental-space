<template>
  <div>
    <div class="max-w-7xl mx-auto">
      <div class="mt-10">
        <Steps :steps="steps" />
      </div>

      <div class="mt-8 py-4 bg-light">
        <div class="px-12 py-6">
          <div class="lg:w-1/2 mb-8 lg:mx-auto">
            <dl class="px-2 py-4 flex border-b">
              <dt class="w-1/5"></dt>
              <dd class="w-3/5 text-right">
                {{ $t('space.reserveStep.spaceFee') }}
              </dd>
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
              <dd class="w-3/5 text-right">
                {{ $t('space.reserveStep.tax') }}
              </dd>
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
          <div class="lg:w-1/2 mb-8 lg:mx-auto">
            <StripeForm ref="stripeForm" />
            <button
              type="button"
              class="
                w-full
                items-center
                px-5
                py-1.5
                border border-transparent
                shadow-sm
                text-base
                font-medium
                rounded-md
                text-main
                bg-orange
                focus:outline-none
                mt-4
              "
              @click="handlePay"
            >
              {{ $t('space.reserveStep.checkout') }}
            </button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import Steps from '@/components/molecules/navigation/Steps'
import StripeForm from '@/components/molecules/form/StripeForm'

export default {
  components: {
    Steps,
    StripeForm,
  },
  middleware: 'auth',
  fetchOnServer: false,
  data() {
    return {
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
          route: this.localeRoute({ name: 'space-reserve-confirm' }),
          status: 'complete',
        },
        {
          id: '03',
          name: this.$t('space.reserveStep.checkout'),
          route: '',
          status: 'current',
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
    checkout() {
      return this.confirm?.checkout || {}
    },
  },
  methods: {
    formatNumber(...args) {
      return formatNumber(...args)
    },
    async handlePay() {
      try {
        this.$nuxt.$emit('loading', true)
        const token = await this.$refs.stripeForm.token()

        const params = {
          ...this.reserveDetail,
          ...{ stripeToken: token.id },
        }
        const { clientSecret } = await this.$api.store(
          'reservations/charge',
          params
        )

        const cardSetupResult = await this.$refs.stripeForm.confirmCardSetup(
          clientSecret
        )
        if (cardSetupResult.error) {
          this.$refs.stripeForm.handleError(cardSetupResult.error.message)
        } else {
          this.$store.commit('localStorage/clearReservation')
          this.$router.push(
            this.localeRoute({ name: 'space-reserve-complete' })
          )
        }
      } catch (e) {
        console.error(e)
        if (e.type && e.type === 'validation_error') {
          this.$refs.stripeForm.handleError('入力を確認してください。')
        }
        if (e.response && e.response.status === 502) {
          // if Card error exists Display error message
          this.$refs.stripeForm.handleError(e.response.data.error)
        } else {
          await this.$refs.stripeForm.reset()
        }
      } finally {
        this.$nuxt.$emit('loading', false)
      }
    },
  },
}
</script>
