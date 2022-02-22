<template>
  <menu-drop-down>
    <template #header>
      {{ $t('login') }}
    </template>
    <template #submenu>
      <nuxt-link
        to="/user/login"
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
        {{ $t('navbar.user') }}
      </nuxt-link>
      <nuxt-link
        to="/owner/login"
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
      >
        {{ $t('navbar.owner') }}
      </nuxt-link>
      <nuxt-link
        to="/expert/login"
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
      >
        {{ $t('navbar.expert') }}
      </nuxt-link>
    </template>
  </menu-drop-down>
</template>

<script>
import MenuDropDown from '@/components/molecules/MenuDropDown'
export default {
  components: {
    MenuDropDown,
  },
}
</script>
