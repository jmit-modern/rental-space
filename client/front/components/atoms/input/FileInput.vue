<template>
  <div>
    <input type="file" class="hidden" ref="input" @change="handleChange" />
  </div>
</template>

<script>
export default {
  methods: {
    handleChange(event) {
      if (!event.target.files || event.target.files.length === 0) {
        this.$emit('close')
        return
      }
      const file = event.target.files[0]
      this.$emit('input', file)
    },
  },
}
</script>
