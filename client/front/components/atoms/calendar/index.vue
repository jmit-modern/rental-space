<template>
  <div :class="[wrapperClass, 'vue-calendar']">
    <calendar-header :disable="disabledDays"> </calendar-header>

    <calendar-body
      :events="calendarEvents"
      :disable="disabledDays"
      :highlight="highlightedDays"
      :display-show-more-count="displayShowMoreCount"
    >
    </calendar-body>
  </div>
</template>

<script>
import header from '@/components/atoms/calendar/calendar-header'
import body from '@/components/atoms/calendar/calendar-body'

export default {
  name: 'VueCalendar',
  components: {
    'calendar-body': body,
    'calendar-header': header,
  },
  props: {
    events: {
      type: Array,
      default: () => [],
    },
    disable: {
      type: Object,
      default: () => ({}),
    },
    highlight: {
      type: Object,
      default: () => ({}),
    },
    height: {
      type: String,
      default: '500px',
    },
    displayShowMoreCount: {
      type: Boolean,
      default: false,
    },
    classNames: {
      type: String,
      default: '',
    },
  },
  computed: {
    calendarEvents() {
      return this.events
    },
    disabledDays() {
      return this.disable
    },
    highlightedDays() {
      return this.highlight
    },
    wrapperClass() {
      return this.classNames
    },
  },
  watch: {
    events(newEvents) {
      this.calendarEvents = newEvents
    },
    disable(days) {
      this.disabledDays = days
    },
    highlight(days) {
      this.highlightedDays = days
    },
    height() {
      this.updateHeight()
    },
  },
  mounted() {
    this.updateHeight()

    this.$nuxt.$on('show-all', (events) => this.$emit('show-all', events))
    this.$nuxt.$on('day-clicked', (day) => this.$emit('day-clicked', day))
    this.$nuxt.$on('event-clicked', (event) =>
      this.$emit('event-clicked', event)
    )
    this.$nuxt.$on('month-changed', (start, end) =>
      this.$emit('month-changed', start, end)
    )
  },
  methods: {
    updateHeight() {
      const [calendarEl] = document.getElementsByClassName('vue-calendar')
      calendarEl && (calendarEl.style.height = this.height)
    },
  },
}
</script>

<style lang="scss">
.vue-calendar {
  display: grid;
  grid-template-rows: 10% 90%;
  background: #fff;
  margin: 0 auto;
}
</style>
