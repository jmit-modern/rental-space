<template>
  <div class="pt-5 max-w-7xl mx-auto">
    <Breadcrumb :items="breadcrumbs" />
    <mypage-layout>
      <div class="px-4">
        <!-- Actions panel -->
        <div
          class="
            rounded-lg
            bg-gray-200
            overflow-hidden
            border
            divide-y divide-gray-200
            sm:divide-y-0 sm:grid sm:grid-cols-2 sm:gap-px
          "
        >
          <h2 id="quick-links-title" class="sr-only">Quick links</h2>
          <div
            v-for="(action, actionIdx) in actions"
            :key="action.name"
            :class="[
              actionIdx === 0
                ? 'rounded-tl-lg rounded-tr-lg sm:rounded-tr-none'
                : '',
              actionIdx === 1 ? 'sm:rounded-tr-lg' : '',
              actionIdx === actions.length - 2 ? 'sm:rounded-bl-lg' : '',
              actionIdx === actions.length - 1
                ? 'rounded-bl-lg rounded-br-lg sm:rounded-bl-none'
                : '',
              'relative group bg-white p-6 focus-within:ring-2 focus-within:ring-inset focus-within:ring-cyan-500',
            ]"
          >
            <div>
              <span
                :class="[
                  action.iconBackground,
                  action.iconForeground,
                  'rounded-lg inline-flex p-3 ring-4 ring-white',
                ]"
              >
                <component
                  :is="action.icon"
                  class="h-6 w-6"
                  aria-hidden="true"
                />
              </span>
            </div>
            <div class="mt-8">
              <h3 class="text-lg font-medium">
                <nuxt-link :to="action.href" class="focus:outline-none">
                  <!-- Extend touch target to entire panel -->
                  <span class="absolute inset-0" aria-hidden="true" />
                  {{ action.name }}
                </nuxt-link>
              </h3>
              <p class="mt-2 text-sm text-gray-500">
                {{ action.description }}
              </p>
            </div>
            <span
              class="
                pointer-events-none
                absolute
                top-6
                right-6
                text-gray-300
                group-hover:text-gray-400
              "
              aria-hidden="true"
            >
              <svg
                class="h-6 w-6"
                xmlns="http://www.w3.org/2000/svg"
                fill="currentColor"
                viewBox="0 0 24 24"
              >
                <path
                  d="M20 4h1a1 1 0 00-1-1v1zm-1 12a1 1 0 102 0h-2zM8 3a1 1 0 000 2V3zM3.293 19.293a1 1 0 101.414 1.414l-1.414-1.414zM19 4v12h2V4h-2zm1-1H8v2h12V3zm-.707.293l-16 16 1.414 1.414 16-16-1.414-1.414z"
                />
              </svg>
            </span>
          </div>
        </div>
      </div>
    </mypage-layout>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import MypageLayout from '@/components/organisms/templates/mypage/Layout'
import Breadcrumb from '@/components/organisms/Breadcrumb'

export default {
  components: {
    MypageLayout,
    Breadcrumb,
  },
  middleware: 'auth',
  data() {
    return {
      actions: [
        {
          name: this.$t('mypage.panel.mySpace'),
          href: this.localePath({ name: 'mypage-myspace' }),
          icon: 'outline-office-building-icon',
          iconForeground: 'text-gray-700',
          iconBackground: 'bg-gray-100',
          description: this.$t('mypage.panel.mySpaceDesc'),
        },
        {
          name: this.$t('mypage.panel.myReservations'),
          href: this.localePath({ name: 'mypage-space_reservation' }),
          icon: 'outline-calendar-icon',
          iconForeground: 'text-yellow-700',
          iconBackground: 'bg-yellow-100',
          description: this.$t('mypage.panel.myReservationsDesc'),
        },
        {
          name: this.$t('mypage.panel.mySkill'),
          href: this.localePath({ name: 'mypage-expert' }),
          icon: 'outline-lightning-bolt-icon',
          iconForeground: 'text-blue-700',
          iconBackground: 'bg-blue-100',
          description: this.$t('mypage.panel.mySkillDesc'),
        },
        {
          name: this.$t('mypage.panel.myEvent'),
          href: this.localePath({ name: 'mypage-myevent' }),
          icon: 'outline-status-online-icon',
          iconForeground: 'text-red-700',
          iconBackground: 'bg-red-100',
          description: this.$t('mypage.panel.myEventDesc'),
        },
        {
          name: this.$t('mypage.panel.profile'),
          href: this.localePath({ name: 'mypage-profile' }),
          icon: 'outline-identification-icon',
          iconForeground: 'text-green-700',
          iconBackground: 'bg-green-100',
          description: this.$t('mypage.panel.profileDesc'),
        },
        {
          name: this.$t('mypage.panel.setting'),
          href: this.localePath({ name: 'mypage-userinfo' }),
          icon: 'outline-user-icon',
          iconForeground: 'text-purple-700',
          iconBackground: 'bg-purple-100',
          description: this.$t('mypage.panel.settingDesc'),
        },
        {
          name: this.$t('mypage.panel.report'),
          href: this.localePath({ name: 'mypage-report' }),
          icon: 'outline-chart-square-bar-icon',
          iconForeground: 'text-pink-700',
          iconBackground: 'bg-pink-100',
          description: this.$t('mypage.panel.reportDesc'),
        },
        {
          name: this.$t('mypage.panel.paymentMethod'),
          href: this.localePath({ name: 'mypage-payment_method' }),
          icon: 'outline-credit-card-icon',
          iconForeground: 'text-indigo-700',
          iconBackground: 'bg-indigo-100',
          description: this.$t('mypage.panel.paymentMethodDesc'),
        },
      ],
    }
  },
  fetch() {},
  nuxtI18n: {
    paths: {
      en: '/mypage',
      jp: '/mypage',
      zh: '/mypage',
    },
  },
  computed: {
    ...mapGetters(['user', 'isAuthenticated']),
    breadcrumbs() {
      const items = [
        {
          id: 1,
          name: 'ホーム',
          url: this.localeRoute({ name: 'index' }),
        },
        {
          id: 2,
          name: 'マイページ',
          url: this.localeRoute({ name: 'mypage' }),
        },
      ]
      return items
    },
  },
}
</script>
