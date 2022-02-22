<template>
  <div :class="['datepicker-wrapper', ...inputFieldClass.split(' ')]">
    <label v-if="label" :for="id">{{ label }}</label>
    <Datepicker
      :id="id"
      v-model="inputDate"
      :class-name="inputClass"
      :monday-first="true"
      :clearable="clearable"
      :disabled="disabled"
      :placeholder="$t('form.datePicker.placeholder')"
    ></Datepicker>
  </div>
</template>

<script>
import Datepicker from '@/components/atoms/input/Datepicker'
import formFieldMixin from '@/components/molecules/form/mixins/formFieldMixin'

export default {
  components: {
    Datepicker,
  },
  mixins: [formFieldMixin],
  props: {
    value: {
      type: String,
      default: null,
    },
    clearable: {
      type: Boolean,
      default: true,
    },
    inputFieldClass: {
      type: String,
      default: 'input-field inline',
    },
    inputClass: {
      type: String,
      default: null,
    },
    wrapperTag: {
      type: String,
      default: 'span',
    },
  },
  computed: {
    inputDate: {
      get() {
        return this.value
          ? this.$dayjs(this.value).format('YYYY-MM-DD HH:mm:ss')
          : null
      },
      set(newValue) {
        this.$emit(
          'input',
          newValue ? this.$dayjs(newValue).format('YYYY-MM-DD HH:mm:ss') : null
        )
      },
    },
  },
}
</script>
