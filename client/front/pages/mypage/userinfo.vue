<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />

    <mypage-layout>
      <div class="px-4 py-5">
        <ValidationObserver
          v-slot="{ handleSubmit, invalid }"
          ref="emailFormValidator"
        >
          <form @submit.prevent="handleSubmit(emailSubmit)">
            <div class="space-y-6 mb-6">
              <div class="">
                <label
                  for="username"
                  class="inline-block text-sm font-medium text-gray-700"
                  >ユーザー名</label
                >
                <p class="mt-3">{{ inputs.username }}</p>
              </div>
              <div>
                <label
                  for="email"
                  class="inline-block text-sm font-medium text-gray-700"
                  >メールアドレス</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="メールアドレス"
                  rules="required|email"
                  vid="email"
                >
                  <input
                    id="email"
                    v-model="inputs.email"
                    type="text"
                    name="email"
                    class="
                      shadow-sm
                      focus:ring-orange focus:border-orange
                      block
                      sm:text-sm
                      border-gray-300
                      rounded-md
                      mt-1
                    "
                    placeholder="you@example.com"
                  /><span class="input-invalid-message text-tertiary text-sm">
                    {{ errors[0] }}
                  </span></ValidationProvider
                >
              </div>

              <div>
                <button
                  :class="[
                    'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
                    invalid
                      ? 'cursor-not-allowed opacity-40'
                      : 'hover:opacity-80 cursor-pointer',
                  ]"
                  :disabled="invalid"
                  type="submit"
                >
                  メールアドレスを更新する
                </button>
              </div>
            </div>
          </form>
        </ValidationObserver>

        <divider />
        <ValidationObserver
          v-slot="{ handleSubmit, invalid }"
          ref="passwordFormValidator"
        >
          <form @submit.prevent="handleSubmit(passwordSubmit)">
            <div class="space-y-6 pt-6">
              <div>
                <label
                  for="currentPassword"
                  class="inline-block text-sm font-medium text-gray-700"
                  >現在のパスワード</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="現在のパスワード"
                  rules="required"
                  vid="current_password"
                >
                  <input
                    id="currentPassword"
                    v-model="currentPassword"
                    type="password"
                    name="currentPassword"
                    class="
                      shadow-sm
                      focus:ring-orange focus:border-orange
                      block
                      sm:text-sm
                      border-gray-300
                      rounded-md
                      mt-1
                    "
                  />
                  <span class="input-invalid-message text-tertiary text-sm">
                    {{ errors[0] }}
                  </span></ValidationProvider
                >
              </div>

              <div>
                <label
                  for="newPassword"
                  class="inline-block text-sm font-medium text-gray-700"
                  >パスワード</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="パスワード"
                  rules="required|min:8|max:32|atLeastOneUppercase|atLeastOneLowercase"
                  vid="new_password"
                >
                  <input
                    id="newPassword"
                    v-model="newPassword"
                    type="password"
                    name="newPassword"
                    class="
                      shadow-sm
                      focus:ring-orange focus:border-orange
                      block
                      sm:text-sm
                      border-gray-300
                      rounded-md
                      mt-1
                    "
                  />
                  <p class="mt-2 text-sm text-gray-500">
                    ※半角英数字8～32文字、記号利用可能
                  </p>
                  <span class="input-invalid-message text-tertiary text-sm">
                    {{ errors[0] }}
                  </span>
                </ValidationProvider>
              </div>
              <div>
                <label
                  for="confirmPassword"
                  class="inline-block text-sm font-medium text-gray-700"
                  >パスワード（確認）</label
                >
                <ValidationProvider
                  v-slot="{ errors }"
                  name="パスワード"
                  rules="required|confirmed:new_password"
                  vid="confirm_password"
                >
                  <input
                    id="confirmPassword"
                    v-model="confirmPassword"
                    type="password"
                    name="confirmPassword"
                    class="
                      shadow-sm
                      focus:ring-orange focus:border-orange
                      block
                      sm:text-sm
                      border-gray-300
                      rounded-md
                    "
                  />
                  <span class="input-invalid-message text-tertiary text-sm">
                    {{ errors[0] }}
                  </span>
                </ValidationProvider>
              </div>
              <div>
                <button
                  :class="[
                    'items-center px-5 py-1.5 border border-transparent shadow-sm text-base font-medium rounded-md text-main bg-orange focus:outline-none',
                    invalid
                      ? 'cursor-not-allowed opacity-40'
                      : 'hover:opacity-80 cursor-pointer',
                  ]"
                  :disabled="invalid"
                  type="submit"
                >
                  パスワードを更新する
                </button>
              </div>
            </div>
          </form>
        </ValidationObserver>
      </div>
    </mypage-layout>
    <Notification
      v-if="showPassAlert"
      :title="$t('form.updateNotification')"
      @hide="showPassAlert = false"
    />
    <Notification
      v-if="showEmailAlert"
      :title="$t('form.updateNotification')"
      @hide="showEmailAlert = false"
    />
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import Divider from '@/components/atoms/Divider'
import Breadcrumb from '@/components/organisms/Breadcrumb'
import Notification from '@/components/molecules/overlay/Notification'

export default {
  components: {
    MypageLayout,
    Divider,
    Breadcrumb,
    Notification,
  },
  middleware: 'auth',
  data() {
    return {
      inputs: {},
      newPassword: null,
      currentPassword: null,
      confirmPassword: null,
      showPassAlert: false,
      showEmailAlert: false,
    }
  },
  fetch() {
    this.inputs = { ...this.user }
  },
  nuxtI18n: {
    paths: {
      en: '/mypage/userinfo',
      jp: '/mypage/userinfo',
      zh: '/mypage/userinfo',
    },
  },
  computed: {
    ...mapGetters(['user', 'isAuthenticated']),
    userId() {
      return this.user.id
    },
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: 'ホーム',
          url: { name: 'index___jp', query: {} },
        },
        {
          id: 2,
          name: 'マイページ',
          url: {
            name: 'mypage___jp',
            query: {},
          },
        },
        {
          id: 3,
          name: 'ユーザー情報',
          url: {
            name: 'mypage-userinfo___jp',
            query: {},
          },
        },
      ]
      return items
    },
  },
  methods: {
    async emailSubmit() {
      try {
        if (confirm('Are you sure to change the email address?')) {
          const params = {
            email: this.inputs.email,
          }
          await this.$api.update(`users/${this.userId}/update_email`, params)

          await this.$auth.logout()
        }
      } catch (error) {
        this.$refs.emailFormValidator.setErrors(error.data.errors)
      }
    },
    async passwordSubmit() {
      try {
        const params = {
          currentPassword: this.currentPassword,
          newPassword: this.newPassword,
        }
        await this.$api.update(`users/${this.userId}/update_password`, params)
        this.showPassAlert = true
        setTimeout(() => (this.showPassAlert = false), 2000)
      } catch (error) {
        this.$refs.passwordFormValidator.setErrors(error.response.data.errors)
      }
    },
  },
}
</script>
