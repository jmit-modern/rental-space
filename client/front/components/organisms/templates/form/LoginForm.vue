<template>
  <div>
    <div class="mb-4">
      <label for="email" class="block text-sm font-medium text-gray-700">
        {{ $t('email') }} <span>*</span>
      </label>
      <ValidationProvider
        v-slot="{ errors }"
        :name="$t('email')"
        rules="required|email"
        vid="email"
      >
        <input
          id="email"
          :value="value.email"
          name="email"
          type="email"
          autocomplete="email"
          class="
            appearance-none
            block
            w-full
            px-3
            py-2
            border border-gray-300
            rounded-md
            shadow-sm
            placeholder-gray-400
            focus:outline-none focus:ring-orange focus:border-orange
            sm:text-sm
          "
          @input="updateValue('email', $event.target.value)"
        />
        <span class="input-invalid-message text-tertiary text-sm">
          {{ errors[0] }}
        </span>
      </ValidationProvider>
    </div>

    <div class="mb-4">
      <label for="password" class="block text-sm font-medium text-gray-700">
        {{ $t('password') }} <span>*</span>
      </label>
      <ValidationProvider
        v-slot="{ errors }"
        name="パスワード"
        rules="required"
        vid="password"
      >
        <input
          id="password"
          :value="value.password"
          name="password"
          type="password"
          autocomplete="password"
          class="
            appearance-none
            block
            w-full
            px-3
            py-2
            border border-gray-300
            rounded-md
            shadow-sm
            placeholder-gray-400
            focus:outline-none focus:ring-orange focus:border-orange
            sm:text-sm
            mt-1
          "
          @input="updateValue('password', $event.target.value)"
        />
        <span class="input-invalid-message text-tertiary text-sm">
          {{ errors[0] }}
        </span>
      </ValidationProvider>
    </div>

    <div class="flex items-center justify-between">
      <div class="flex items-center">
        <input
          id="remember_me"
          name="remember_me"
          type="checkbox"
          class="h-4 w-4 text-orange focus:ring-orange border-gray-300 rounded"
        />
        <label for="remember_me" class="ml-2 block text-sm text-gray-900">
          {{ $t('rememberme') }}
        </label>
      </div>

      <div class="text-sm">
        <nuxt-link
          :to="localeRoute({ name: 'password-reset' })"
          class="font-medium text-orange hover:text-orange"
        >
          {{ $t('forgotPassword') }}
        </nuxt-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      type: Object,
      required: true,
    },
  },
  methods: {
    updateValue(key, value) {
      this.$emit('input', { ...this.value, [key]: value })
    },
  },
}
</script>
