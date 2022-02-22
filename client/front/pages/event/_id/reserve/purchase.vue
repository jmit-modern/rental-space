<template>
  <div class="max-w-7xl mx-auto">
    <div class="mt-10">
      <Breadcrumb :items="breadcrumbs" />
    </div>
    <div class="lg:w-1/2 mb-8 lg:mx-auto mt-8">
      <dl class="flex items-center border-b">
        <dt class="w-1/5 flex items-center space-x-2">
          <outline-newspaper-icon class="w-6 h-6 text-orange" />
          <span>イベント名</span>
        </dt>
        <dd class="w-4/5 px-2 py-4">{{ event.name }}</dd>
      </dl>
      <dl class="flex items-center border-b">
        <dt class="w-4/5 px-2 py-4 text-right">合計金額（税込）</dt>
        <dd class="w-1/5 px-2 py-4 text-right">
          ￥ {{ formatNumber(event.price) }}
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
          mt-6
        "
        @click="handlePay"
      >
        支払いする
      </button>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { formatNumber } from '@/utils/format'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import StripeForm from '@/components/molecules/form/StripeForm'

export default {
  components: {
    Breadcrumb,
    StripeForm,
  },
  middleware: 'auth',
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
          name: 'ホーム',
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: 'イベント詳細',
          url: {
            name: 'space___jp',
            query: {},
          },
        },
      ]
    },
  },
  methods: {
    async handlePay() {
      try {
        this.$nuxt.$emit('loading', true)
        const token = await this.$refs.stripeForm.token()

        const { user } = this.$auth.user
        const params = {
          userId: user.id,
          eventId: this.event.id,
          stripeToken: token.id,
        }
        const { clientSecret } = await this.$api.store(
          'event_reservations/charge',
          params
        )

        const cardSetupResult = await this.$refs.stripeForm.confirmCardSetup(
          clientSecret
        )
        if (cardSetupResult.error) {
          this.$refs.stripeForm.handleError(cardSetupResult.error.message)
        } else {
          this.$router.push(
            this.localeRoute({ name: 'space-reserve-complete' })
          )
        }

        this.$router.push(
          this.localeRoute({
            name: 'event-id-reserve-complete',
            params: { id: this.event.id },
          })
        )
      } catch (e) {
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
    formatNumber(...args) {
      return formatNumber(...args)
    },
  },
}
</script>
