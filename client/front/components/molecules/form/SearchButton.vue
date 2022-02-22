<template>
  <div>
    <button
      type="submit"
      class="
        ml-3
        inline-flex
        justify-center
        py-2
        px-4
        border border-transparent
        shadow-sm
        text-sm
        font-medium
        rounded-md
        text-white
        hover:bg-current
        outline-none
        focus:outline-none
        border-current
      "
    >
      <outline-search-icon class="w-6 h-6" stroke="#000" />
    </button>
  </div>
</template>

<script>
export default {
  components: {},
}
</script>

<style lang="scss" scoped>
::v-deep button:hover svg {
  stroke: #fff;
}
</style>
