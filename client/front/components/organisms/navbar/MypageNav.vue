<template>
  <menu-drop-down>
    <template #header>
      <div class="flex items-center">
        <span class="mr-1">{{ $t('navbar.mypage') }}</span>
        <solid-chevron-down-icon class="w-5 h-5" />
      </div>
    </template>
    <template #submenu>
      <nuxt-link
        to="/mypage"
        class="
          transition-colors
          duration-200
          block
          px-4
          py-2
          text-normal text-gray-900
          rounded
          text-primary
          hover:bg-orange hover:text-white
          cursor-pointer
        "
      >
        {{ $t('mypage.dashboard') }}
      </nuxt-link>
      <div
        class="
          transition-colors
          duration-200
          block
          px-4
          py-2
          text-normal text-gray-900
          rounded
          hover:bg-orange hover:text-white
          text-primary
          cursor-pointer
        "
        @click.prevent="handleLogout"
      >
        {{ $t('logout') }}
      </div>
    </template>
  </menu-drop-down>
</template>

<script>
import { mapGetters } from 'vuex'
import MenuDropDown from '@/components/molecules/MenuDropDown'
export default {
  components: {
    MenuDropDown,
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'user']),
  },
  methods: {
    async handleLogout() {
      await this.$auth.logout()
    },
  },
}
</script>
