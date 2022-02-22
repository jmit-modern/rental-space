<template>
  <div class="relative bg-main text-secondary h-screen flex overflow-hidden">
    <!-- Static sidebar for desktop -->
    <Sidebar />

    <div class="flex flex-col w-0 flex-1 overflow-hidden">
      <div class="flex justify-end px-8 z-10 shadow">
        <LogoutNav />
      </div>
      <main
        class="
          flex-1
          relative
          overflow-y-auto
          focus:outline-none
          py-6
          px-4
          sm:px-6
          md:px-8
        "
      >
        <Nuxt />
      </main>
    </div>
    <Loading v-show="loading" />
    <GlobalLoading />
  </div>
</template>

<script>
import Sidebar from '@/components/Sidebar'
import LogoutNav from '@/components/organisms/navbar/LogoutNav'
import GlobalLoading from '@/components/molecules/loading/GlobalLoading'

export default {
  components: {
    Sidebar,
    LogoutNav,
    GlobalLoading,
  },
  data() {
    return {
      loading: false,
    }
  },
  beforeCreate() {
    this.loading = true
  },
  mounted() {
    this.loading = false
  },
}
</script>
