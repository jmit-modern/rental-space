<template>
  <div :class="['flex items-center', className]">
    <input
      :id="id"
      type="radio"
      :name="name"
      class="hidden"
      :value="value"
      :checked="checked"
      @change="handleChange"
    />
    <label :for="id" class="flex items-center cursor-pointer">
      <span
        class="w-4 h-4 inline-block mr-1 rounded-full border border-gray-300"
      ></span>
      <span v-if="label" class="ml-1">{{ label }}</span></label
    >
  </div>
</template>

<script>
export default {
  props: {
    className: {
      type: String,
      default: '',
    },
    label: {
      type: String,
      default: null,
    },
    id: {
      type: String,
      required: true,
    },
    value: {
      type: [String, Number],
      required: true,
    },
    name: {
      type: String,
      required: true,
    },
    checked: {
      type: Boolean,
      default: false,
    },
  },
  methods: {
    handleChange(event) {
      this.$emit('change', event.target.value)
    },
  },
}
</script>

<style lang="scss">
input[type='radio'] + label span:first-child {
  background: #fff;
}
input[type='radio']:checked + label span:first-child {
  background-color: #ff8e3c; //bg-blue
  box-shadow: 0 0 0 2px white inset;
}
</style>
