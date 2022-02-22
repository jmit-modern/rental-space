<template>
  <menu-drop-down>
    <template #header>
      <div class="flex items-center">
        <img
          src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
          alt=""
          class="h6 w-6"
        />
        <solid-chevron-down-icon class="w-5 h-5" />
      </div>
    </template>
    <template #submenu>
      <nuxt-link
        to="/"
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
        Dashboard
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
        Logout
      </div>
    </template>
  </menu-drop-down>
</template>

<script>
import { mapGetters } from "vuex";
import MenuDropDown from "@/components/molecules/MenuDropDown";
export default {
  components: {
    MenuDropDown
  },
  computed: {
    ...mapGetters(["isAuthenticated", "user"])
  },
  methods: {
    async handleLogout() {
      await this.$auth.logout();
    }
  }
};
</script>
