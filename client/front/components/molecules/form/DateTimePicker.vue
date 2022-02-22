<template>
  <div class="flex items-center space-x-4">
    <Datepicker v-model="innerValue" :input-class="['datepicker'].join(' ')" />
    <TimePicker
      v-model="innerValue"
      format="HH:mm"
      :time-picker-options="{ start: '00:00', step: '01:00', end: '23:00' }"
      placeholder="時間を選択してください。"
    />
  </div>
</template>

<script>
import Datepicker from '@/components/molecules/form/Datepicker'
import TimePicker from '@/components/atoms/input/TimePicker'

export default {
  components: {
    Datepicker,
    TimePicker,
  },
  props: {
    value: {
      type: String,
      default: null,
    },
  },
  computed: {
    innerValue: {
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
