<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <h2 class="mt-6 text-center text-3xl font-extrabold text-primary">
        {{ $t('loginPage.owner') }}
      </h2>
    </div>
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-lg">
      <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
        <div v-if="error" class="mb-4 text-tertiary text-sm">
          ログインに失敗しました。入力を確認してください。
        </div>
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form class="space-y-6" @submit.prevent="handleSubmit(login)">
            <LoginForm v-model="inputs" />
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
                {{ $t('login') }}
              </button>
            </div>
          </form>
        </ValidationObserver>

        <SocialLogin />
      </div>
    </div>
  </div>
</template>

<script>
import LoginForm from '@/components/organisms/templates/form/LoginForm'
import SocialLogin from '@/components/organisms/templates/form/SocialLogin'

export default {
  components: { LoginForm, SocialLogin },
  middleware: 'guest',
  data() {
    return {
      inputs: {
        email: '',
        password: '',
      },
      error: false,
    }
  },
  async fetch() {
    if (this.$route.query.token && this.$route.query.user) {
      const params = {
        token: this.$route.query.token,
      }
      await this.$api.update(
        `users/${this.$route.query.user}/confirm_user`,
        params
      )
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

        this.$router.push(this.localeRoute({ name: 'mypage' }))
      } catch (e) {
        console.error(e)
        this.error = true
      }
    },
  },
}
</script>
