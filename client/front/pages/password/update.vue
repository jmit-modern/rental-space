<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <h2 class="mt-6 text-center text-3xl font-extrabold text-primary">
        パスワードアップデート
      </h2>
    </div>
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-lg">
      <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
        <div v-if="error" class="mb-4 text-tertiary text-sm">
          無効なトークンです。
        </div>
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form
            class="space-y-6"
            @submit.prevent="handleSubmit(updatePassword)"
          >
            <!-- Password -->
            <div class="mb-4">
              <label
                for="password"
                class="block text-sm font-medium text-gray-700"
              >
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
                  v-model="password"
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
                <span class="input-invalid-message text-tertiary text-sm block">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
            </div>

            <!-- Password Confirm-->
            <div class="mb-4">
              <label
                for="password"
                class="block text-sm font-medium text-gray-700"
              >
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
                  v-model="passwordConfirm"
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
            <div>
              <button
                class="
                  w-full
                  flex
                  justify-center
                  py-2
                  px-4
                  border border-transparent
                  rounded-md
                  shadow-sm
                  text-sm
                  font-medium
                  text-white
                  bg-orange
                  hover:opacity-80
                  focus:outline-none
                  cursor-pointer
                "
                type="submit"
              >
                アップデート
              </button>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  components: {},
  middleware: 'guest',
  data() {
    return {
      password: null,
      passwordConfirm: null,
      error: false,
    }
  },

  methods: {
    async updatePassword() {
      if (!this.$route.query.token || !this.$route.query.user) {
        this.error = true
        return false
      }
      try {
        const params = {
          newPassword: this.password,
          token: this.$route.query.token,
          userId: parseInt(this.$route.query.user),
        }
        await this.$api.store('auth/update_password', params)

        this.$router.push(this.localeRoute({ name: 'user-login' }))
      } catch (e) {
        console.error(e)
        this.error = true
      }
    },
  },
}
</script>
