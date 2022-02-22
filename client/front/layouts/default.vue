<template>
  <div class="relative bg-main text-secondary">
    <Navbar />
    <div class="main">
      <nuxt />
    </div>
    <Footer />
    <Loading v-show="loading" />
    <GlobalLoading />
  </div>
</template>

<script>
import Navbar from '@/components/Navbar'
import Footer from '@/components/Footer'
import GlobalLoading from '@/components/molecules/loading/GlobalLoading'

export default {
  components: {
    Navbar,
    Footer,
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
