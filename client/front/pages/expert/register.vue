<template>
  <div class="flex flex-col justify-center py-12 sm:px-6 lg:px-8">
    <div class="sm:mx-auto sm:w-full sm:max-w-md">
      <h2 class="mt-6 text-center text-3xl font-extrabold text-primary">
        {{ $t('registerpage.expert') }}
      </h2>
    </div>
    <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-lg">
      <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
        <ValidationObserver v-slot="{ handleSubmit }" ref="formValidator">
          <form class="space-y-6" @submit.prevent="handleSubmit(register)">
            <RegisterForm v-model="inputs" />
            <div>
              <button
                :class="[
                  'w-full items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
                ]"
                type="submit"
              >
                {{ $t('register') }}
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
import { mapGetters } from 'vuex'
import RegisterForm from '@/components/organisms/templates/form/RegisterForm'
import SocialLogin from '@/components/organisms/templates/form/SocialLogin'

export default {
  components: { RegisterForm, SocialLogin },
  middleware: 'guest',
  async fetch() {
    await Promise.all([this.$store.dispatch('user/fetchUserTypes')])
  },
  data() {
    return {
      inputs: {
        firstName: null,
        lastName: null,
        email: null,
        password: null,
        passwordConfirm: null,
      },
      error: null,
    }
  },
  computed: {
    ...mapGetters({
      userTypes: 'user/userTypes',
    }),
  },
  methods: {
    async register() {
      try {
        await this.$axios.post('auth/register', {
          first_name: this.inputs.firstName,
          last_name: this.inputs.lastName,
          email: this.inputs.email,
          plain_password: this.inputs.password,
          user_type: this.userTypes.expert,
        })
        this.$router.push(this.localeRoute({ name: 'register-complete' }))
      } catch (e) {
        this.$refs.formValidator.setErrors(e.response.data.errors)
      }
    },
  },
}
</script>
