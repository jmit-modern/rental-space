<template>
  <span
    class="
      inline-flex
      rounded-full
      items-center
      py-0.5
      pl-2.5
      pr-1
      text-sm
      font-medium
      bg-indigo-100
      text-indigo-700
    "
  >
    {{ value }}
    <button
      class="
        flex-shrink-0
        ml-0.5
        h-4
        w-4
        rounded-full
        inline-flex
        items-center
        justify-center
        text-indigo-400
        hover:bg-indigo-200 hover:text-indigo-500
        focus:outline-none focus:bg-indigo-500 focus:text-white
      "
      @click.prevent="handleClose"
    >
      <span class="sr-only">Remove large option</span>
      <svg class="h-2 w-2" stroke="currentColor" fill="none" viewBox="0 0 8 8">
        <path stroke-linecap="round" stroke-width="1.5" d="M1 1l6 6m0-6L1 7" />
      </svg>
    </button>
  </span>
</template>

<script>
export default {
  props: {
    value: {
      type: String,
      default: null,
    },
  },
  methods: {
    handleClose() {
      this.$emit('close', this.value)
    },
  },
}
</script>
