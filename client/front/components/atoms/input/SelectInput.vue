<template>
  <div :class="inputFieldClass">
    <label v-if="label" :for="id">{{ label }}</label>
    <select
      :id="id"
      v-model="innerValue"
      :class="[inputClass].join(' ')"
      :disabled="disabled"
    >
      <option v-if="useUnselectOption" :value="unselectOption.code">
        {{ unselectOption.name }}
      </option>
      <option
        v-for="option in options"
        :key="option.code"
        :value="option.code"
        :disabled="option.disabled || false"
      >
        {{ option.name }}
      </option>
    </select>
  </div>
</template>

<script>
import formFieldMixin from '@/components/molecules/form/mixins/formFieldMixin'

export default {
  components: {},
  mixins: [formFieldMixin],
  props: {
    value: {
      type: [Number, String],
      default: null,
    },
    id: {
      type: String,
      default: null,
    },
    options: {
      type: Array,
      default: () => [],
    },
    inputClass: {
      type: String,
      default: 'browser-default',
    },
    unselectOption: {
      type: Object,
      default: () => ({ name: '選択してください', code: null }),
    },
    useUnselectOption: {
      type: Boolean,
      default: true,
    },
    allowSelectUnselectOption: {
      type: Boolean,
      default: false,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
  },
}
</script>
