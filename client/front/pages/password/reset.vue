<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <h2 class="mt-6 text-center text-3xl font-extrabold text-primary">
        パスワードリセット
      </h2>
    </div>
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-lg">
      <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
        <div v-if="error" class="mb-4 text-tertiary text-sm">
          ログインに失敗しました。入力を確認してください。
        </div>
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form class="space-y-6" @submit.prevent="handleSubmit(passwordReset)">
            <div class="mb-4">
              <label
                for="email"
                class="block text-sm font-medium text-gray-700"
              >
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
                  v-model="inputs.email"
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
                リセットする
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
      inputs: {
        email: null,
      },
      error: false,
    }
  },

  methods: {
    async passwordReset() {
      try {
        const params = {
          email: this.inputs.email,
        }
        await this.$api.store('auth/reset_password', params)

        this.$router.push(this.localeRoute({ name: 'password-complete' }))
      } catch (e) {
        console.error(e)
        this.$refs.formValidator.setErrors(e.response.data.errors)
      }
    },
  },
}
</script>
