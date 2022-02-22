<template>
  <validation-provider
    v-slot="{ errors, validated }"
    ref="provider"
    :rules="rules"
    :name="validateName"
    :vid="computedVid"
    :class="wrapperClass"
    :tag="wrapperTag"
  >
    <label
      v-for="(option, index) in options"
      :key="index"
      class="check-box-list-filed"
      :class="inputFieldClass"
    >
      <input
        :name="`${name}.${index}`"
        type="checkbox"
        :class="[
          getValidateCss(errors, validated),
          'focus:ring-orange h-4 w-4 text-orange border-gray-300 rounded',
        ]"
        :disabled="disabled"
        :checked="dict[option.code]"
        @input="($event) => handleInput($event, option.code)"
      />
      <span :class="labelClass">{{ option.name }}</span>
    </label>
    <span v-for="(error, key) in errors" :key="key">
      {{ error }}
    </span>
  </validation-provider>
</template>

<script>
import formFieldMixin from '@/components/molecules/form/mixins/formFieldMixin'
import { createDict } from '@/utils/dataStructure'

export default {
  name: 'CheckboxList',
  components: {},
  mixins: [formFieldMixin],
  props: {
    value: {
      type: Array,
      default: () => [],
    },
    options: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    dict() {
      return createDict(this.value)
    },
  },
  methods: {
    handleInput(event, code) {
      const selectedValues = [...this.value]

      const index = selectedValues.indexOf(code)

      if (event.target.checked) {
        if (index === -1) {
          selectedValues.push(code)
        }
      } else if (index > -1) {
        selectedValues.splice(index, 1)
      }

      this.$emit('input', selectedValues)
    },
  },
}
</script>
