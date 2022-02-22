<template>
  <header>
    <div class="relative">
      <div
        class="
          flex
          justify-between
          items-center
          mx-auto
          px-4
          sm:px-6
          md:justify-start md:space-x-10
          lg:px-8
          shadow
        "
      >
        <div class="flex justify-start lg:flex-shrink">
          <a href="/">
            <span class="sr-only">Workflow</span>
            <img
              class="h-8 w-auto sm:h-10"
              src="~/assets/image/logo-transparent.png"
              alt=""
            />
          </a>
        </div>
        <div
          class="hidden md:flex items-center justify-end lg:w-0 lg:flex-grow"
        >
          <LoginNavItem v-if="!isloggedIn" />
          <RegisterNavItem v-if="!isloggedIn" />

          <template v-if="!isloggedIn">
            <nuxt-link
              :to="localeRoute({ name: 'owner-login' })"
              class="
                text-base
                font-medium
                py-4
                px-8
                hover:bg-light hover:text-current
                text-primary
              "
            >
              {{ $t('postSpace') }}
            </nuxt-link>
          </template>
          <template v-else>
            <nuxt-link
              v-if="isSpaceOwner"
              :to="localeRoute({ name: 'mypage-myspace-new' })"
              class="
                text-base
                font-medium
                py-4
                px-8
                hover:bg-light hover:text-current
                text-primary
              "
            >
              {{ $t('postSpace') }}
            </nuxt-link>
          </template>

          <nuxt-link
            :to="localeRoute({ name: 'mypage-myevent-new' })"
            class="
              text-base
              font-medium
              py-4
              px-8
              hover:bg-light hover:text-current
              text-primary
            "
          >
            {{ $t('postEvent') }}
          </nuxt-link>

          <nuxt-link
            :to="localeRoute({ name: 'contact' })"
            class="
              text-base
              font-medium
              py-4
              px-8
              hover:bg-light hover:text-current
              text-primary
            "
          >
            {{ $t('contact') }}
          </nuxt-link>
          <MypageNavItem v-if="isloggedIn" />
          <lang-switcher />
        </div>
      </div>
    </div>
  </header>
</template>

<script>
import { mapGetters } from 'vuex'
import LoginNavItem from '@/components/organisms/navbar/LoginNav'
import RegisterNavItem from '@/components/organisms/navbar/RegisterNav'
import MypageNavItem from '@/components/organisms/navbar/MypageNav'
import LangSwitcher from './organisms/LangSwitcher'

export default {
  components: { LangSwitcher, LoginNavItem, RegisterNavItem, MypageNavItem },
  data() {
    return {
      state: false,
    }
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'user', 'isSpaceOwner']),
    isloggedIn() {
      return this.isAuthenticated
    },
  },
  methods: {
    async handleLogout() {
      await this.$auth.logout()
    },
    close() {
      this.state = false
    },
  },
}
</script>
