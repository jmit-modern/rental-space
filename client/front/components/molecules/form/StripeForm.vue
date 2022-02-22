<template>
  <div class="payment-simple">
    <StripeElements
      ref="elms"
      v-slot="{ elements }"
      :stripe-key="stripeKey"
      :instance-options="instanceOptions"
      :elements-options="elementsOptions"
    >
      <div>
        <img src="@/assets/image/credit-cards-7.jpg" alt="" class="h-6 mb-4" />
      </div>
      <div class="mb-4">
        <label class="text-sm mb-2">{{
          $t('form.paymentForm.cardNumber')
        }}</label>
        <StripeElement
          ref="cardNumber"
          type="cardNumber"
          :elements="elements"
          :options="cardNumberOptions"
        />
      </div>
      <div class="flex space-x-8">
        <div class="w-24">
          <label class="text-sm mb-2">{{
            $t('form.paymentForm.expiredAt')
          }}</label>
          <StripeElement
            ref="cardExpiry"
            type="cardExpiry"
            :elements="elements"
            :options="cardExpiryOptions"
          />
        </div>
        <div class="w-40">
          <label class="text-sm mb-2">{{
            $t('form.paymentForm.securityCode')
          }}</label>
          <StripeElement
            ref="cardCvc"
            type="cardCvc"
            :elements="elements"
            :options="cardCvcOptions"
          />
        </div>
      </div>
    </StripeElements>
    <div class="text-tertiary text-xs mt-4" v-show="error">{{ error }}</div>
  </div>
</template>

<script>
import { StripeElements, StripeElement } from 'vue-stripe-elements-plus'

export default {
  name: 'PaymentSimple',

  components: {
    StripeElements,
    StripeElement,
  },

  data() {
    return {
      cardOnName: null,
      stripeKey: process.env.stripeKey, // test key, don't hardcode
      instanceOptions: {
        // https://stripe.com/docs/js/initializing#init_stripe_js-options
      },
      elementsOptions: {
        // https://stripe.com/docs/js/elements_object/create#stripe_elements-options
      },
      cardNumberOptions: {
        // https://stripe.com/docs/js/elements_object/create_element?type=cardNumber
        showIcon: true,
        iconStyle: 'solid',
        style: {
          base: {
            backgroundColor: '#fff',
            fontSize: '18px',
            fontSmoothing: 'always',
          },
        },
      },
      cardExpiryOptions: {
        // https://stripe.com/docs/js/elements_object/create_element?type=cardExpiry
        style: {
          base: {
            backgroundColor: '#fff',
            fontSize: '18px',
            fontSmoothing: 'auto',
          },
        },
      },
      cardCvcOptions: {
        // https://stripe.com/docs/js/elements_object/create_element?type=cardCvc
        style: {
          base: {
            backgroundColor: '#fff',
            fontSize: '18px',
            fontSmoothing: 'auto',
          },
        },
      },
      error: null,
    }
  },

  methods: {
    async token() {
      this.error = null
      // ref in template
      const groupComponent = this.$refs.elms
      const cardComponent = this.$refs.cardNumber
      // Get stripe element
      const cardElement = cardComponent.stripeElement

      // Access instance methods, e.g. createToken()
      const { token } = await groupComponent.instance
        .createToken(cardElement)
        .then((result) => {
          // Handle result.error or result.token
          if (result.error) {
            throw result.error
          }
          return result
        })

      return token
    },
    async confirmCardSetup(clientSecret) {
      // ref in template
      const groupComponent = this.$refs.elms
      const cardComponent = this.$refs.cardNumber
      // Get stripe element
      const cardElement = cardComponent.stripeElement

      const result = await groupComponent.instance.confirmCardSetup(
        clientSecret,
        {
          payment_method: {
            card: cardElement,
          },
        }
      )

      return result
    },
    handleError(e) {
      this.error = e
    },
    reset() {
      this.$refs.cardNumber.stripeElement.clear()
      this.$refs.cardExpiry.stripeElement.clear()
      this.$refs.cardCvc.stripeElement.clear()
    },
  },
}
</script>
