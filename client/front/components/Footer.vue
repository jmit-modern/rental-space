<template>
  <footer>
    <div
      class="max-w-7xl mx-auto pt-20 pb-12 px-4 overflow-hidden sm:px-6 lg:px-8"
    >
      <div class="mb-14">
        <img
          src="@/assets/image/logo-transparent.png"
          class="mx-auto"
          alt="Footer Logo"
        />
      </div>
      <div class="mb-14 text-center">
        <template v-if="!isloggedIn">
          <nuxt-link
            :to="localeRoute({ name: 'owner-login' })"
            class="
              inline-flex
              items-center
              px-6
              py-3
              border border-transparent
              shadow-sm
              text-base
              font-bold font-medium
              rounded-md
              text-main
              bg-orange
              focus:outline-none
              hover:opacity-80
              cursor-pointer
            "
          >
            {{ $t('footer.postSpace') }}
            <outline-chevron-right-icon class="h-5 w-5 ml-3" />
          </nuxt-link>
        </template>
        <template v-else>
          <nuxt-link
            v-if="isSpaceOwner"
            :to="localeRoute({ name: 'mypage-myspace-new' })"
            class="
              inline-flex
              items-center
              px-6
              py-3
              border border-transparent
              shadow-sm
              text-base
              font-bold font-medium
              rounded-md
              text-main
              bg-orange
              focus:outline-none
              hover:opacity-80
              cursor-pointer
            "
          >
            {{ $t('footer.postSpace') }}
            <outline-chevron-right-icon class="h-5 w-5 ml-3" />
          </nuxt-link>
        </template>
      </div>

      <nav class="-mx-5 -my-2 grid grid-cols-5" aria-label="Footer">
        <div
          v-for="item in navigation"
          :key="item.name"
          class="px-5 py-2 text-center"
        >
          <a
            :href="item.href"
            class="text-base hover:underline"
            :target="item.target"
          >
            {{ $t(`footer.navigation.${item.name}`) }}
          </a>
        </div>
      </nav>
      <div class="mt-8 flex justify-center space-x-6">
        <a href="#" class="text-gray-400 hover:text-gray-500"> </a>
      </div>
      <p class="mt-8 text-center text-sm">
        &copy; 2021
        <a
          href="https://www.enquu.org/company"
          target="_blank"
          class="text-primary underline"
          >Enquu inc.</a
        >
        All rights reserved.
      </p>
    </div>
  </footer>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  data() {
    return {
      navigation: [
        {
          name: 'privacyPolicy',
          href: this.localePath({ name: 'privacy-policy' }),
          target: '',
        },
        {
          name: 'cancelPolicy',
          href: this.localePath({ name: 'cancel-policy' }),
          target: '',
        },
        {
          name: 'termsAndConditions',
          href: this.localePath({ name: 'terms-condition' }),
          target: '',
        },
        {
          name: 'commercialLaw',
          href: this.localePath({ name: 'commercial-law' }),
          target: '',
        },
        {
          name: 'companyInfo',
          href: 'https://www.enquu.org/company',
          target: '_blank',
        },
        {
          name: 'contact',
          href: this.localePath({ name: 'contact' }),
          target: '',
        },
        {
          name: 'userGuide',
          href: this.localePath({ name: 'user-guide' }),
          target: '',
        },
        {
          name: 'ownerGuide',
          href: this.localePath({ name: 'owner-guide' }),
          target: '',
        },
        {
          name: 'expertGuide',
          href: this.localePath({ name: 'expert-guide' }),
          target: '',
        },
      ],
    }
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'user', 'isSpaceOwner']),
    isloggedIn() {
      return this.isAuthenticated
    },
  },
}
</script>
