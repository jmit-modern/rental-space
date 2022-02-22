<template>
  <div>
    <button type="button" :class="inputClass" @click="handleClick">
      <slot name="button"></slot>
    </button>
    <input type="file" class="hidden" ref="input" @change="handleChange" />
  </div>
</template>

<script>
export default {
  props: {
    inputClass: {
      type: String,
      default:
        'leading-4 focus:outline-none bg-white py-2 px-3 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50',
    },
  },
  methods: {
    handleClick() {
      this.$refs.input.click()
    },
    handleChange(event) {
      if (!event.target.files || event.target.files.length === 0) {
        return
      }
      const file = event.target.files[0]
      this.$emit('input', file)
      this.$emit('change', file)
    },
  },
}
</script>
