<template>
  <div class="calendar-header">
    <div class="header-left">
      <slot name="header-left"> </slot>
    </div>
    <div class="header-center">
      <span v-if="!isPrevMonthDisabled" class="prev-month" @click.stop="goPrev">
        &lt;
      </span>

      <span class="title">
        {{ year }} <span v-if="yearSuffix">{{ yearSuffix }}</span> {{ month }}
      </span>

      <span v-if="!isNextMonthDisabled" class="next-month" @click.stop="goNext">
        &gt;
      </span>
    </div>
    <div class="header-right">
      <slot name="header-right"> </slot>
    </div>
  </div>
</template>

<script>
import calendarJs from '@/components/atoms/calendar/utils/calendar-service'
import i18nMixin from './mixins/i18n'

export default {
  name: 'CalendarHeader',
  mixins: [i18nMixin],
  props: {
    disable: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      monthStart: null,
    }
  },
  computed: {
    year() {
      return this.monthStart.getFullYear()
    },
    month() {
      return this.printMonth(this.monthStart.getMonth())
    },
    hasDisabledPeriod() {
      return !Object.keys(this.disable).length
    },
    isPrevMonthDisabled() {
      if (this.hasDisabledPeriod || !('to' in this.disable)) {
        return false
      }

      return (
        this.disable.to.getMonth() >= this.monthStart.getMonth() &&
        this.disable.to.getFullYear() >= this.monthStart.getFullYear()
      )
    },
    isNextMonthDisabled() {
      if (this.hasDisabledPeriod || !('from' in this.disable)) {
        return false
      }

      return (
        this.disable.from.getMonth() <= this.monthStart.getMonth() &&
        this.disable.from.getFullYear() <= this.monthStart.getFullYear()
      )
    },
  },
  watch: {
    monthStart(monthStart) {
      const monthEnd = calendarJs.lastDateOfMonth(monthStart)

      this.$nuxt.$emit('month-changed', monthStart, monthEnd)
    },
  },
  created() {
    this.monthStart = calendarJs.firstDateOfMonth()
    this.$nuxt.$on('go-to-date', (date) => this.goToDate(date))
  },
  methods: {
    goPrev() {
      if (!this.previousMonthDisabled) {
        this.monthStart = calendarJs.shiftMonth(this.monthStart, 1)
      }
    },
    goNext() {
      if (!this.nextMonthDisabled) {
        this.monthStart = calendarJs.shiftMonth(this.monthStart, -1)
      }
    },
    goToDate(date) {
      this.monthStart = calendarJs.firstDateOfMonth(date)
    },
  },
}
</script>

<style lang="scss">
.calendar-header {
  align-items: center;
  font-weight: bold;
  font-size: 1.5rem;
}
.header-left,
.header-right {
  flex: 1;
}
.header-center {
  flex: 3;
  text-align: center;
}
.title {
  margin: 0 5px;
}
.prev-month,
.next-month {
  cursor: pointer;
}
</style>
