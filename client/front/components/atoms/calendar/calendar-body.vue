<template>
  <div class="calendar-body">
    <div class="days-header">
      <div v-for="day in 7" :key="day" class="day-label">
        {{ printDay(day - 1) }}
      </div>
    </div>

    <div class="days-body">
      <div v-for="(week, key) in calendar" :key="key" class="week-row">
        <div
          v-for="(day, index) in week"
          :key="index"
          class="week-day"
          :class="dayClasses(day)"
          @click.stop="dayClicked(day)"
        >
          <div class="day-number">
            {{ day.monthDay }}
          </div>

          <events-box
            v-if="(dayEvents = getEventsForDay(day.date))"
            :events="dayEvents"
            :display-show-more-count="displayShowMoreCount"
          ></events-box>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import eventsBox from '@/components/atoms/calendar/events-box'
import calendarJs from '@/components/atoms/calendar/utils/calendar-service'
import i18nMixin from '@/components/atoms/calendar/mixins/i18n'

export default {
  name: 'CalendarBody',
  components: {
    'events-box': eventsBox,
  },
  mixins: [i18nMixin],
  props: {
    events: {
      type: Array,
      required: true,
    },
    disable: {
      type: Object,
      required: true,
    },
    highlight: {
      type: Object,
      required: true,
    },
    displayShowMoreCount: {
      type: Boolean,
      default: false,
    },
  },
  data() {
    return {
      monthStart: null,
      disabledDays: this.disable,
      highlightedDays: this.highlight,
    }
  },
  computed: {
    firstDay() {
      return this.$nuxt.firstDay
    },
    showLimit() {
      return this.$nuxt.showLimit
    },
    calendar() {
      return this.monthStart
        ? calendarJs.buildCalendar(this.monthStart, this.firstDay)
        : []
    },
  },
  watch: {
    disable(days) {
      this.disabledDays = days
    },
    highlight(days) {
      this.highlightedDays = days
    },
  },
  mounted() {
    this.$nuxt.$on('month-changed', (newMonth) => (this.monthStart = newMonth))
  },
  methods: {
    dayClasses(day) {
      const classes = {
        today: day.isToday,
        sunday: day.isSunday,
        weekend: day.isWeekend,
        saturday: day.isSaturday,
        'not-current': !day.isCurrentMonth,
        disabled: this.isDayDisabled(day),
        highlighted: this.isDayHighlighted(day),
      }

      return Object.keys(classes).filter((key) => classes[key] === true)
    },
    dayClicked(day) {
      this.$nuxt.$emit('day-clicked', day)
    },
    getEventsForDay(date) {
      return calendarJs.filterEventsForDate(date, this.events)
    },
    isDayDisabled(day) {
      return calendarJs.dateOccursIn(day.date, this.disabledDays)
    },
    isDayHighlighted(day) {
      return calendarJs.dateOccursIn(day.date, this.highlightedDays)
    },
  },
}
</script>

<style lang="scss">
.calendar-body {
  display: grid;
  grid-template-rows: 5% 95%;
}

.days-header {
  display: grid;
  grid-auto-columns: 14.25%;
  grid-template-areas: 'a a a a a a a';
  border-top: 1px solid #e0e0e0;
  border-left: 1px solid #e0e0e0;
  border-bottom: 1px solid #e0e0e0;
}

.days-body {
  display: grid;
  grid-template-rows: auto;
}

.day-number {
  text-align: right;
  margin-right: 10px;
}

.day-label {
  text-align: center;
  border-right: 1px solid #e0e0e0;
}

.week-row {
  display: grid;
  grid-template-areas: 'a a a a a a a';
  grid-row-gap: 5px;
  grid-auto-columns: 14.25%;
  border-left: 1px solid #e0e0e0;
}

.week-day {
  padding: 4px;
  border-right: 1px solid #e0e0e0;
  border-bottom: 1px solid #e0e0e0;
}

.week-day.highlighted {
  background: #ff8e3c;
}

.week-day.sunday > .day-number {
  color: red;
}
.week-day.saturday > .day-number {
  color: #4d4dff;
}

.week-day.disabled {
  background-color: rgb(245, 245, 245);
  pointer-events: none;
}

.week-day.disabled > .day-number {
  opacity: 0.25;
}
.week-day.not-current {
  pointer-events: none;
}
.week-day.not-current > .day-number {
  color: rgb(195, 195, 195);
}

.week-day.today > .day-number {
  font-weight: 700;
  font-size: 1.5rem;
}
</style>
