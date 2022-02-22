<template>
  <div :class="wrapperClass">
    <div
      v-for="(option, index) in options"
      :key="index"
      :class="['flex items-center', itemClass]"
    >
      <input
        :id="`${inputName}${index}`"
        v-model="innerValue"
        type="radio"
        :value="option.code"
        :name="inputName"
        class="hidden"
      />
      <label
        :for="`${inputName}${index}`"
        class="flex items-center cursor-pointer"
      >
        <span
          class="w-4 h-4 inline-block mr-1 rounded-full border border-gray-300"
        ></span>
        <span class="ml-1">{{ option.name }}</span></label
      >
    </div>
  </div>
</template>

<script>
import formFieldMixin from '@/components/molecules/form/mixins/formFieldMixin'

export default {
  name: 'RadioBox',
  components: {},
  mixins: [formFieldMixin],
  props: {
    value: {
      type: [String, Number, Boolean],
      default: null,
    },
    options: {
      type: Array,
      default: () => [],
    },
    wrapperClass: {
      type: String,
      default: null,
    },
    itemClass: {
      type: String,
      default: null,
    },
    inputClass: {
      type: String,
      default: null,
    },
    inputName: {
      type: String,
      required: true,
    },
  },
  computed: {
    innerValue: {
      set(value) {
        if (value !== this.value) {
          this.$emit('input', value)
          this.$emit('change', value)
        }
      },
      get() {
        if (typeof this.value === 'boolean') return Number(this.value)
        return this.value
      },
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
