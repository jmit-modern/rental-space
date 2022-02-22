<template>
  <div>
    <div class="w-96 m-auto mt-48">
      <img
        src="https://rental.himitsukichi.network/_nuxt/img/logo-transparent.2cae6c8.png"
        alt="Logo"
        class="m-auto"
      />
      <div class="bg-gray-100 p-4 mt-8">
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form class="space-y-6" @submit.prevent="handleSubmit(login)">
            <div class="mb-4">
              <label
                for="username"
                class="block text-sm font-medium text-gray-700"
              >
                Email <span>*</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                name="email"
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

            <div class="mb-4">
              <label
                for="password"
                class="block text-sm font-medium text-gray-700"
              >
                Password <span>*</span>
              </label>
              <ValidationProvider
                v-slot="{ errors }"
                name="パスワード"
                rules="required"
                vid="password"
              >
                <input
                  id="password"
                  v-model="inputs.password"
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
                />
                <span class="input-invalid-message text-tertiary text-sm">
                  {{ errors[0] }}
                </span>
              </ValidationProvider>
              <div class="mt-4">
                <button
                  class="
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
                    m-auto
                  "
                  type="submit"
                >
                  Login
                </button>
              </div>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'empty',
  auth: false,
  data() {
    return {
      inputs: {
        email: null,
        password: null,
      },
    }
  },
  methods: {
    async login() {
      try {
        await this.$auth.loginWith('local', {
          data: {
            email: this.inputs.email,
            plain_password: this.inputs.password,
          },
        })
        this.$router.push('/dashboard')
      } catch (e) {
        console.error(e)
        this.error = true
      }
    },
  },
}
</script>
