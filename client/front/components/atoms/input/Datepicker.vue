<template>
  <div>
    <client-only>
      <date-picker
        v-model="innerValue"
        :placeholder="placeholder"
        :lang="lang"
        :class="className"
        :disabled-date="disabledRange"
        :clearable="clearable"
      ></date-picker>
    </client-only>
  </div>
</template>

<script>
import DatePicker from 'vue2-datepicker'
import 'vue2-datepicker/index.css'
import 'vue2-datepicker/locale/ja'

export default {
  components: { DatePicker },
  props: {
    id: {
      type: String,
      default: null,
    },
    value: {
      type: String,
      default: null,
    },
    clearable: {
      type: Boolean,
      default: true,
    },
    className: {
      type: String,
      default: null,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
    placeholder: {
      type: String,
      default: null,
    },
    disabledBefore: {
      type: Date,
      default: null,
    },
  },
  data() {
    return {
      lang: 'ja',
    }
  },
  computed: {
    innerValue: {
      get() {
        return this.value ? this.$dayjs(this.value).toDate() : null
      },
      set(newValue) {
        this.$emit('input', newValue ? this.$dayjs(newValue) : null)
      },
    },
  },
  methods: {
    disabledRange: (date) => {
      return date < new Date()
    },
  },
}
</script>

<style scoped lang="scss">
::v-deep input[name='date'] {
  background: rgb(239, 240, 243);
  color: rgb(42, 42, 42);
}
::v-deep input[name='date']::placeholder {
  color: rgb(42, 42, 42);
}
::v-deep input[name='date']:hover {
  border-color: rgb(209, 213, 219);
}
::v-deep input[name='date']:focus {
  border-color: #ff8e3c;
  box-shadow: 0 0 0 1px #ff8e3c;
}
</style>
