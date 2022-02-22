<template>
  <div>
    <client-only>
      <date-picker
        v-model="innerValue"
        :time-picker-options="timePickerOptions"
        :minute-step="minuteStep"
        :hour-options="hourOptions"
        format="HH:mm"
        type="time"
        :class="className"
        :placeholder="placeholder"
      ></date-picker>
    </client-only>
  </div>
</template>

<script>
import DatePicker from 'vue2-datepicker'
import 'vue2-datepicker/index.css'
import 'vue2-datepicker/locale/ja'

export default {
  name: 'FixedTimeList',
  components: { DatePicker },
  props: {
    value: {
      type: [String, Object],
      default: null,
    },
    format: {
      type: String,
      default: 'HH:mm',
    },
    className: {
      type: String,
      default: null,
    },
    timePickerOptions: {
      type: Object,
      default: null,
    },
    placeholder: {
      type: String,
      default: 'HH:mm',
    },
    hourOptions: {
      type: Array,
      default: null,
    },
    minuteStep: {
      type: Number,
      default: null,
    },
  },
  data() {
    return {
      time: null,
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
}
</script>
