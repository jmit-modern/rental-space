<template>
  <div>
    <!-- Firstname & Lastname -->
    <div class="grid grid-cols-2 gap-3 mb-4">
      <!-- Firstname -->
      <div>
        <label for="firstName" class="block text-sm font-medium text-gray-700">
          {{ $t('firstName') }} <span class="text-tertiary">*</span>
        </label>

        <ValidationProvider
          v-slot="{ errors }"
          :name="$t('firstName')"
          rules="required"
          vid="first_name"
        >
          <input
            id="firstName"
            :value="value.firstName"
            @input="updateValue('firstName', $event.target.value)"
            name="firstName"
            type="text"
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
          /><span class="input-invalid-message text-tertiary text-sm">
            {{ errors[0] }}
          </span></ValidationProvider
        >
      </div>
      <!-- Last name -->
      <div>
        <label for="lastName" class="block text-sm font-medium text-gray-700">
          {{ $t('lastName') }} <span class="text-tertiary">*</span>
        </label>
        <ValidationProvider
          v-slot="{ errors }"
          :name="$t('lastName')"
          rules="required"
          vid="last_name"
        >
          <input
            id="lastName"
            :value="value.lastName"
            @input="updateValue('lastName', $event.target.value)"
            name="lastName"
            type="text"
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
          />
          <span class="input-invalid-message text-tertiary text-sm">
            {{ errors[0] }}
          </span>
        </ValidationProvider>
      </div>
    </div>

    <!-- Email address -->
    <div class="mb-4">
      <label for="email" class="block text-sm font-medium text-gray-700">
        {{ $t('email') }} <span class="text-tertiary">*</span>
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
          @input="updateValue('email', $event.target.value)"
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
            mt-1
          "
        />
        <span class="input-invalid-message text-tertiary text-sm">
          {{ errors[0] }}
        </span>
      </ValidationProvider>
    </div>

    <!-- Password -->
    <div class="mb-4">
      <label for="password" class="block text-sm font-medium text-gray-700">
        {{ $t('password') }} <span class="text-tertiary">*</span>
      </label>
      <ValidationProvider
        v-slot="{ errors }"
        name="パスワード"
        rules="required|min:8|max:32|atLeastOneUppercase|atLeastOneLowercase"
        vid="password"
      >
        <input
          id="password"
          :value="value.password"
          @input="updateValue('password', $event.target.value)"
          name="password"
          type="password"
          autocomplete="current-password"
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
        />
        <span
          v-for="(error, index) in errors"
          :key="index"
          class="input-invalid-message text-tertiary text-sm block"
        >
          {{ error }}
        </span>
      </ValidationProvider>
    </div>

    <!-- Password Confirm-->
    <div class="mb-4">
      <label for="password" class="block text-sm font-medium text-gray-700">
        {{ $t('passwordConfirm') }} <span class="text-tertiary">*</span>
      </label>
      <ValidationProvider
        v-slot="{ errors }"
        name="パスワード"
        rules="required|confirmed:password"
        vid="password_confirm"
      >
        <input
          id="passwordConfirm"
          :value="value.passwordConfirm"
          @input="updateValue('passwordConfirm', $event.target.value)"
          name="passwordConfirm"
          type="password"
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
        <a href="#" class="font-medium text-orange hover:text-orange">
          {{ $t('forgotPassword') }}
        </a>
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
