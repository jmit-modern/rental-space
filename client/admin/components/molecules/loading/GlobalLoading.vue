<template>
  <div><Loading v-show="loading" /></div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
    }
  },
  mounted() {
    this.$nuxt.$on('loading', (status) => (this.loading = status))
  },
}
</script>

<style lang="scss" scoped>
.loading-enter-active {
  transition: all 0.6s;
}
.loading-leave-active {
  transition: all 0.6s;
}
.loading-enter,
.loading-leave-to {
  opacity: 0;
}
</style>
